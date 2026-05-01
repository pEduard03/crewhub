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
<<<<<<< HEAD
app.use(express.json({ limit: "10mb" }));

const currentUser = { id: "u1", name: "Cosmin", username: "@cosmin" };

const romaniaRegions = [
  { id: "ro_ne", name: "Nord-Est", counties: ["Bacău", "Botoșani", "Iași", "Neamț", "Suceava", "Vaslui"] },
  { id: "ro_se", name: "Sud-Est", counties: ["Brăila", "Buzău", "Constanța", "Galați", "Tulcea", "Vrancea"] },
  { id: "ro_s", name: "Sud-Muntenia", counties: ["Argeș", "Călărași", "Dâmbovița", "Giurgiu", "Ialomița", "Prahova", "Teleorman"] },
  { id: "ro_sv", name: "Sud-Vest Oltenia", counties: ["Dolj", "Gorj", "Mehedinți", "Olt", "Vâlcea"] },
  { id: "ro_v", name: "Vest", counties: ["Arad", "Caraș-Severin", "Hunedoara", "Timiș"] },
  { id: "ro_nv", name: "Nord-Vest", counties: ["Bihor", "Bistrița-Năsăud", "Cluj", "Maramureș", "Satu Mare", "Sălaj"] },
  { id: "ro_centru", name: "Centru", counties: ["Alba", "Brașov", "Covasna", "Harghita", "Mureș", "Sibiu"] },
  { id: "ro_bi", name: "București-Ilfov", counties: ["București", "Ilfov"] }
];

