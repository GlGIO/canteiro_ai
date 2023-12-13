import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSQFlite {
  static final DatabaseSQFlite _instance = DatabaseSQFlite._internal();

  factory DatabaseSQFlite() {
    return _instance;
  }

  DatabaseSQFlite._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'canteiro_ai.db'),
      version: 1,
      onCreate: _onCreate,
    );
    return _database!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_layoutInfoTable);
    await db.execute(_layoutPlanTbale);
  }

  String get _layoutInfoTable => '''
    CREATE TABLE layout_info(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      local TEXT,
      description TEXT,
      date TEXT,
      typeEdf TEXT,
      typeCant TEXT,
      stage TEXT,
      largura DOUBLE,
      profundidade DOUBLE,
      inicioACX DOUBLE,
      fimACX DOUBLE,
      inicioACY DOUBLE,
      fimACY DOUBLE
    )
  ''';

  String get _layoutPlanTbale => '''
  CREATE TABLE layout_plan(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    layout_info_id INTEGER,
    area_name TEXT,
    x1 DOUBLE,
    y1 DOUBLE,
    x2 DOUBLE,
    y2 DOUBLE,
    FOREIGN KEY (layout_info_id) REFERENCES layout_info(id)
  )
''';

  Future<List<Map<String, dynamic>>> query(String table) async {
    final Database db = await database;
    return db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryPlan(
    String table,
    String? where,
    List? whereArgs,
  ) async {
    final Database db = await database;
    return db.query(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final Database db = await database;
    return db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> delete(String table) async {
    final Database db = await database;
    await db.execute('DROP TABLE IF EXISTS $table');
    await _onCreate(db, 1);
    return db.query(table);
  }
}
