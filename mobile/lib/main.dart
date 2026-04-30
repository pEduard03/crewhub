import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CrewHubApp());
}

class CrewHubApp extends StatelessWidget {
  const CrewHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF36E6A8);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrewHub V7',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08111F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF08111F),
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF101B2F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF121E33),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:3000/api',
  );
}

enum AppLanguage { en, ro }

enum GroupCategory { sport, social, travel, gaming, study, work, family, custom }

enum RsvpStatus { going, maybe, notGoing, reserve }

enum ActivityStatus { needsPlayers, open, confirmed, full }

class AppText {
  const AppText(this.language);

  final AppLanguage language;

  bool get isRo => language == AppLanguage.ro;

  String get toggleLabel => isRo ? 'EN' : 'RO';
  String get appTitle => 'CrewHub V7';

  String get loginSubtitle => isRo
      ? 'Messenger pentru grupuri + planificator de ieșiri, sport și activități.'
      : 'Messenger for groups + planner for outings, sports and activities.';
  String get groupChat => isRo ? 'Chat pe fiecare grup' : 'Group chat';
  String get groupChatSubtitle => isRo
      ? 'Discuții direct în contextul grupului.'
      : 'Talk directly in the context of each group.';
  String get businessLogic => 'Business logic';
  String get businessLogicSubtitle => isRo
      ? 'Status, rezerve, costuri și locuri calculate automat.'
      : 'Status, reserves, costs and spots calculated automatically.';
  String get localBackend => isRo ? 'Backend local' : 'Local backend';
  String get enterApp => isRo ? 'Intră în aplicație' : 'Enter app';

  String get backendNotResponding => isRo ? 'Backendul nu răspunde' : 'Backend is not responding';
  String get startBackendHelp => isRo
      ? 'Pornește backendul într-un terminal:\ncd backend\nnpm install\nnpm run dev'
      : 'Start the backend in a terminal:\ncd backend\nnpm install\nnpm run dev';
  String get tryAgain => isRo ? 'Încearcă din nou' : 'Try again';
  String get unknownError => isRo ? 'Eroare necunoscută.' : 'Unknown error.';
  String get error => isRo ? 'Eroare' : 'Error';

  String hello(String name) => isRo ? 'Salut, $name!' : 'Hi, $name!';
  String get dashboardSubtitle => isRo
      ? 'Ai chat, RSVP, liste de rezerve și costuri automate în același loc.'
      : 'You have chat, RSVP, reserve lists and automatic costs in one place.';
  String get createGroup => isRo ? 'Creează grup' : 'Create group';
  String groupsCount(int count) => isRo ? '$count grupuri' : '$count groups';
  String membersTotal(int count) => isRo ? '$count membri în total' : '$count members total';
  String outingsCount(int count) => isRo ? '$count ieșiri' : '$count outings';
  String attentionCount(int count) => isRo ? '$count au nevoie de atenție' : '$count need attention';
  String get needsAttention => isRo ? 'Necesită atenție' : 'Needs attention';
  String get allGood => isRo ? 'Totul e ok' : 'All good';
  String get noProblemActivities => isRo
      ? 'Nu ai activități problematice.'
      : 'You have no activities that need attention.';
  String get recentChats => isRo ? 'Chat-uri recente' : 'Recent chats';

  String get home => 'Home';
  String get chat => 'Chat';
  String get groups => isRo ? 'Grupuri' : 'Groups';
  String get outings => isRo ? 'Ieșiri' : 'Outings';
  String get profile => isRo ? 'Profil' : 'Profile';

  String get chatSubtitle => isRo
      ? 'Ca un Messenger pentru grupurile tale.'
      : 'Like Messenger for your groups.';
  String get groupsSubtitle => isRo
      ? 'Toate grupurile salvate în backend.'
      : 'All groups saved in the backend.';
  String get newLabel => isRo ? 'Nou' : 'New';
  String get outingsSubtitle => isRo
      ? 'Fotbal, volei, gaming, excursii și alte planuri.'
      : 'Football, volleyball, gaming, trips and other plans.';
  String get profileSubtitle => isRo ? 'Utilizator demo.' : 'Demo user.';
  String get api => 'API';
  String get persistence => isRo ? 'Persistență' : 'Persistence';
  String get persistenceSubtitle => isRo
      ? 'Date salvate în backend/data/database.json'
      : 'Data saved in backend/data/database.json';

  String members(int count) => isRo ? '$count membri' : '$count members';
  String get membersTitle => isRo ? 'Membri' : 'Members';
  String get copyLink => isRo ? 'Link copiat' : 'Link copied';
  String get openChat => isRo ? 'Deschide chat' : 'Open chat';
  String get createOuting => isRo ? 'Creează ieșire' : 'Create outing';
  String get noOutingsYet => isRo ? 'Nu există ieșiri încă.' : 'No outings yet.';
  String get noMessagesYet => isRo ? 'Niciun mesaj încă.' : 'No messages yet.';
  String get writeMessage => isRo ? 'Scrie un mesaj...' : 'Write a message...';
  String get system => isRo ? 'Sistem' : 'System';

  String get status => 'Status';
  String minMax(int min, int max) => isRo ? 'Minim $min, maxim $max' : 'Minimum $min, maximum $max';
  String get free => isRo ? 'Gratis' : 'Free';
  String costPerPerson(String value) => isRo ? '$value lei / persoană' : '$value lei / person';
  String totalCost(String value) => isRo ? 'Cost total: $value lei' : 'Total cost: $value lei';

  String get going => isRo ? 'Vin' : 'Going';
  String get maybe => isRo ? 'Poate' : 'Maybe';
  String get notGoing => isRo ? 'Nu vin' : 'Not going';
  String get reserve => isRo ? 'Rezervă' : 'Reserve';
  String get unset => isRo ? 'Nesetat' : 'Unset';
  String confirmation(String value) => isRo ? 'Confirmarea ta: $value' : 'Your RSVP: $value';
  String get nobodyYet => isRo ? 'Nimeni momentan.' : 'Nobody yet.';