const romaniaCities = [
  "Abrud",
  "Adjud",
  "Agnita",
  "Aiud",
  "Alba Iulia",
  "Aleșd",
  "Alexandria",
  "Amara",
  "Anina",
  "Aninoasa",
  "Arad",
  "Ardud",
  "Avrig",
  "Azuga",
  "Babadag",
  "Băbeni",
  "Bacău",
  "Baia de Aramă",
  "Baia de Arieș",
  "Baia Mare",
  "Baia Sprie",
  "Băicoi",
  "Băile Govora",
  "Băile Herculane",
  "Băile Olănești",
  "Băile Tușnad",
  "Bălan",
  "Bălcești",
  "Balș",
  "Baraolt",
  "Bârlad",
  "Bechet",
  "Beclean",
  "Beiuș",
  "Berbești",
  "Berești",
  "Bicaz",
  "Bistrița",
  "Blaj",
  "Bocșa",
  "Boldești-Scăeni",
  "Bolintin-Vale",
  "Borșa",
  "Borsec",
  "Botoșani",
  "Brad",
  "Bragadiru",
  "Brăila",
  "Brașov",
  "Breaza",
  "Brezoi",
  "Broșteni",
  "Bucecea",
  "București",
  "Budești",
  "Buftea",
  "Buhuși",
  "Bumbești-Jiu",
  "Bușteni",
  "Buzău",
  "Buziaș",
  "Cajvana",
  "Calafat",
  "Călan",
  "Călărași",
  "Călimănești",
  "Câmpeni",
  "Câmpia Turzii",
  "Câmpina",
  "Câmpulung",
  "Câmpulung Moldovenesc",
  "Caracal",
  "Caransebeș",
  "Carei",
  "Cavnic",
  "Căzănești",
  "Cehu Silvaniei",
  "Cernavodă",
  "Chișineu-Criș",
  "Chitila",
  "Ciacova",
  "Cisnădie",
  "Cluj-Napoca",
  "Codlea",
  "Comănești",
  "Comarnic",
  "Constanța",
  "Copșa Mică",
  "Corabia",
  "Costești",
  "Covasna",
  "Craiova",
  "Cristuru Secuiesc",
  "Cugir",
  "Curtea de Argeș",
  "Curtici",
  "Dăbuleni",
  "Darabani",
  "Dărmănești",
  "Dej",
  "Deta",
  "Deva",
  "Dolhasca",
  "Dorohoi",
  "Drăgănești-Olt",
  "Drăgășani",
  "Dragomirești",
  "Drobeta-Turnu Severin",
  "Dumbrăveni",
  "Eforie",
  "Făgăraș",
  "Făget",
  "Fălticeni",
  "Făurei",
  "Fetești",
  "Fieni",
  "Fierbinți-Târg",
  "Filiași",
  "Flămânzi",
  "Focșani",
  "Frasin",
  "Fundulea",
  "Găești",
  "Galați",
  "Gătaia",
  "Geoagiu",
  "Gheorgheni",
  "Gherla",
  "Ghimbav",
  "Giurgiu",
  "Gura Humorului",
  "Hârlău",
  "Hârșova",
  "Hațeg",
  "Horezu",
  "Huedin",
  "Hunedoara",
  "Huși",
  "Ianca",
  "Iași",
  "Iernut",
  "Ineu",
  "Însurăței",
  "Întorsura Buzăului",
  "Isaccea",
  "Jibou",
  "Jimbolia",
  "Lehliu Gară",
  "Lipova",
  "Liteni",
  "Livada",
  "Luduș",
  "Lugoj",
  "Lupeni",
  "Măcin",
  "Măgurele",
  "Mangalia",
  "Mărășești",
  "Marghita",
  "Medgidia",
  "Mediaș",
  "Miercurea Ciuc",
  "Miercurea Nirajului",
  "Miercurea Sibiului",
  "Mihăilești",
  "Milișăuți",
  "Mioveni",
  "Mizil",
  "Moinești",
  "Moldova Nouă",
  "Moreni",
  "Motru",
  "Murfatlar",
  "Murgeni",
  "Nădlac",
  "Năsăud",
  "Năvodari",
  "Negrești",
  "Negrești-Oaș",
  "Negru Vodă",
  "Nehoiu",
  "Novaci",
  "Nucet",
  "Ocna Mureș",
  "Ocna Sibiului",
  "Ocnele Mari",
  "Odobești",
  "Odorheiu Secuiesc",
  "Oltenița",
  "Onești",
  "Oradea",
  "Orăștie",
  "Oravița",
  "Orșova",
  "Oțelu Roșu",
  "Otopeni",
  "Ovidiu",
  "Panciu",
  "Pâncota",
  "Pantelimon",
  "Pașcani",
  "Pătârlagele",
  "Pecica",
  "Petrila",
  "Petroșani",
  "Piatra Neamț",
  "Piatra-Olt",
  "Pitești",
  "Ploiești",
  "Plopeni",
  "Podu Iloaiei",
  "Pogoanele",
  "Popești-Leordeni",
  "Potcoava",
  "Predeal",
  "Pucioasa",
  "Răcari",
  "Rădăuți",
  "Râmnicu Sărat",
  "Râmnicu Vâlcea",
  "Râșnov",
  "Recaș",
  "Reghin",
  "Reșița",
  "Roman",
  "Roșiorii de Vede",
  "Rovinari",
  "Roznov",
  "Rupea",
  "Săcele",
  "Săcueni",
  "Salcea",
  "Săliște",
  "Săliștea de Sus",
  "Salonta",
  "Sângeorgiu de Pădure",
  "Sângeorz-Băi",
  "Sânnicolau Mare",
  "Sântana",
  "Sărmașu",
  "Satu Mare",
  "Săveni",
  "Scornicești",
  "Sebeș",
  "Sebiș",
  "Segarcea",
  "Seini",
  "Sfântu Gheorghe",
  "Sibiu",
  "Sighetu Marmației",
  "Sighișoara",
  "Simeria",
  "Șimleu Silvaniei",
  "Sinaia",
  "Siret",
  "Slănic",
  "Slănic Moldova",
  "Slatina",
  "Slobozia",
  "Solca",
  "Șomcuta Mare",
  "Sovata",
  "Ștefănești",
  "Ștei",
  "Strehaia",
  "Suceava",
  "Sulina",
  "Tălmaciu",
  "Țăndărei",
  "Târgoviște",
  "Târgu Bujor",
  "Târgu Cărbunești",
  "Târgu Frumos",
  "Târgu Jiu",
  "Târgu Lăpuș",
  "Târgu Mureș",
  "Târgu Neamț",
  "Târgu Ocna",
  "Târgu Secuiesc",
  "Târnăveni",
  "Tășnad",
  "Tăuții-Măgherăuș",
  "Techirghiol",
  "Tecuci",
  "Teiuș",
  "Țicleni",
  "Timișoara",
  "Tismana",
  "Titu",
  "Toplița",
  "Topoloveni",
  "Tulcea",
  "Turceni",
  "Turda",
  "Turnu Măgurele",
  "Ulmeni",
  "Ungheni",
  "Uricani",
  "Urlați",
  "Urziceni",
  "Valea lui Mihai",
  "Vălenii de Munte",
  "Vânju Mare",
  "Vașcău",
  "Vaslui",
  "Vatra Dornei",
  "Vicovu de Sus",
  "Victoria",
  "Videle",
  "Vișeu de Sus",
  "Vlăhița",
  "Voluntari",
  "Vulcan",
  "Zalău",
  "Zărnești",
  "Zimnicea",
  "Zlatna"
];

