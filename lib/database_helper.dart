import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // 싱글톤 인스턴스
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // 데이터 베이스 객체를 저장하기 위한 변수
  static Database? _database;

  // 싱글톤 객체 반환
  factory DatabaseHelper() {
    return _instance;
  }

  // 실제 인스턴스 생성
  DatabaseHelper._internal();

  // DB 접근
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'weather_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, cityName TEXT)',
        );
      },
    );
  }

  // 찜 저장
  Future<void> insertFavorite(String cityName) async {
    final db = await database;
    await db.insert(
      'favorites',
      {'cityName': cityName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return maps[i]['cityName'];
    });
  }

  Future<void> deleteFavorite(String cityName) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
  }
}
