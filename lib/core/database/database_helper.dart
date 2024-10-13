// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:tanysu/features/chat_page/data/models/chat_model.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;

//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final String path = join(await getDatabasesPath(), 'chat_database.db');
//     return await openDatabase(
//       path,
//       version: 2,
//       onCreate: (db, version) async {
//         await db.execute('''
//         CREATE TABLE chats(
//           id INTEGER PRIMARY KEY,
//           profile_id INTEGER,
//           chat_name TEXT,
//           chat_type TEXT,
//           last_message TEXT,
//           chat_photo TEXT,
//           unread INTEGER,
//           online BOOl,
//           last_message_time TEXT
//         )
//         ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           await db.execute('ALTER TABLE chats ADD COLUMN profile_id INTEGER;');
//         }
//       },
//     );
//   }

//   Future<void> insertChat(ChatModel chat) async {
//     final db = await database;
//     await db.insert('chats', chat.toJson(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<ChatModel>> getChats() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('chats');

//     return List.generate(maps.length, (i) {
//       return ChatModel.fromJson(maps[i]);
//     });
//   }
// }