function normalizeText(value) {
  return String(value || "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");
}



=======
app.use(express.json());

const currentUser = { id: "u1", name: "Cosmin", username: "@cosmin" };

>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
    users: [
      {
        id: "u1",
        name: "Cosmin",
        username: "@cosmin",
        email: "cosmin@example.com",
        password: "password123",
        provider: "email",
        selectedCities: [],
        gender: "",
        bio: "",
        avatarData: "",
        socialLinks: {}
      }
    ],
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
            country: "Romania",
            region: "Nord-Est",
            county: "Iași",
            city: "Iași",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
            country: "Romania",
            region: "Nord-Est",
            county: "Iași",
            city: "Iași",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
            country: "Romania",
            region: "Nord-Est",
            county: "Suceava",
            city: "Vatra Dornei",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
            country: "Romania",
            region: "București-Ilfov",
            county: "București",
            city: "Online",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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

<<<<<<< HEAD
function publicUser(user) {
  return {
    id: user.id,
    name: user.name,
    username: user.username,
    selectedCities: Array.isArray(user.selectedCities) ? user.selectedCities : [],
    gender: user.gender || "",
    bio: user.bio || "",
    avatarData: user.avatarData || "",
    socialLinks: user.socialLinks && typeof user.socialLinks === "object" ? user.socialLinks : {}
  };
}

function usernameFromEmail(email) {
  const base = String(email || "user")
    .split("@")[0]
    .toLowerCase()
    .replace(/[^a-z0-9_]/g, "");

  return `@${base || "user"}`;
}

function isValidEmail(email) {
  const value = String(email || "").trim().toLowerCase();

  if (value.length < 6 || value.length > 254) {
    return false;
  }

  return /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(value);
}

function ensureUsersShape() {
  if (!Array.isArray(db.users)) {
    db.users = [];
  }

  const existingCurrentId = db.currentUser && db.currentUser.id;
  const hasCurrent = existingCurrentId && db.users.some((user) => user.id === existingCurrentId);

  if (!hasCurrent && db.currentUser) {
    db.users.push({
      id: db.currentUser.id || createId("u"),
      name: db.currentUser.name || "Demo User",
      username: db.currentUser.username || "@demo",
      email: "demo@crewhub.app",
      password: "password123",
      provider: "email",
      selectedCities: [],
      gender: "",
      bio: "",
      avatarData: "",
      socialLinks: {}
    });
  }

  if (db.users.length === 0) {
    db.users.push({
      id: "u1",
      name: "Cosmin",
      username: "@cosmin",
      email: "cosmin@example.com",
      password: "password123",
      provider: "email",
      selectedCities: [],
      gender: "",
      bio: "",
      avatarData: "",
      socialLinks: {}
    });
  }

  for (const user of db.users) {
    if (!Array.isArray(user.selectedCities)) {
      user.selectedCities = [];
    }

    if (!user.gender) {
      user.gender = "";
    }

    if (!user.bio) {
      user.bio = "";
    }

    if (!user.avatarData) {
      user.avatarData = "";
    }

    if (!user.socialLinks || typeof user.socialLinks !== "object") {
      user.socialLinks = {};
    }
  }

  db.currentUser = publicUser(db.users[0]);
}

