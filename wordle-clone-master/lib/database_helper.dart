import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper._privateConstructor();

  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._privateConstructor();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database.isOpen) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'words_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE words(
        id INTEGER PRIMARY KEY,
        word TEXT
      )
    ''');
    // Insert initial words into the database
    for (String word in _initialWords) {
      await db.rawInsert('INSERT INTO words(word) VALUES(?)', [word]);
    }
  }

  final List<String> _initialWords = [
    'ACORN',
    'ADULT',
    'APPLE',
    'APPLY',
    'BEACH',
    'BLOCK',
    'BLOOD',
    'BOARD',
    'BRAIN',
    'BREAD',
    'CHAIN',
    'CHAIR',
    'CHEST',
    'DANCE',
    'EAGER',
    'EARLY',
    'EARTH',
    'ENEMY',
    'ENTRY',
    'ERROR',
    'EVENT',
    'FAITH',
    'FINAL',
    'FLOOR',
    'GREEN',
    'GROUP',
    'GUIDE',
    'HEART',
    'IGLOO',
    'INDIA',
    'INPUT',
    'ISSUE',
    'JAPAN',
    'JUDGE',
    'KNIFE',
    'KNOCK',
    'LAMB',
    'LIGHT',
    'MAPLE',
    'METAL',
    'MODEL',
    'MONEY',
    'MONTH',
    'MOTOR',
    'NUMB',
    'OTHER',
    'OWNER',
    'PANEL',
    'PAPER',
    'PARTY',
    'PEACE',
    'QUEEN',
    'RADIO',
    'RANGE',
    'RATIO',
    'REPLY',
    'RIGHT',
    'RIVER',
    'SENSE',
    'SHAPE',
    'SHARE',
    'SHEEP',
    'SHEET',
    'SHIFT',
    'SHIRT',
    'SHOCK',
    'SIGHT',
    'SKILL',
    'SLEEP',
    'SMILE',
    'STAFF',
    'STAGE',
    'START',
    'STATE',
    'STEAM',
    'STEEL',
    'STOCK',
    'STONE',
    'STORE',
    'STUDY',
    'STUFF',
    'STYLE',
    'SUGAR',
    'TABLE',
    'TASTE',
    'THEME',
    'THING',
    'THUMB',
    'UNCLE',
    'UNION',
    'VALUE',
    'VIDEO',
    'VISIT',
    'VOICE',
    'WASTE',
    'WATCH',
    'WATER',
    'WHITE',
    'WOMAN',
    'WORLD',
  ];

  Future<List<String>> getWords() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('words');
    return List.generate(maps.length, (i) {
      return maps[i]['word'];
    });
  }
}