  String get createGroupTitle => isRo ? 'Creează grup' : 'Create group';
  String get newGroup => isRo ? 'Grup nou' : 'New group';
  String get savedInBackend => isRo ? 'Se salvează în backend.' : 'Saved in the backend.';
  String get groupName => isRo ? 'Nume grup' : 'Group name';
  String get addName => isRo ? 'Adaugă un nume.' : 'Add a name.';
  String get description => isRo ? 'Descriere' : 'Description';
  String get saving => isRo ? 'Se salvează...' : 'Saving...';

  String get createOutingTitle => isRo ? 'Creează ieșire' : 'Create outing';
  String newOutingFor(String group) => isRo ? 'Pentru $group.' : 'For $group.';
  String get title => isRo ? 'Titlu' : 'Title';
  String get addTitle => isRo ? 'Adaugă un titlu.' : 'Add a title.';
  String get location => isRo ? 'Locație' : 'Location';
  String get minParticipants => isRo ? 'Minim participanți' : 'Minimum participants';
  String get maxParticipants => isRo ? 'Maxim participanți' : 'Maximum participants';
  String get invalidNumber => isRo ? 'Număr invalid.' : 'Invalid number.';
  String get minOverMax => isRo
      ? 'Minimul nu poate fi peste maxim.'
      : 'Minimum cannot be greater than maximum.';
  String get totalCostLabel => isRo ? 'Cost total' : 'Total cost';
  String get dateAndTime => isRo ? 'Data și ora' : 'Date and time';
  String get chooseDate => isRo ? 'Alege data' : 'Choose date';
  String get chooseTime => isRo ? 'Alege ora' : 'Choose time';

  String get football => isRo ? 'Fotbal' : 'Football';
  String get volleyball => isRo ? 'Volei' : 'Volleyball';
  String get basketball => isRo ? 'Baschet' : 'Basketball';
  String get tennis => isRo ? 'Tenis' : 'Tennis';
  String get otherSport => isRo ? 'Alt sport' : 'Other sport';

  String categoryLabel(GroupCategory category) {
    switch (category) {
      case GroupCategory.sport:
        return 'Sport';
      case GroupCategory.social:
        return 'Social';
      case GroupCategory.travel:
        return 'Travel';
      case GroupCategory.gaming:
        return 'Gaming';
      case GroupCategory.study:
        return isRo ? 'Studiu' : 'Study';
      case GroupCategory.work:
        return 'Work';
      case GroupCategory.family:
        return isRo ? 'Familie' : 'Family';
      case GroupCategory.custom:
        return 'Custom';
    }
  }

  String rsvpLabel(RsvpStatus? status) {
    switch (status) {
      case RsvpStatus.going:
        return going;
      case RsvpStatus.maybe:
        return maybe;
      case RsvpStatus.notGoing:
        return notGoing;
      case RsvpStatus.reserve:
        return reserve;
      case null:
        return unset;
    }
  }

  String activityStatusLabel(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.needsPlayers:
        return isRo ? 'Mai trebuie oameni' : 'Needs players';
      case ActivityStatus.open:
        return isRo ? 'Deschis' : 'Open';
      case ActivityStatus.confirmed:
        return isRo ? 'Confirmat' : 'Confirmed';
      case ActivityStatus.full:
        return isRo ? 'Plin' : 'Full';
    }
  }
}

GroupCategory categoryFromString(String value) {
  switch (value) {
    case 'sport':
      return GroupCategory.sport;
    case 'travel':
      return GroupCategory.travel;
    case 'gaming':
      return GroupCategory.gaming;
    case 'study':
      return GroupCategory.study;
    case 'work':
      return GroupCategory.work;
    case 'family':
      return GroupCategory.family;
    case 'custom':
      return GroupCategory.custom;
    case 'social':
    default:
      return GroupCategory.social;
  }
}

String categoryToString(GroupCategory value) {
  switch (value) {
    case GroupCategory.sport:
      return 'sport';
    case GroupCategory.social:
      return 'social';
    case GroupCategory.travel:
      return 'travel';
    case GroupCategory.gaming:
      return 'gaming';
    case GroupCategory.study:
      return 'study';
    case GroupCategory.work:
      return 'work';
    case GroupCategory.family:
      return 'family';
    case GroupCategory.custom:
      return 'custom';
  }
}

IconData categoryIcon(GroupCategory value) {
  switch (value) {
    case GroupCategory.sport:
      return Icons.sports_soccer_rounded;
    case GroupCategory.social:
      return Icons.celebration_rounded;
    case GroupCategory.travel:
      return Icons.flight_takeoff_rounded;
    case GroupCategory.gaming:
      return Icons.sports_esports_rounded;
    case GroupCategory.study:
      return Icons.school_rounded;
    case GroupCategory.work:
      return Icons.work_rounded;
    case GroupCategory.family:
      return Icons.family_restroom_rounded;
    case GroupCategory.custom:
      return Icons.auto_awesome_rounded;
  }
}

RsvpStatus rsvpFromString(String value) {
  switch (value) {
    case 'going':
      return RsvpStatus.going;
    case 'maybe':
      return RsvpStatus.maybe;
    case 'notGoing':
      return RsvpStatus.notGoing;
    case 'reserve':
      return RsvpStatus.reserve;
    default:
      return RsvpStatus.maybe;
  }
}

String rsvpToString(RsvpStatus value) {
  switch (value) {
    case RsvpStatus.going:
      return 'going';
    case RsvpStatus.maybe:
      return 'maybe';
    case RsvpStatus.notGoing:
      return 'notGoing';
    case RsvpStatus.reserve:
      return 'reserve';
  }
}

ActivityStatus activityStatusFromString(String value) {
  switch (value) {
    case 'full':
      return ActivityStatus.full;
    case 'confirmed':
      return ActivityStatus.confirmed;
    case 'needsPlayers':
      return ActivityStatus.needsPlayers;
    case 'open':
    default:
      return ActivityStatus.open;
  }
}

String shortDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$day.$month • $hour:$minute';
}

String longDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final year = value.year.toString();
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$day.$month.$year, $hour:$minute';
}

