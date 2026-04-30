const express = require("express");
const cors = require("cors");
const fs = require("fs/promises");
const path = require("path");
const crypto = require("crypto");

const app = express();
const PORT = process.env.PORT || 3000;
const DATA_DIR = path.join(__dirname, "data");
const DATA_FILE = path.join(DATA_DIR, "database.json");

app.use(cors());
app.use(express.json());

const currentUser = { id: "u1", name: "Cosmin", username: "@cosmin" };

const members = [
  currentUser,
  { id: "u2", name: "Andrei", username: "@andrei" },
  { id: "u3", name: "Vlad", username: "@vlad" },
  { id: "u4", name: "Radu", username: "@radu" },
  { id: "u5", name: "Alex", username: "@alex" },
  { id: "u6", name: "Mihai", username: "@mihai" },
  { id: "u7", name: "Darius", username: "@darius" },
  { id: "u8", name: "Ionuț", username: "@ionut" },
  { id: "u9", name: "Tudor", username: "@tudor" },
  { id: "u10", name: "Matei", username: "@matei" }
];

function makeDate(days, hours = 0) {
  const date = new Date();
  date.setDate(date.getDate() + days);
  date.setHours(date.getHours() + hours);
  return date.toISOString();
}

function makeMessage(groupId, senderId, text, minutesAgo) {
  const date = new Date();
  date.setMinutes(date.getMinutes() - minutesAgo);
  return {
    id: createId("m"),
    groupId,
    senderId,
    text,
    createdAt: date.toISOString(),
    type: "text"
  };
}

function createId(prefix) {
  if (crypto.randomUUID) return `${prefix}_${crypto.randomUUID()}`;
  return `${prefix}_${Date.now()}_${Math.floor(Math.random() * 99999)}`;
}

function seedData() {
  return {
    currentUser,
    groups: [
      {
        id: "g1",
        name: "Sports Crew",
        description: "Football, volleyball, basketball and spontaneous hangouts.",
        category: "sport",
        members,
        messages: [
          makeMessage("g1", "u2", "Football on Thursday evening?", 80),
          makeMessage("g1", "u1", "Yes, I’ll create an activity and we’ll see who joins.", 72),
          makeMessage("g1", "u4", "I can after 20:00.", 65),
          makeMessage("g1", "u6", "If we are 10, I’m definitely in.", 50)
        ],
        activities: [
          {
            id: "a1",
            groupId: "g1",
            title: "5v5 Football",
            category: "sport",
            sportType: "football",
            location: "Copou Field",
            description: "Friendly match. The app automatically manages the reserve list.",
            dateTime: makeDate(2, 3),
            minParticipants: 8,
            maxParticipants: 10,
            totalCost: 200,
            organizerId: "u1",
            responses: [
              { userId: "u1", status: "going", updatedAt: makeDate(-1) },
              { userId: "u2", status: "going", updatedAt: makeDate(-1) },
              { userId: "u3", status: "going", updatedAt: makeDate(-1) },
              { userId: "u4", status: "maybe", updatedAt: makeDate(-1) },
              { userId: "u5", status: "notGoing", updatedAt: makeDate(-1) },
              { userId: "u6", status: "going", updatedAt: makeDate(-1) },
              { userId: "u7", status: "going", updatedAt: makeDate(-1) }
            ]
          },
          {
            id: "a2",
            groupId: "g1",
            title: "Volleyball in the Park",
            category: "sport",
            sportType: "volleyball",
            location: "Exhibition Park",
            description: "Casual volleyball, we bring the ball and water.",
            dateTime: makeDate(5, 1),
            minParticipants: 6,
            maxParticipants: 12,
            totalCost: 0,
            organizerId: "u3",
            responses: [
              { userId: "u1", status: "maybe", updatedAt: makeDate(-1) },
              { userId: "u2", status: "going", updatedAt: makeDate(-1) },
              { userId: "u3", status: "going", updatedAt: makeDate(-1) }
            ]
          }
        ]
      },
      {
        id: "g2",
        name: "Weekend Trip",
        description: "Trips, cabins, cars and shared costs.",
        category: "travel",
        members: members.slice(0, 6),
        messages: [
          makeMessage("g2", "u3", "The cabin is available next weekend.", 300),
          makeMessage("g2", "u1", "I’ll create the outing and we’ll see how many we are.", 260),
          makeMessage("g2", "u5", "I can drive one car.", 240)
        ],
        activities: [
          {
            id: "a3",
            groupId: "g2",
            title: "Mountain Cabin",
            category: "travel",
            sportType: "none",
            location: "Vatra Dornei",
            description: "We’ll plan cars, accommodation and shopping.",
            dateTime: makeDate(8, 4),
            minParticipants: 4,
            maxParticipants: 6,
            totalCost: 1200,
            organizerId: "u1",
            responses: [
              { userId: "u1", status: "going", updatedAt: makeDate(-1) },
              { userId: "u2", status: "going", updatedAt: makeDate(-1) },
              { userId: "u3", status: "maybe", updatedAt: makeDate(-1) }
            ]
          }
        ]
      },
      {
        id: "g3",
        name: "Gaming Squad",
        description: "Ranked nights, Discord and small tournaments.",
        category: "gaming",
        members: members.slice(0, 7),
        messages: [
          makeMessage("g3", "u7", "Ranked tonight?", 120),
          makeMessage("g3", "u1", "Yes, I’ll create the lobby at 21:30.", 100)
        ],
        activities: [
          {
            id: "a4",
            groupId: "g3",
            title: "Ranked Night",
            category: "gaming",
            sportType: "none",
            location: "Discord",
            description: "Lobby la 21:30.",
            dateTime: makeDate(1, 2),
            minParticipants: 3,
            maxParticipants: 5,
            totalCost: 0,
            organizerId: "u7",
            responses: [
              { userId: "u1", status: "going", updatedAt: makeDate(-1) },
              { userId: "u2", status: "going", updatedAt: makeDate(-1) },
              { userId: "u5", status: "reserve", updatedAt: makeDate(-1) }
            ]
          }
        ]
      }
    ]
  };
}