function ensureUserInGroups(user) {
  const member = publicUser(user);

  for (const group of db.groups || []) {
    if (!Array.isArray(group.members)) {
      group.members = [];
    }

    const index = group.members.findIndex((item) => item.id === member.id);
    if (index >= 0) {
      group.members[index] = {
        ...group.members[index],
        ...member
      };
    } else {
      group.members.push(member);
    }
  }
}

function setCurrentUser(user) {
  db.currentUser = publicUser(user);
  ensureUserInGroups(user);
}

function enrichedMembers(members) {
  const safeMembers = Array.isArray(members) ? members : [];

  return safeMembers.map((member) => {
    const fullUser = db.users.find((user) => user.id === member.id);
    if (!fullUser) return member;

    return {
      ...member,
      ...publicUser(fullUser)
    };
  });
}

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
function normalizeDatabaseShape() {
  if (!db || typeof db !== "object") {
    db = seedData();
  }

  if (!db.currentUser) {
    db.currentUser = currentUser;
  }

<<<<<<< HEAD
  ensureUsersShape();

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
  if (!Array.isArray(db.groups)) {
    db.groups = [];
  }

  for (const group of db.groups) {
<<<<<<< HEAD
    if (!group.socialSubtype) {
      group.socialSubtype = "";
    }

    if (!group.country) {
      group.country = "Romania";
    }

    if (!group.city) {
      group.city = "";
    }

    if (!group.location) {
      group.location = "";
    }

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
    if (!Array.isArray(group.members)) {
      group.members = [db.currentUser];
    }

    if (!Array.isArray(group.activities)) {
      group.activities = [];
    }

    if (!Array.isArray(group.messages)) {
      group.messages = [];
    }

<<<<<<< HEAD
    for (const message of group.messages) {
      normalizeMessageFields(message, group.id);
    }

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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

<<<<<<< HEAD
      if (!activity.country) activity.country = "Romania";
      if (!activity.region) activity.region = "București-Ilfov";
      if (!activity.county) activity.county = "București";
      if (activity.city === undefined || activity.city === null) activity.city = "";

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
        type: "system",
        replyToMessageId: null,
        reactions: [],
        hiddenForUserIds: []
=======
        type: "system"
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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

<<<<<<< HEAD
function normalizeMessageFields(message, groupId) {
  if (!message.id) {
    message.id = createId("m");
  }

  if (!message.groupId) {
    message.groupId = groupId;
  }

  if (!message.createdAt) {
    message.createdAt = new Date().toISOString();
  }

  if (!message.type) {
    message.type = "text";
  }

  if (message.replyToMessageId === undefined) {
    message.replyToMessageId = null;
  }

  if (!Array.isArray(message.reactions)) {
    message.reactions = [];
  }

  if (!Array.isArray(message.hiddenForUserIds)) {
    message.hiddenForUserIds = [];
  }

  message.hiddenForUserIds = message.hiddenForUserIds.map((id) => String(id));

  message.reactions = message.reactions
    .filter((reaction) => reaction && reaction.userId && reaction.emoji)
    .map((reaction) => ({
      userId: String(reaction.userId),
      emoji: String(reaction.emoji),
      createdAt: reaction.createdAt || new Date().toISOString()
    }));
}

function findMessage(messageId) {
  for (const group of db.groups) {
    if (!Array.isArray(group.messages)) continue;

    const message = group.messages.find((item) => item.id === messageId);
    if (message) return { group, message };
  }

  return null;
}

function makeChatMessage({ group, senderId, text, type = "text", replyToMessageId = null }) {
  return {
    id: createId("m"),
    groupId: group.id,
    senderId,
    text,
    createdAt: new Date().toISOString(),
    type,
    replyToMessageId,
    reactions: [],
    hiddenForUserIds: []
  };
}

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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

<<<<<<< HEAD
  let smartHint = "Activity is open.";
  if (status === "needsPlayers") smartHint = `Need ${missingToConfirm} more participants.`;
  if (status === "confirmed") smartHint = `Confirmed. ${spotsLeft} spots left.`;
  if (status === "full") smartHint = "Activity is full. New members go to reserves.";
=======
  let smartHint = "Activitatea este deschisă.";
  if (status === "needsPlayers") smartHint = `Mai ai nevoie de ${missingToConfirm} participanți.`;
  if (status === "confirmed") smartHint = `Confirmată. Mai sunt ${spotsLeft} locuri.`;
  if (status === "full") smartHint = "Activitatea este plină. Următorii intră la rezerve.";
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

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
<<<<<<< HEAD
    members: enrichedMembers(group.members),
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
  res.json({ ok: true, app: "CrewHub API V25", time: new Date().toISOString() });
});