class Member {
  const Member({
    required this.id,
    required this.name,
    required this.username,
  });

  final String id;
  final String name;
  final String username;

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
    );
  }
}

class ChatMessage {
  ChatMessage({
    required this.id,
    required this.groupId,
    required this.senderId,
    required this.text,
    required this.createdAt,
    required this.type,
  });

  final String id;
  final String groupId;
  final String senderId;
  final String text;
  final DateTime createdAt;
  final String type;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id']?.toString() ?? '',
      groupId: json['groupId']?.toString() ?? '',
      senderId: json['senderId']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '')?.toLocal() ?? DateTime.now(),
      type: json['type']?.toString() ?? 'text',
    );
  }
}

class ActivityResponse {
  ActivityResponse({
    required this.userId,
    required this.status,
  });

  final String userId;
  RsvpStatus status;

  factory ActivityResponse.fromJson(Map<String, dynamic> json) {
    return ActivityResponse(
      userId: json['userId']?.toString() ?? '',
      status: rsvpFromString(json['status']?.toString() ?? 'maybe'),
    );
  }
}

class ActivityBusiness {
  ActivityBusiness({
    required this.status,
    required this.spotsLeft,
    required this.missingToConfirm,
    required this.costPerPerson,
    required this.smartHint,
  });

  final ActivityStatus status;
  final int spotsLeft;
  final int missingToConfirm;
  final double costPerPerson;
  final String smartHint;

  factory ActivityBusiness.fromJson(dynamic raw) {
    final json = raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};

    return ActivityBusiness(
      status: activityStatusFromString(json['status']?.toString() ?? 'open'),
      spotsLeft: int.tryParse(json['spotsLeft']?.toString() ?? '') ?? 0,
      missingToConfirm: int.tryParse(json['missingToConfirm']?.toString() ?? '') ?? 0,
      costPerPerson: double.tryParse(json['costPerPerson']?.toString() ?? '') ?? 0,
      smartHint: json['smartHint']?.toString() ?? 'Activity is open.',
    );
  }
}

class Activity {
  Activity({
    required this.id,
    required this.groupId,
    required this.title,
    required this.category,
    required this.sportType,
    required this.location,
    required this.description,
    required this.dateTime,
    required this.minParticipants,
    required this.maxParticipants,
    required this.totalCost,
    required this.responses,
    required this.business,
  });

  final String id;
  final String groupId;
  final String title;
  final GroupCategory category;
  final String sportType;
  final String location;
  final String description;
  final DateTime dateTime;
  final int minParticipants;
  final int maxParticipants;
  final double totalCost;
  final List<ActivityResponse> responses;
  final ActivityBusiness business;

  factory Activity.fromJson(Map<String, dynamic> json) {
    final rawResponses = json['responses'];
    final responseList = rawResponses is List ? rawResponses : <dynamic>[];

    return Activity(
      id: json['id']?.toString() ?? '',
      groupId: json['groupId']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Untitled',
      category: categoryFromString(json['category']?.toString() ?? 'social'),
      sportType: json['sportType']?.toString() ?? 'none',
      location: json['location']?.toString() ?? 'Location not set',
      description: json['description']?.toString() ?? '',
      dateTime: DateTime.tryParse(json['dateTime']?.toString() ?? '')?.toLocal() ?? DateTime.now(),
      minParticipants: int.tryParse(json['minParticipants']?.toString() ?? '') ?? 2,
      maxParticipants: int.tryParse(json['maxParticipants']?.toString() ?? '') ?? 10,
      totalCost: double.tryParse(json['totalCost']?.toString() ?? '') ?? 0,
      responses: responseList
          .whereType<Map<String, dynamic>>()
          .map(ActivityResponse.fromJson)
          .toList(),
      business: ActivityBusiness.fromJson(json['business']),
    );
  }

  int get goingCount => responses.where((item) => item.status == RsvpStatus.going).length;
  int get maybeCount => responses.where((item) => item.status == RsvpStatus.maybe).length;
  int get reserveCount => responses.where((item) => item.status == RsvpStatus.reserve).length;

  RsvpStatus? statusForUser(String userId) {
    final matches = responses.where((item) => item.userId == userId);
    if (matches.isEmpty) return null;
    return matches.first.status;
  }
}

class CrewGroup {
  CrewGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.members,
    required this.activities,
    required this.messages,
    required this.unreadCount,
  });

  final String id;
  final String name;
  final String description;
  final GroupCategory category;
  final List<Member> members;
  final List<Activity> activities;
  final List<ChatMessage> messages;
  final int unreadCount;

  factory CrewGroup.fromJson(Map<String, dynamic> json) {
    final rawMembers = json['members'];
    final rawActivities = json['activities'];
    final rawMessages = json['messages'];

    final members = rawMembers is List ? rawMembers : <dynamic>[];
    final activities = rawActivities is List ? rawActivities : <dynamic>[];
    final messages = rawMessages is List ? rawMessages : <dynamic>[];

    return CrewGroup(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Group',
      description: json['description']?.toString() ?? '',
      category: categoryFromString(json['category']?.toString() ?? 'social'),
      members: members.whereType<Map<String, dynamic>>().map(Member.fromJson).toList(),
      activities: activities.whereType<Map<String, dynamic>>().map(Activity.fromJson).toList(),
      messages: messages.whereType<Map<String, dynamic>>().map(ChatMessage.fromJson).toList(),
      unreadCount: int.tryParse(json['unreadCount']?.toString() ?? '') ?? 0,
    );
  }

  Activity? get nextActivity {
    if (activities.isEmpty) return null;
    final sorted = [...activities];
    sorted.sort((first, second) => first.dateTime.compareTo(second.dateTime));
    return sorted.first;
  }

  ChatMessage? get lastMessage {
    if (messages.isEmpty) return null;
    final sorted = [...messages];
    sorted.sort((first, second) => first.createdAt.compareTo(second.createdAt));
    return sorted.last;
  }

  Member? memberById(String id) {
    for (final member in members) {
      if (member.id == id) return member;
    }
    return null;
  }

  CrewGroup copyWithMessages(List<ChatMessage> newMessages) {
    return CrewGroup(
      id: id,
      name: name,
      description: description,
      category: category,
      members: members,
      activities: activities,
      messages: newMessages,
      unreadCount: unreadCount,
    );
  }
}