let db = seedData();

function normalizeDatabaseShape() {
  if (!db || typeof db !== "object") {
    db = seedData();
  }

  if (!db.currentUser) {
    db.currentUser = currentUser;
  }

  if (!Array.isArray(db.groups)) {
    db.groups = [];
  }

  for (const group of db.groups) {
    if (!Array.isArray(group.members)) {
      group.members = [db.currentUser];
    }

    if (!Array.isArray(group.activities)) {
      group.activities = [];
    }

    if (!Array.isArray(group.messages)) {
      group.messages = [];
    }

    for (const activity of group.activities) {
      if (!Array.isArray(activity.responses)) {
        activity.responses = [];
      }

      if (!activity.minParticipants) {
        activity.minParticipants = Math.min(activity.maxParticipants || 10, 4);
      }

      if (!activity.maxParticipants) {
        activity.maxParticipants = 10;
      }

      if (activity.totalCost === undefined || activity.totalCost === null) {
        activity.totalCost = 0;
      }

      if (!activity.sportType) {
        activity.sportType = activity.category === "sport" ? "football" : "none";
      }

      if (!activity.organizerId) {
        activity.organizerId = db.currentUser.id;
      }
    }

    if (group.messages.length === 0) {
      group.messages.push({
        id: createId("m"),
        groupId: group.id,
        senderId: db.currentUser.id,
        text: "Chat started for this group.",
        createdAt: new Date().toISOString(),
        type: "system"
      });
    }
  }
}


async function loadDb() {
  await fs.mkdir(DATA_DIR, { recursive: true });
  try {
    const raw = await fs.readFile(DATA_FILE, "utf8");
    db = JSON.parse(raw);
    normalizeDatabaseShape();
    await saveDb();
  } catch {
    db = seedData();
    normalizeDatabaseShape();
    await saveDb();
  }
}

async function saveDb() {
  await fs.mkdir(DATA_DIR, { recursive: true });
  await fs.writeFile(DATA_FILE, JSON.stringify(db, null, 2), "utf8");
}

function getGroup(groupId) {
  return db.groups.find((group) => group.id === groupId);
}

