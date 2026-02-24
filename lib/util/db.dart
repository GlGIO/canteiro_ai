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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _database!;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _seedMockData(db);
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_layoutInfoTable);
    await db.execute(_layoutPlanTbale);
    await _seedMockData(db);
  }

  Future<void> _seedMockData(Database db) async {
    final count = (await db.rawQuery('SELECT COUNT(*) as c FROM layout_info'))
        .first['c'] as int;
    if (count > 0) return;

    final id1 = await db.insert('layout_info', {
      'title': 'Edifício Residencial Vila Nova',
      'local': 'São Paulo, SP',
      'description':
          'Construção de edifício residencial de 12 andares com área de lazer completa',
      'date': '2025-11-15 10:30:00',
      'typeEdf': 'residencial',
      'typeCant': 'amplo',
      'stage': 'estrutura',
      'largura': 30.0,
      'profundidade': 40.0,
      'inicioACX': 5.0,
      'fimACX': 25.0,
      'inicioACY': 10.0,
      'fimACY': 35.0,
    });

    final areas1 = [
      {'area_name': 'Area construida', 'x1': 5.0, 'y1': 10.0, 'x2': 25.0, 'y2': 35.0},
      {'area_name': 'Acesso', 'x1': 7.5, 'y1': 0.0, 'x2': 22.5, 'y2': 2.0},
      {'area_name': 'Almocharifado', 'x1': 0.0, 'y1': 2.0, 'x2': 5.0, 'y2': 7.0},
      {'area_name': 'Escritórios', 'x1': 0.0, 'y1': 7.0, 'x2': 5.0, 'y2': 10.0},
      {'area_name': 'Refeitorio', 'x1': 25.0, 'y1': 2.0, 'x2': 30.0, 'y2': 7.0},
      {'area_name': 'Vestiários', 'x1': 25.0, 'y1': 7.0, 'x2': 30.0, 'y2': 10.0},
      {'area_name': 'Banheiros', 'x1': 0.0, 'y1': 35.0, 'x2': 5.0, 'y2': 38.0},
      {'area_name': 'Áreas de Montagem', 'x1': 5.0, 'y1': 35.0, 'x2': 14.0, 'y2': 40.0},
      {'area_name': 'Cimento', 'x1': 14.0, 'y1': 35.0, 'x2': 20.0, 'y2': 40.0},
      {'area_name': 'Areia e Brita', 'x1': 20.0, 'y1': 35.0, 'x2': 26.0, 'y2': 40.0},
      {'area_name': 'Equipamentos', 'x1': 26.0, 'y1': 35.0, 'x2': 30.0, 'y2': 40.0},
      {'area_name': 'Áreas de Descarte', 'x1': 0.0, 'y1': 38.0, 'x2': 5.0, 'y2': 40.0},
    ];
    for (final area in areas1) {
      await db.insert('layout_plan', {'layout_info_id': id1, ...area});
    }

    final id2 = await db.insert('layout_info', {
      'title': 'Centro Comercial Paulista',
      'local': 'Campinas, SP',
      'description':
          'Shopping center com 3 pisos e estacionamento subterrâneo',
      'date': '2025-12-03 14:00:00',
      'typeEdf': 'comercial',
      'typeCant': 'estreito',
      'stage': 'fundacao',
      'largura': 15.0,
      'profundidade': 50.0,
      'inicioACX': 2.0,
      'fimACX': 13.0,
      'inicioACY': 10.0,
      'fimACY': 40.0,
    });

    final areas2 = [
      {'area_name': 'Area construida', 'x1': 2.0, 'y1': 10.0, 'x2': 13.0, 'y2': 40.0},
      {'area_name': 'Acesso', 'x1': 3.75, 'y1': 0.0, 'x2': 11.25, 'y2': 2.0},
      {'area_name': 'Almocharifado', 'x1': 0.0, 'y1': 2.0, 'x2': 5.0, 'y2': 6.0},
      {'area_name': 'Escritórios', 'x1': 0.0, 'y1': 6.0, 'x2': 5.0, 'y2': 10.0},
      {'area_name': 'Refeitorio', 'x1': 10.0, 'y1': 2.0, 'x2': 15.0, 'y2': 6.0},
      {'area_name': 'Vestiários', 'x1': 10.0, 'y1': 6.0, 'x2': 15.0, 'y2': 10.0},
      {'area_name': 'Banheiros', 'x1': 5.0, 'y1': 2.0, 'x2': 10.0, 'y2': 5.0},
      {'area_name': 'Áreas de Montagem', 'x1': 0.0, 'y1': 40.0, 'x2': 5.0, 'y2': 45.0},
      {'area_name': 'Cimento', 'x1': 5.0, 'y1': 40.0, 'x2': 10.0, 'y2': 45.0},
      {'area_name': 'Areia e Brita', 'x1': 10.0, 'y1': 40.0, 'x2': 15.0, 'y2': 45.0},
      {'area_name': 'Equipamentos', 'x1': 0.0, 'y1': 45.0, 'x2': 7.5, 'y2': 50.0},
      {'area_name': 'Áreas de Descarte', 'x1': 7.5, 'y1': 45.0, 'x2': 15.0, 'y2': 50.0},
    ];
    for (final area in areas2) {
      await db.insert('layout_plan', {'layout_info_id': id2, ...area});
    }

    final id3 = await db.insert('layout_info', {
      'title': 'Condomínio Jardim das Flores',
      'local': 'Rio de Janeiro, RJ',
      'description':
          'Condomínio multifamiliar com 4 torres e área verde integrada',
      'date': '2026-01-20 09:15:00',
      'typeEdf': 'multifamilar',
      'typeCant': 'restrito',
      'stage': 'alvenaria',
      'largura': 20.0,
      'profundidade': 25.0,
      'inicioACX': 3.0,
      'fimACX': 17.0,
      'inicioACY': 5.0,
      'fimACY': 20.0,
    });

    final areas3 = [
      {'area_name': 'Area construida', 'x1': 3.0, 'y1': 5.0, 'x2': 17.0, 'y2': 20.0},
      {'area_name': 'Acesso', 'x1': 5.0, 'y1': 0.0, 'x2': 15.0, 'y2': 2.0},
      {'area_name': 'Almocharifado', 'x1': 0.0, 'y1': 2.0, 'x2': 5.0, 'y2': 5.0},
      {'area_name': 'Escritórios', 'x1': 15.0, 'y1': 2.0, 'x2': 20.0, 'y2': 5.0},
      {'area_name': 'Refeitorio', 'x1': 5.0, 'y1': 2.0, 'x2': 10.0, 'y2': 5.0},
      {'area_name': 'Vestiários', 'x1': 10.0, 'y1': 2.0, 'x2': 15.0, 'y2': 5.0},
      {'area_name': 'Banheiros', 'x1': 0.0, 'y1': 5.0, 'x2': 3.0, 'y2': 9.0},
      {'area_name': 'Áreas de Montagem', 'x1': 0.0, 'y1': 20.0, 'x2': 7.0, 'y2': 25.0},
      {'area_name': 'Cimento', 'x1': 7.0, 'y1': 20.0, 'x2': 12.0, 'y2': 25.0},
      {'area_name': 'Areia e Brita', 'x1': 12.0, 'y1': 20.0, 'x2': 17.0, 'y2': 25.0},
      {'area_name': 'Equipamentos', 'x1': 17.0, 'y1': 20.0, 'x2': 20.0, 'y2': 25.0},
      {'area_name': 'Áreas de Descarte', 'x1': 17.0, 'y1': 5.0, 'x2': 20.0, 'y2': 9.0},
    ];
    for (final area in areas3) {
      await db.insert('layout_plan', {'layout_info_id': id3, ...area});
    }
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