class ApiClient {
  Future<Member> getMe() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/me'));
    _check(response);
    return Member.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<CrewGroup>> getGroups() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/groups'));
    _check(response);
    final decoded = jsonDecode(response.body);
    final list = decoded is List ? decoded : <dynamic>[];
    return list.whereType<Map<String, dynamic>>().map(CrewGroup.fromJson).toList();
  }

  Future<CrewGroup> createGroup({
    required String name,
    required String description,
    required GroupCategory category,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/groups'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
        'category': categoryToString(category),
      }),
    );
    _check(response);
    return CrewGroup.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Activity> createActivity({
    required String groupId,
    required String title,
    required GroupCategory category,
    required String sportType,
    required String location,
    required String description,
    required DateTime dateTime,
    required int minParticipants,
    required int maxParticipants,
    required double totalCost,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/groups/$groupId/activities'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'category': categoryToString(category),
        'sportType': sportType,
        'location': location,
        'description': description,
        'dateTime': dateTime.toUtc().toIso8601String(),
        'minParticipants': minParticipants,
        'maxParticipants': maxParticipants,
        'totalCost': totalCost,
      }),
    );
    _check(response);
    return Activity.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<Activity> updateRsvp({
    required String activityId,
    required String userId,
    required RsvpStatus status,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/activities/$activityId/rsvp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'status': rsvpToString(status),
      }),
    );
    _check(response);
    return Activity.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<ChatMessage>> getMessages(String groupId) async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/groups/$groupId/messages'));
    _check(response);
    final decoded = jsonDecode(response.body);
    final list = decoded is List ? decoded : <dynamic>[];
    return list.whereType<Map<String, dynamic>>().map(ChatMessage.fromJson).toList();
  }

  Future<ChatMessage> sendMessage({
    required String groupId,
    required String senderId,
    required String text,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/groups/$groupId/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'senderId': senderId,
        'text': text,
      }),
    );
    _check(response);
    return ChatMessage.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  void _check(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API ${response.statusCode}: ${response.body}');
    }
  }
}

class AppState {
  AppState({required this.user, required this.groups});

  final Member user;
  final List<CrewGroup> groups;

  List<Activity> get activities {
    final items = groups.expand((group) => group.activities).toList();
    items.sort((first, second) => first.dateTime.compareTo(second.dateTime));
    return items;
  }

  List<Activity> get needsAttention {
    return activities.where((activity) {
      return activity.business.status == ActivityStatus.needsPlayers ||
          activity.business.status == ActivityStatus.full ||
          activity.reserveCount > 0;
    }).toList();
  }

  CrewGroup? groupForActivity(Activity activity) {
    for (final group in groups) {
      if (group.id == activity.groupId) return group;
    }
    return null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AppLanguage language = AppLanguage.en;

  AppText get t => AppText(language);

  void toggleLanguage() {
    setState(() {
      language = language == AppLanguage.en ? AppLanguage.ro : AppLanguage.en;
    });
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: toggleLanguage,
            child: Text(t.toggleLabel),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Icon(Icons.forum_rounded, color: accent, size: 54),
              ),
            ),
            const SizedBox(height: 28),
            const Center(
              child: Text(
                'CrewHub',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.loginSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.72), height: 1.45),
            ),
            const SizedBox(height: 48),
            InfoCard(icon: Icons.chat_rounded, title: t.groupChat, subtitle: t.groupChatSubtitle),
            const SizedBox(height: 12),
            InfoCard(icon: Icons.rule_rounded, title: t.businessLogic, subtitle: t.businessLogicSubtitle),
            const SizedBox(height: 12),
            InfoCard(icon: Icons.api_rounded, title: t.localBackend, subtitle: ApiConfig.baseUrl),
            const SizedBox(height: 28),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(initialLanguage: language),
                  ),
                );
              },
              child: Text(t.enterApp),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.initialLanguage});

  final AppLanguage initialLanguage;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final api = ApiClient();

  bool loading = true;
  String? error;
  AppState? data;
  int tab = 0;
  late AppLanguage language;

  AppText get t => AppText(language);

  @override
  void initState() {
    super.initState();
    language = widget.initialLanguage;
    refresh();
  }

  void toggleLanguage() {
    setState(() {
      language = language == AppLanguage.en ? AppLanguage.ro : AppLanguage.en;
    });
  }

  Future<void> refresh() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final user = await api.getMe();
      final groups = await api.getGroups();

      if (!mounted) return;

      setState(() {
        data = AppState(user: user, groups: groups);
        loading = false;
      });
    } catch (exception) {
      if (!mounted) return;
      setState(() {
        error = exception.toString();
        loading = false;
      });
    }
  }

  void addGroup(CrewGroup group) {
    final current = data;
    if (current == null) return;
    setState(() {
      current.groups.insert(0, group);
    });
  }

  void addActivity(Activity activity) {
    final current = data;
    if (current == null) return;

    for (final group in current.groups) {
      if (group.id == activity.groupId) {
        final alreadyExists = group.activities.any((item) => item.id == activity.id);
        if (alreadyExists) return;

        setState(() {
          group.activities.insert(0, activity);
        });
        return;
      }
    }
  }

  void replaceActivity(Activity activity) {
    final current = data;
    if (current == null) return;

    for (final group in current.groups) {
      final index = group.activities.indexWhere((item) => item.id == activity.id);
      if (index >= 0) {
        setState(() {
          group.activities[index] = activity;
        });
        return;
      }
    }
  }

  void replaceMessages(String groupId, List<ChatMessage> messages) {
    final current = data;
    if (current == null) return;

    final index = current.groups.indexWhere((group) => group.id == groupId);
    if (index < 0) return;

    setState(() {
      current.groups[index] = current.groups[index].copyWithMessages(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null || data == null) {
      return BackendErrorScreen(message: error ?? t.unknownError, onRetry: refresh, t: t);
    }

    final appData = data!;

    Widget body;
    if (tab == 0) {
      body = DashboardView(
        data: appData,
        api: api,
        t: t,
        onGroupCreated: addGroup,
        onActivityCreated: addActivity,
        onActivityUpdated: replaceActivity,
        onMessagesChanged: replaceMessages,
      );
    } else if (tab == 1) {
      body = InboxView(
        data: appData,
        api: api,
        t: t,
        onMessagesChanged: replaceMessages,
      );
    } else if (tab == 2) {
      body = GroupsView(
        data: appData,
        api: api,
        t: t,
        onGroupCreated: addGroup,
        onActivityCreated: addActivity,
        onActivityUpdated: replaceActivity,
        onMessagesChanged: replaceMessages,
      );
    } else if (tab == 3) {
      body = ActivitiesView(
        data: appData,
        api: api,
        t: t,
        onActivityUpdated: replaceActivity,
      );
    } else {
      body = ProfileView(user: appData.user, t: t);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CrewHub V7', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [
          TextButton(
            onPressed: toggleLanguage,
            child: Text(t.toggleLabel),
          ),
          IconButton(onPressed: refresh, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) {
          setState(() {
            tab = index;
          });
        },
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home), label: t.home),
          NavigationDestination(icon: const Icon(Icons.chat_bubble_outline), selectedIcon: const Icon(Icons.chat_bubble), label: t.chat),
          NavigationDestination(icon: const Icon(Icons.groups_outlined), selectedIcon: const Icon(Icons.groups), label: t.groups),
          NavigationDestination(icon: const Icon(Icons.event_outlined), selectedIcon: const Icon(Icons.event), label: t.outings),
          NavigationDestination(icon: const Icon(Icons.person_outline), selectedIcon: const Icon(Icons.person), label: t.profile),
        ],
      ),
    );
  }
}