function findActivity(activityId) {
  for (const group of db.groups) {
    const activity = group.activities.find((item) => item.id === activityId);
    if (activity) return { group, activity };
  }
  return null;
}

function counts(activity) {
  const responses = Array.isArray(activity.responses) ? activity.responses : [];

  return {
    going: responses.filter((r) => r.status === "going").length,
    maybe: responses.filter((r) => r.status === "maybe").length,
    notGoing: responses.filter((r) => r.status === "notGoing").length,
    reserve: responses.filter((r) => r.status === "reserve").length
  };
}

function computeBusiness(activity) {
  const c = counts(activity);
  const spotsLeft = Math.max(activity.maxParticipants - c.going, 0);
  const missingToConfirm = Math.max(activity.minParticipants - c.going, 0);
  let status = "open";

  if (c.going >= activity.maxParticipants) status = "full";
  else if (c.going >= activity.minParticipants) status = "confirmed";
  else status = "needsPlayers";

  const costPerPerson = c.going > 0 ? activity.totalCost / c.going : 0;

  let smartHint = "Activitatea este deschisă.";
  if (status === "needsPlayers") smartHint = `Mai ai nevoie de ${missingToConfirm} participanți.`;
  if (status === "confirmed") smartHint = `Confirmată. Mai sunt ${spotsLeft} locuri.`;
  if (status === "full") smartHint = "Activitatea este plină. Următorii intră la rezerve.";

  return {
    counts: c,
    spotsLeft,
    missingToConfirm,
    status,
    costPerPerson,
    smartHint
  };
}

function activityWithBusiness(activity) {
  return {
    ...activity,
    business: computeBusiness(activity)
  };
}

function groupWithBusiness(group) {
  const safeMessages = Array.isArray(group.messages) ? group.messages : [];
  const safeActivities = Array.isArray(group.activities) ? group.activities : [];
  const lastMessage = safeMessages.length ? safeMessages[safeMessages.length - 1] : null;

  return {
    ...group,
    messages: safeMessages,
    activities: safeActivities.map(activityWithBusiness),
    unreadCount: group.unreadCount || 0,
    lastMessage
  };
}

function promoteReserveIfPossible(activity) {
  const c = counts(activity);
  if (c.going >= activity.maxParticipants) return null;

  const reserve = activity.responses.find((r) => r.status === "reserve");
  if (!reserve) return null;

  reserve.status = "going";
  reserve.updatedAt = new Date().toISOString();
  return reserve.userId;
}

app.get("/api/health", (req, res) => {
  res.json({ ok: true, app: "CrewHub API V7", time: new Date().toISOString() });
});

app.get("/api/me", (req, res) => {
  res.json(db.currentUser);
});

app.get("/api/groups", (req, res) => {
  res.json(db.groups.map(groupWithBusiness));
});

app.get("/api/groups/:groupId", (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });
  res.json(groupWithBusiness(group));
});

app.post("/api/groups", async (req, res) => {
  const { name, description, category } = req.body;
  if (!name || !String(name).trim()) {
    return res.status(400).json({ error: "Name is required" });
  }

  const group = {
    id: createId("g"),
    name: String(name).trim(),
    description: description && String(description).trim()
      ? String(description).trim()
      : "Group created in CrewHub.",
    category: category || "social",
    members: [db.currentUser],
    messages: [
      {
        id: createId("m"),
        groupId: "",
        senderId: db.currentUser.id,
        text: "Group created. Let’s plan the first outing!",
        createdAt: new Date().toISOString(),
        type: "system"
      }
    ],
    activities: []
  };

  group.messages[0].groupId = group.id;
  db.groups.unshift(group);
  await saveDb();
  res.status(201).json(groupWithBusiness(group));
});