app.get("/api/locations/romania", (req, res) => {
  res.json({ country: "Romania", regions: romaniaRegions });
});

app.get("/api/locations/romania/cities", (req, res) => {
  const search = normalizeText(req.query.search || "");
  const cities = romaniaCities
    .filter((city) => {
      const normalizedCity = normalizeText(city);
      if (!search) return true;
      if (search.length === 1) return normalizedCity.startsWith(search);
      return normalizedCity.startsWith(search) || normalizedCity.includes(search);
    })
    .slice(0, 200);

  res.json({
    country: "Romania",
    cities
  });
});

app.post("/api/users/me/cities", async (req, res) => {
  const selectedCities = Array.isArray(req.body.cities)
    ? req.body.cities.map((city) => String(city).trim()).filter(Boolean)
    : [];

  if (selectedCities.length === 0) {
    return res.status(400).json({ error: "Select at least one city" });
  }

  const validCities = selectedCities.filter((city) => {
    return romaniaCities.some((knownCity) => normalizeText(knownCity) === normalizeText(city));
  });

  if (validCities.length === 0) {
    return res.status(400).json({ error: "No valid Romanian city selected" });
  }

  const currentUserId = db.currentUser && db.currentUser.id;
  const user = db.users.find((item) => item.id === currentUserId) || db.users[0];

  user.selectedCities = [...new Set(validCities)];
  setCurrentUser(user);
  await saveDb();

  res.json(publicUser(user));
});


app.patch("/api/users/me/profile", async (req, res) => {
  const currentUserId = db.currentUser && db.currentUser.id;
  const user = db.users.find((item) => item.id === currentUserId) || db.users[0];

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  const allowedGenders = ["", "male", "female", "other", "preferNotToSay"];
  const gender = req.body.gender !== undefined ? String(req.body.gender) : user.gender || "";

  if (!allowedGenders.includes(gender)) {
    return res.status(400).json({ error: "Invalid gender" });
  }

  const bio = req.body.bio !== undefined ? String(req.body.bio).trim() : user.bio || "";
  const avatarData = req.body.avatarData !== undefined ? String(req.body.avatarData) : user.avatarData || "";
  const incomingLinks = req.body.socialLinks && typeof req.body.socialLinks === "object" ? req.body.socialLinks : user.socialLinks || {};

  const cleanLinks = {};
  for (const key of ["instagram", "facebook", "tiktok", "linkedin", "website"]) {
    cleanLinks[key] = incomingLinks[key] ? String(incomingLinks[key]).trim() : "";
  }

  user.gender = gender;
  user.bio = bio.slice(0, 500);
  user.avatarData = avatarData;
  user.socialLinks = cleanLinks;

  setCurrentUser(user);
  await saveDb();

  res.json(publicUser(user));
});



app.post("/api/auth/logout", async (req, res) => {
  res.json({ ok: true });
});

app.post("/api/auth/register", async (req, res) => {
  const name = req.body.name && String(req.body.name).trim();
  const email = req.body.email && String(req.body.email).trim().toLowerCase();
  const password = req.body.password && String(req.body.password);

  if (!name || !email || !password) {
    return res.status(400).json({ error: "Name, email and password are required" });
  }

  if (!isValidEmail(email)) {
    return res.status(400).json({ error: "Please enter a valid email address" });
  }

  if (password.length < 6) {
    return res.status(400).json({ error: "Password must have at least 6 characters" });
  }

  const existing = db.users.find((user) => user.email === email);
  if (existing) {
    return res.status(409).json({ error: "Email already registered" });
  }

  const user = {
    id: createId("u"),
    name,
    username: usernameFromEmail(email),
    email,
    password,
    provider: "email",
    selectedCities: [],
    gender: "",
    bio: "",
    avatarData: "",
    socialLinks: {}
  };

  db.users.push(user);
  setCurrentUser(user);
  await saveDb();

  res.status(201).json(publicUser(user));
});