class BackendErrorScreen extends StatelessWidget {
  const BackendErrorScreen({
    super.key,
    required this.message,
    required this.onRetry,
    required this.t,
  });

  final String message;
  final Future<void> Function() onRetry;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: [
              const Icon(Icons.cloud_off_rounded, size: 64, color: Colors.orangeAccent),
              const SizedBox(height: 18),
              Text(
                t.backendNotResponding,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              Text(
                t.startBackendHelp,
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5, color: Colors.white.withOpacity(0.75)),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.45)),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(t.tryAgain),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    required this.data,
    required this.api,
    required this.t,
    required this.onGroupCreated,
    required this.onActivityCreated,
    required this.onActivityUpdated,
    required this.onMessagesChanged,
  });

  final AppState data;
  final ApiClient api;
  final AppText t;
  final void Function(CrewGroup group) onGroupCreated;
  final void Function(Activity activity) onActivityCreated;
  final void Function(Activity activity) onActivityUpdated;
  final void Function(String groupId, List<ChatMessage> messages) onMessagesChanged;

  @override
  Widget build(BuildContext context) {
    final totalMembers = data.groups.fold<int>(0, (sum, group) => sum + group.members.length);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.hello(data.user.name), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(t.dashboardSubtitle),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    final group = await Navigator.push<CrewGroup>(
                      context,
                      MaterialPageRoute(builder: (_) => CreateGroupScreen(api: api, t: t)),
                    );
                    if (group != null) onGroupCreated(group);
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: Text(t.createGroup),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        InfoCard(icon: Icons.groups_rounded, title: t.groupsCount(data.groups.length), subtitle: t.membersTotal(totalMembers)),
        const SizedBox(height: 12),
        InfoCard(icon: Icons.event_rounded, title: t.outingsCount(data.activities.length), subtitle: t.attentionCount(data.needsAttention.length)),
        const SizedBox(height: 22),
        SectionHeader(t.needsAttention),
        if (data.needsAttention.isEmpty)
          InfoCard(icon: Icons.check_circle_rounded, title: t.allGood, subtitle: t.noProblemActivities)
        else
          ...data.needsAttention.take(3).map((activity) {
            final group = data.groupForActivity(activity);
            if (group == null) return const SizedBox.shrink();

            return ActivityTile(
              group: group,
              activity: activity,
              t: t,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ActivityDetailsScreen(
                      group: group,
                      activity: activity,
                      api: api,
                      t: t,
                      onActivityUpdated: onActivityUpdated,
                    ),
                  ),
                );
              },
            );
          }),
        const SizedBox(height: 22),
        SectionHeader(t.recentChats),
        ...data.groups.take(3).map((group) {
          return ChatPreviewTile(
            group: group,
            t: t,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    group: group,
                    user: data.user,
                    api: api,
                    t: t,
                    onMessagesChanged: (messages) => onMessagesChanged(group.id, messages),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class InboxView extends StatelessWidget {
  const InboxView({
    super.key,
    required this.data,
    required this.api,
    required this.t,
    required this.onMessagesChanged,
  });

  final AppState data;
  final ApiClient api;
  final AppText t;
  final void Function(String groupId, List<ChatMessage> messages) onMessagesChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PageTitle(title: t.chat, subtitle: t.chatSubtitle),
        const SizedBox(height: 14),
        ...data.groups.map((group) {
          return ChatPreviewTile(
            group: group,
            t: t,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    group: group,
                    user: data.user,
                    api: api,
                    t: t,
                    onMessagesChanged: (messages) => onMessagesChanged(group.id, messages),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class GroupsView extends StatelessWidget {
  const GroupsView({
    super.key,
    required this.data,
    required this.api,
    required this.t,
    required this.onGroupCreated,
    required this.onActivityCreated,
    required this.onActivityUpdated,
    required this.onMessagesChanged,
  });

  final AppState data;
  final ApiClient api;
  final AppText t;
  final void Function(CrewGroup group) onGroupCreated;
  final void Function(Activity activity) onActivityCreated;
  final void Function(Activity activity) onActivityUpdated;
  final void Function(String groupId, List<ChatMessage> messages) onMessagesChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PageTitle(
          title: t.groups,
          subtitle: t.groupsSubtitle,
          action: FilledButton.icon(
            onPressed: () async {
              final group = await Navigator.push<CrewGroup>(
                context,
                MaterialPageRoute(builder: (_) => CreateGroupScreen(api: api, t: t)),
              );
              if (group != null) onGroupCreated(group);
            },
            icon: const Icon(Icons.add_rounded),
            label: Text(t.newLabel),
          ),
        ),
        const SizedBox(height: 14),
        ...data.groups.map((group) {
          return GroupTile(
            group: group,
            t: t,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GroupDetailsScreen(
                    group: group,
                    user: data.user,
                    api: api,
                    t: t,
                    onActivityCreated: onActivityCreated,
                    onActivityUpdated: onActivityUpdated,
                    onMessagesChanged: onMessagesChanged,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class ActivitiesView extends StatelessWidget {
  const ActivitiesView({
    super.key,
    required this.data,
    required this.api,
    required this.t,
    required this.onActivityUpdated,
  });

  final AppState data;
  final ApiClient api;
  final AppText t;
  final void Function(Activity activity) onActivityUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PageTitle(title: t.outings, subtitle: t.outingsSubtitle),
        const SizedBox(height: 14),
        ...data.activities.map((activity) {
          final group = data.groupForActivity(activity);
          if (group == null) return const SizedBox.shrink();

          return ActivityTile(
            group: group,
            activity: activity,
            t: t,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailsScreen(
                    group: group,
                    activity: activity,
                    api: api,
                    t: t,
                    onActivityUpdated: onActivityUpdated,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.user, required this.t});

  final Member user;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        PageTitle(title: t.profile, subtitle: t.profileSubtitle),
        const SizedBox(height: 14),
        InfoCard(icon: Icons.person_rounded, title: user.name, subtitle: user.username),
        const SizedBox(height: 12),
        InfoCard(icon: Icons.api_rounded, title: t.api, subtitle: ApiConfig.baseUrl),
        const SizedBox(height: 12),
        InfoCard(icon: Icons.save_rounded, title: t.persistence, subtitle: t.persistenceSubtitle),
      ],
    );
  }
}

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({
    super.key,
    required this.group,
    required this.user,
    required this.api,
    required this.t,
    required this.onActivityCreated,
    required this.onActivityUpdated,
    required this.onMessagesChanged,
  });

  final CrewGroup group;
  final Member user;
  final ApiClient api;
  final AppText t;
  final void Function(Activity activity) onActivityCreated;
  final void Function(Activity activity) onActivityUpdated;
  final void Function(String groupId, List<ChatMessage> messages) onMessagesChanged;

  @override
  State<GroupDetailsScreen> createState() => GroupDetailsScreenState();
}

class GroupDetailsScreenState extends State<GroupDetailsScreen> {
  late CrewGroup group;

  @override
  void initState() {
    super.initState();
    group = widget.group;
  }

  @override
  Widget build(BuildContext context) {
    final inviteLink = 'https://crewhub.app/invite/${group.id}';

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: [
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: inviteLink));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.t.copyLink)));
            },
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InfoCard(icon: categoryIcon(group.category), title: group.name, subtitle: '${widget.t.categoryLabel(group.category)} • ${widget.t.members(group.members.length)}'),
          const SizedBox(height: 12),
          Text(group.description),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    group: group,
                    user: widget.user,
                    api: widget.api,
                    t: widget.t,
                    onMessagesChanged: (messages) {
                      widget.onMessagesChanged(group.id, messages);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.chat_rounded),
            label: Text(widget.t.openChat),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () async {
              final activity = await Navigator.push<Activity>(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateActivityScreen(api: widget.api, group: group, t: widget.t),
                ),
              );

              if (activity != null) {
                widget.onActivityCreated(activity);
                setState(() {});
              }
            },
            icon: const Icon(Icons.add_rounded),
            label: Text(widget.t.createOuting),
          ),
          const SizedBox(height: 22),
          SectionHeader(widget.t.membersTitle),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: group.members.map((member) => Chip(label: Text(member.name))).toList(),
          ),
          const SizedBox(height: 22),
          SectionHeader(widget.t.outings),
          if (group.activities.isEmpty)
            Text(widget.t.noOutingsYet)
          else
            ...group.activities.map((activity) {
              return ActivityTile(
                group: group,
                activity: activity,
                t: widget.t,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivityDetailsScreen(
                        group: group,
                        activity: activity,
                        api: widget.api,
                        t: widget.t,
                        onActivityUpdated: (updated) {
                          final index = group.activities.indexWhere((item) => item.id == updated.id);
                          if (index >= 0) {
                            setState(() {
                              group.activities[index] = updated;
                            });
                          }
                          widget.onActivityUpdated(updated);
                        },
                      ),
                    ),
                  );
                },
              );
            }),
        ],
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.group,
    required this.user,
    required this.api,
    required this.t,
    required this.onMessagesChanged,
  });

  final CrewGroup group;
  final Member user;
  final ApiClient api;
  final AppText t;
  final void Function(List<ChatMessage> messages) onMessagesChanged;

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  List<ChatMessage> messages = [];
  bool loading = true;
  bool sending = false;
  String? error;

  @override
  void initState() {
    super.initState();
    messages = widget.group.messages;
    loadMessages();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> loadMessages() async {
    try {
      final loaded = await widget.api.getMessages(widget.group.id);
      if (!mounted) return;
      setState(() {
        messages = loaded;
        loading = false;
        error = null;
      });
      widget.onMessagesChanged(loaded);
    } catch (exception) {
      if (!mounted) return;
      setState(() {
        error = exception.toString();
        loading = false;
      });
    }
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      sending = true;
    });

    try {
      final message = await widget.api.sendMessage(
        groupId: widget.group.id,
        senderId: widget.user.id,
        text: text,
      );

      controller.clear();

      setState(() {
        messages.add(message);
        sending = false;
      });

      widget.onMessagesChanged(messages);
    } catch (exception) {
      setState(() {
        sending = false;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.t.error}: $exception')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...messages];
    sorted.sort((first, second) => first.createdAt.compareTo(second.createdAt));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        actions: [
          IconButton(onPressed: loadMessages, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Column(
        children: [
          if (loading) const LinearProgressIndicator(),
          if (error != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(error!, style: const TextStyle(color: Colors.orangeAccent)),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final message = sorted[index];
                final isMe = message.senderId == widget.user.id;
                final sender = widget.group.memberById(message.senderId);

                return ChatBubble(
                  message: message,
                  senderName: sender?.name ?? widget.t.system,
                  isMe: isMe,
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: widget.t.writeMessage,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: sending ? null : sendMessage,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen({
    super.key,
    required this.group,
    required this.activity,
    required this.api,
    required this.t,
    required this.onActivityUpdated,
  });

  final CrewGroup group;
  final Activity activity;
  final ApiClient api;
  final AppText t;
  final void Function(Activity activity) onActivityUpdated;

  @override
  State<ActivityDetailsScreen> createState() => ActivityDetailsScreenState();
}

class ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  late Activity activity;
  bool saving = false;

  @override
  void initState() {
    super.initState();
    activity = widget.activity;
  }

  RsvpStatus? get myStatus => activity.statusForUser('u1');

  List<Member> membersByStatus(RsvpStatus status) {
    final ids = activity.responses.where((item) => item.status == status).map((item) => item.userId).toSet();
    return widget.group.members.where((member) => ids.contains(member.id)).toList();
  }

  Future<void> setStatus(RsvpStatus status) async {
    setState(() {
      saving = true;
    });

    try {
      final updated = await widget.api.updateRsvp(activityId: activity.id, userId: 'u1', status: status);

      setState(() {
        activity = updated;
        saving = false;
      });

      widget.onActivityUpdated(updated);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.t.status}: ${widget.t.rsvpLabel(myStatus)}')),
      );
    } catch (exception) {
      setState(() {
        saving = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.t.error}: $exception')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = activity.maxParticipants == 0
        ? 0.0
        : (activity.goingCount / activity.maxParticipants).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: Text(activity.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InfoCard(
            icon: categoryIcon(activity.category),
            title: activity.title,
            subtitle: '${widget.group.name} • ${widget.t.activityStatusLabel(activity.business.status)}',
          ),
          const SizedBox(height: 12),
          InfoCard(
            icon: Icons.rule_rounded,
            title: activity.business.smartHint,
            subtitle: widget.t.minMax(activity.minParticipants, activity.maxParticipants),
          ),
          const SizedBox(height: 12),
          Text(activity.description),
          const SizedBox(height: 12),
          InfoCard(
            icon: Icons.location_on_rounded,
            title: activity.location,
            subtitle: longDate(activity.dateTime),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 22),
          SectionHeader(widget.t.confirmation(widget.t.rsvpLabel(myStatus))),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: saving ? null : () => setStatus(RsvpStatus.going),
            icon: const Icon(Icons.check_rounded),
            label: Text(widget.t.going),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: saving ? null : () => setStatus(RsvpStatus.maybe),
            icon: const Icon(Icons.help_rounded),
            label: Text(widget.t.maybe),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: saving ? null : () => setStatus(RsvpStatus.notGoing),
            icon: const Icon(Icons.close_rounded),
            label: Text(widget.t.notGoing),
          ),
          if (saving) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
          ],
          const SizedBox(height: 22),
          InfoCard(
            icon: Icons.payments_rounded,
            title: activity.totalCost == 0
                ? widget.t.free
                : widget.t.costPerPerson(activity.business.costPerPerson.toStringAsFixed(2)),
            subtitle: widget.t.totalCost(activity.totalCost.toStringAsFixed(0)),
          ),
          const SizedBox(height: 22),
          ParticipantSection(title: widget.t.going, members: membersByStatus(RsvpStatus.going), t: widget.t),
          ParticipantSection(title: widget.t.maybe, members: membersByStatus(RsvpStatus.maybe), t: widget.t),
          ParticipantSection(title: widget.t.reserve, members: membersByStatus(RsvpStatus.reserve), t: widget.t),
        ],
      ),
    );
  }
}

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key, required this.api, required this.t});

  final ApiClient api;
  final AppText t;

  @override
  State<CreateGroupScreen> createState() => CreateGroupScreenState();
}