app.post("/api/groups/:groupId/activities", async (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });

  const {
    title,
    category,
    sportType,
    location,
    description,
    dateTime,
    minParticipants,
    maxParticipants,
    totalCost
  } = req.body;

  if (!title || !String(title).trim()) {
    return res.status(400).json({ error: "Title is required" });
  }

  const max = Number(maxParticipants) > 0 ? Number(maxParticipants) : 10;
  const min = Number(minParticipants) > 0 ? Number(minParticipants) : Math.min(max, 4);

  const activity = {
    id: createId("a"),
    groupId: group.id,
    title: String(title).trim(),
    category: category || group.category,
    sportType: sportType || "none",
    location: location && String(location).trim() ? String(location).trim() : "Location not set",
    description: description && String(description).trim() ? String(description).trim() : "Activity created in CrewHub.",
    dateTime: dateTime || new Date().toISOString(),
    minParticipants: Math.min(min, max),
    maxParticipants: max,
    totalCost: Number(totalCost) >= 0 ? Number(totalCost) : 0,
    organizerId: db.currentUser.id,
    responses: [
      { userId: db.currentUser.id, status: "going", updatedAt: new Date().toISOString() }
    ]
  };

  group.activities.unshift(activity);
  group.messages.push({
    id: createId("m"),
    groupId: group.id,
    senderId: db.currentUser.id,
    text: `Created activity: ${activity.title}`,
    createdAt: new Date().toISOString(),
    type: "activity"
  });

  await saveDb();
  res.status(201).json(activityWithBusiness(activity));
});

app.patch("/api/activities/:activityId/rsvp", async (req, res) => {
  const found = findActivity(req.params.activityId);
  if (!found) return res.status(404).json({ error: "Activity not found" });

  const { activity, group } = found;
  const userId = req.body.userId || db.currentUser.id;
  const requestedStatus = req.body.status;

  const allowed = ["going", "maybe", "notGoing", "reserve"];
  if (!allowed.includes(requestedStatus)) {
    return res.status(400).json({ error: "Invalid status" });
  }

  const existing = activity.responses.find((r) => r.userId === userId);
  const wasGoing = existing && existing.status === "going";

  let finalStatus = requestedStatus;
  if (requestedStatus === "going" && counts(activity).going >= activity.maxParticipants && !wasGoing) {
    finalStatus = "reserve";
  }

  if (existing) {
    existing.status = finalStatus;
    existing.updatedAt = new Date().toISOString();
  } else {
    activity.responses.push({ userId, status: finalStatus, updatedAt: new Date().toISOString() });
  }

  if (wasGoing && finalStatus !== "going") {
    promoteReserveIfPossible(activity);
  }

  group.messages.push({
    id: createId("m"),
    groupId: group.id,
    senderId: userId,
    text: `Status for "${activity.title}": ${finalStatus}`,
    createdAt: new Date().toISOString(),
    type: "rsvp"
  });

  await saveDb();
  res.json(activityWithBusiness(activity));
});

app.get("/api/groups/:groupId/messages", (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });
  res.json(group.messages);
});

app.post("/api/groups/:groupId/messages", async (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });

  const text = req.body.text && String(req.body.text).trim();
  if (!text) return res.status(400).json({ error: "Text is required" });

  const message = {
    id: createId("m"),
    groupId: group.id,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    createdAt: new Date().toISOString(),
    type: "text"
  };

  group.messages.push(message);
  await saveDb();
  res.status(201).json(message);
});


app.get("/api/messages/:groupId", (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });
  res.json(group.messages);
});

app.post("/api/messages/:groupId", async (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });

  const text = req.body.text && String(req.body.text).trim();
  if (!text) return res.status(400).json({ error: "Text is required" });

  const message = {
    id: createId("m"),
    groupId: group.id,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    createdAt: new Date().toISOString(),
    type: "text"
  };

  group.messages.push(message);
  await saveDb();
  res.status(201).json(message);
});

app.get("/api/inbox", (req, res) => {
  const inbox = db.groups.map((group) => {
    const lastMessage = group.messages.length ? group.messages[group.messages.length - 1] : null;
    return {
      groupId: group.id,
      groupName: group.name,
      category: group.category,
      memberCount: group.members.length,
      lastMessage,
      unreadCount: 0
    };
  });

  res.json(inbox);
});

app.post("/api/reset", async (req, res) => {
  db = seedData();
  await saveDb();
  res.json({ ok: true });
});

loadDb().then(() => {
  app.listen(PORT, () => {
    console.log(`CrewHub API V7 running on http://localhost:${PORT}`);
    console.log(`Health: http://localhost:${PORT}/api/health`);
  });
});