app.post("/api/auth/login", async (req, res) => {
  const email = req.body.email && String(req.body.email).trim().toLowerCase();
  const password = req.body.password && String(req.body.password);

  if (!email || !password) {
    return res.status(400).json({ error: "Email and password are required" });
  }

  if (!isValidEmail(email)) {
    return res.status(400).json({ error: "Please enter a valid email address" });
  }

  const user = db.users.find((item) => item.email === email && item.password === password);

  if (!user) {
    return res.status(401).json({ error: "Invalid email or password" });
  }

  setCurrentUser(user);
  await saveDb();

  res.json(publicUser(user));
});

app.post("/api/auth/google-demo", async (req, res) => {
  const email = "google.demo@crewhub.app";
  let user = db.users.find((item) => item.email === email);

  if (!user) {
    user = {
      id: createId("u"),
      name: "Google Demo User",
      username: "@google_demo",
      email,
      password: "",
      provider: "google-demo",
      selectedCities: []
    };
    db.users.push(user);
  }

  setCurrentUser(user);
  await saveDb();

  res.json(publicUser(user));
});


=======
  res.json({ ok: true, app: "CrewHub API V7", time: new Date().toISOString() });
});

>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
  const { name, description, category, socialSubtype, country, city, location } = req.body;
=======
  const { name, description, category } = req.body;
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
    socialSubtype: socialSubtype && String(socialSubtype).trim() ? String(socialSubtype).trim() : "",
    country: country || "Romania",
    city: city && String(city).trim() ? String(city).trim() : "",
    location: location && String(location).trim() ? String(location).trim() : "",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
    members: [db.currentUser],
    messages: [
      {
        id: createId("m"),
        groupId: "",
        senderId: db.currentUser.id,
        text: "Group created. Let’s plan the first outing!",
        createdAt: new Date().toISOString(),
<<<<<<< HEAD
        type: "system",
        replyToMessageId: null,
        reactions: [],
        hiddenForUserIds: []
=======
        type: "system"
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
    country,
    region,
    county,
    city,
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
    country: country || "Romania",
    region: region || "București-Ilfov",
    county: county || "București",
    city: city && String(city).trim() ? String(city).trim() : "",
=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
  group.messages.push(makeChatMessage({
    group,
    senderId: db.currentUser.id,
    text: `Created activity: ${activity.title}`,
    type: "activity"
  }));
=======
  group.messages.push({
    id: createId("m"),
    groupId: group.id,
    senderId: db.currentUser.id,
    text: `Created activity: ${activity.title}`,
    createdAt: new Date().toISOString(),
    type: "activity"
  });
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

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

<<<<<<< HEAD
  group.messages.push(makeChatMessage({
    group,
    senderId: userId,
    text: `Status for "${activity.title}": ${finalStatus}`,
    type: "rsvp"
  }));
=======
  group.messages.push({
    id: createId("m"),
    groupId: group.id,
    senderId: userId,
    text: `Status for "${activity.title}": ${finalStatus}`,
    createdAt: new Date().toISOString(),
    type: "rsvp"
  });
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

  await saveDb();
  res.json(activityWithBusiness(activity));
});

app.get("/api/groups/:groupId/messages", (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });
<<<<<<< HEAD

  const userId = req.query.userId ? String(req.query.userId) : db.currentUser.id;
  const messages = group.messages.filter((message) => {
    normalizeMessageFields(message, group.id);
    return !message.hiddenForUserIds.includes(userId);
  });

  res.json(messages);
=======
  res.json(group.messages);
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
});

app.post("/api/groups/:groupId/messages", async (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });

  const text = req.body.text && String(req.body.text).trim();
  if (!text) return res.status(400).json({ error: "Text is required" });