class CreateGroupScreenState extends State<CreateGroupScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  GroupCategory category = GroupCategory.social;
  bool saving = false;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() {
      saving = true;
    });

    try {
      final group = await widget.api.createGroup(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        category: category,
      );
      if (!mounted) return;
      Navigator.pop(context, group);
    } catch (exception) {
      setState(() {
        saving = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.t.error}: $exception')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.t.createGroupTitle),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PageTitle(title: widget.t.newGroup, subtitle: widget.t.savedInBackend),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: widget.t.groupName),
              validator: (value) => value == null || value.trim().isEmpty ? widget.t.addName : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: widget.t.description),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GroupCategory>(
              value: category,
              items: GroupCategory.values.map((item) {
                return DropdownMenuItem(value: item, child: Text(widget.t.categoryLabel(item)));
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  category = value;
                });
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: saving ? null : submit,
              child: Text(saving ? widget.t.saving : widget.t.createGroup),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key, required this.api, required this.group, required this.t});

  final ApiClient api;
  final CrewGroup group;
  final AppText t;

  @override
  State<CreateActivityScreen> createState() => CreateActivityScreenState();
}

class CreateActivityScreenState extends State<CreateActivityScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final minController = TextEditingController(text: '4');
  final maxController = TextEditingController(text: '10');
  final costController = TextEditingController(text: '0');
  String sportType = 'none';
  late GroupCategory category;
  DateTime dateTime = DateTime.now().add(const Duration(days: 1));
  bool saving = false;

  @override
  void initState() {
    super.initState();
    category = widget.group.category;
    sportType = category == GroupCategory.sport ? 'football' : 'none';
  }

  @override
  void dispose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    minController.dispose();
    maxController.dispose();
    costController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null) return;
    setState(() {
      dateTime = DateTime(picked.year, picked.month, picked.day, dateTime.hour, dateTime.minute);
    });
  }

  Future<void> pickTime() async {
    final selected = await showModalBottomSheet<TimeOfDay>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView.builder(
            itemCount: 48,
            itemBuilder: (context, index) {
              final hour = index ~/ 2;
              final minute = index.isEven ? 0 : 30;
              final label = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

              return ListTile(
                leading: const Icon(Icons.schedule_rounded),
                title: Text(label),
                onTap: () {
                  Navigator.pop(context, TimeOfDay(hour: hour, minute: minute));
                },
              );
            },
          ),
        );
      },
    );

    if (selected == null) return;

    setState(() {
      dateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        selected.hour,
        selected.minute,
      );
    });
  }

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    final min = int.tryParse(minController.text.trim()) ?? 2;
    final max = int.tryParse(maxController.text.trim()) ?? 10;
    if (min > max) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.t.minOverMax)));
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      final activity = await widget.api.createActivity(
        groupId: widget.group.id,
        title: titleController.text.trim(),
        category: category,
        sportType: sportType,
        location: locationController.text.trim(),
        description: descriptionController.text.trim(),
        dateTime: dateTime,
        minParticipants: min,
        maxParticipants: max,
        totalCost: double.tryParse(costController.text.trim().replaceAll(',', '.')) ?? 0,
      );
      if (!mounted) return;
      Navigator.pop(context, activity);
    } catch (exception) {
      setState(() {
        saving = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.t.error}: $exception')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSport = category == GroupCategory.sport;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.t.createOutingTitle),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PageTitle(title: widget.t.createOuting, subtitle: widget.t.newOutingFor(widget.group.name)),
            const SizedBox(height: 16),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: widget.t.title),
              validator: (value) => value == null || value.trim().isEmpty ? widget.t.addTitle : null,
            ),
            const SizedBox(height: 12),
            TextFormField(controller: locationController, decoration: InputDecoration(labelText: widget.t.location)),
            const SizedBox(height: 12),
            TextFormField(
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: widget.t.description),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: minController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: widget.t.minParticipants),
              validator: (value) {
                final parsed = int.tryParse(value ?? '');
                if (parsed == null || parsed <= 0) return widget.t.invalidNumber;
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: maxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: widget.t.maxParticipants),
              validator: (value) {
                final parsed = int.tryParse(value ?? '');
                if (parsed == null || parsed <= 0) return widget.t.invalidNumber;
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: widget.t.totalCostLabel),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GroupCategory>(
              value: category,
              items: GroupCategory.values.map((item) {
                return DropdownMenuItem(value: item, child: Text(widget.t.categoryLabel(item)));
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  category = value;
                  if (category != GroupCategory.sport) sportType = 'none';
                });
              },
            ),
            if (isSport) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: sportType,
                items: [
                  DropdownMenuItem(value: 'football', child: Text(widget.t.football)),
                  DropdownMenuItem(value: 'volleyball', child: Text(widget.t.volleyball)),
                  DropdownMenuItem(value: 'basketball', child: Text(widget.t.basketball)),
                  DropdownMenuItem(value: 'tennis', child: Text(widget.t.tennis)),
                  DropdownMenuItem(value: 'other', child: Text(widget.t.otherSport)),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    sportType = value;
                  });
                },
              ),
            ],
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(longDate(dateTime)),
              subtitle: Text(widget.t.dateAndTime),
            ),
            OutlinedButton(onPressed: pickDate, child: Text(widget.t.chooseDate)),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: pickTime, child: Text(widget.t.chooseTime)),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: saving ? null : submit,
              child: Text(saving ? widget.t.saving : widget.t.createOuting),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPreviewTile extends StatelessWidget {
  const ChatPreviewTile({
    super.key,
    required this.group,
    required this.onTap,
    required this.t,
  });

  final CrewGroup group;
  final VoidCallback onTap;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    final last = group.lastMessage;

    return Card(
      child: ListTile(
        leading: Icon(categoryIcon(group.category), color: Theme.of(context).colorScheme.primary),
        title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(last == null ? t.noMessagesYet : last.text, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.senderName,
    required this.isMe,
  });

  final ChatMessage message;
  final String senderName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final color = isMe ? Theme.of(context).colorScheme.primaryContainer : const Color(0xFF101B2F);
    final textColor = isMe ? Colors.black : Colors.white;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 310),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(senderName, style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7))),
            const SizedBox(height: 4),
            Text(message.text, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  const GroupTile({
    super.key,
    required this.group,
    required this.onTap,
    required this.t,
  });

  final CrewGroup group;
  final VoidCallback onTap;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    final next = group.nextActivity;

    return Card(
      child: ListTile(
        leading: Icon(categoryIcon(group.category), color: Theme.of(context).colorScheme.primary),
        title: Text(group.name, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(
          next == null
              ? '${t.categoryLabel(group.category)} • ${t.members(group.members.length)}'
              : '${t.categoryLabel(group.category)} • ${next.title}',
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.group,
    required this.activity,
    required this.onTap,
    required this.t,
  });

  final CrewGroup group;
  final Activity activity;
  final VoidCallback onTap;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(categoryIcon(activity.category), color: Theme.of(context).colorScheme.primary),
        title: Text(activity.title, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(
          '${group.name} • ${shortDate(activity.dateTime)} • ${activity.goingCount}/${activity.maxParticipants} ${t.going.toLowerCase()}',
        ),
        trailing: Chip(label: Text(t.activityStatusLabel(activity.business.status))),
        onTap: onTap,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class ParticipantSection extends StatelessWidget {
  const ParticipantSection({
    super.key,
    required this.title,
    required this.members,
    required this.t,
  });

  final String title;
  final List<Member> members;
  final AppText t;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text('$title (${members.length})'),
        children: [
          if (members.isEmpty)
            ListTile(title: Text(t.nobodyYet))
          else
            ...members.map((member) {
              return ListTile(
                leading: const Icon(Icons.person_rounded),
                title: Text(member.name),
                subtitle: Text(member.username),
              );
            }),
        ],
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String title;
  final String subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    if (action == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.65))),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: PageTitle(title: title, subtitle: subtitle)),
        const SizedBox(width: 12),
        action!,
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900));
  }
}