<<<<<<< HEAD
  const replyToMessageId = req.body.replyToMessageId ? String(req.body.replyToMessageId) : null;
  if (replyToMessageId && !group.messages.some((item) => item.id === replyToMessageId)) {
    return res.status(400).json({ error: "Reply target not found in this group" });
  }

  const message = makeChatMessage({
    group,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    type: "text",
    replyToMessageId
  });
=======
  const message = {
    id: createId("m"),
    groupId: group.id,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    createdAt: new Date().toISOString(),
    type: "text"
  };
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

  group.messages.push(message);
  await saveDb();
  res.status(201).json(message);
});


app.get("/api/messages/:groupId", (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });
<<<<<<< HEAD

  const userId = req.query.userId ? String(req.query.userId) : db.currentUser.id;
  const messages = group.messages.filter((message) => {
    normalizeMessageFields(message, group.id);
    return !message.hiddenForUserIds.includes(userId);
  });

  res.json(messages);
=======
  res.json(group.messages);
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
});

app.post("/api/messages/:groupId", async (req, res) => {
  const group = getGroup(req.params.groupId);
  if (!group) return res.status(404).json({ error: "Group not found" });

  const text = req.body.text && String(req.body.text).trim();
  if (!text) return res.status(400).json({ error: "Text is required" });

<<<<<<< HEAD
  const replyToMessageId = req.body.replyToMessageId ? String(req.body.replyToMessageId) : null;
  if (replyToMessageId && !group.messages.some((item) => item.id === replyToMessageId)) {
    return res.status(400).json({ error: "Reply target not found in this group" });
  }

  const message = makeChatMessage({
    group,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    type: "text",
    replyToMessageId
  });
=======
  const message = {
    id: createId("m"),
    groupId: group.id,
    senderId: req.body.senderId || db.currentUser.id,
    text,
    createdAt: new Date().toISOString(),
    type: "text"
  };
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d

  group.messages.push(message);
  await saveDb();
  res.status(201).json(message);
});

<<<<<<< HEAD


app.patch("/api/messages/:messageId/delete-for-me", async (req, res) => {
  const found = findMessage(req.params.messageId);
  if (!found) return res.status(404).json({ error: "Message not found" });

  const userId = req.body.userId ? String(req.body.userId) : db.currentUser.id;

  normalizeMessageFields(found.message, found.group.id);

  if (!found.message.hiddenForUserIds.includes(userId)) {
    found.message.hiddenForUserIds.push(userId);
  }

  await saveDb();

  res.json({ ok: true, messageId: found.message.id });
});

app.patch("/api/messages/:messageId/reaction", async (req, res) => {
  const found = findMessage(req.params.messageId);
  if (!found) return res.status(404).json({ error: "Message not found" });

  const userId = req.body.userId ? String(req.body.userId) : db.currentUser.id;
  const emoji = req.body.emoji ? String(req.body.emoji).trim() : "";

  const allowedEmojis = ["❤️", "😂", "🔥", "👍", "😮", "👏"];
  if (!allowedEmojis.includes(emoji)) {
    return res.status(400).json({ error: "Invalid reaction" });
  }

  normalizeMessageFields(found.message, found.group.id);

  const existingIndex = found.message.reactions.findIndex((reaction) => reaction.userId === userId);

  if (existingIndex >= 0 && found.message.reactions[existingIndex].emoji === emoji) {
    found.message.reactions.splice(existingIndex, 1);
  } else if (existingIndex >= 0) {
    found.message.reactions[existingIndex] = {
      userId,
      emoji,
      createdAt: new Date().toISOString()
    };
  } else {
    found.message.reactions.push({
      userId,
      emoji,
      createdAt: new Date().toISOString()
    });
  }

  await saveDb();
  res.json(found.message);
});

=======
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
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
<<<<<<< HEAD
    console.log(`CrewHub API V25 running on http://localhost:${PORT}`);
=======
    console.log(`CrewHub API V7 running on http://localhost:${PORT}`);
>>>>>>> fc7dbce31452fcc05e5a2c33d11d97fc0d710a1d
    console.log(`Health: http://localhost:${PORT}/api/health`);
  });
});
