import 'package:news_app/data/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('user.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableUsers ( 
        ${UserFields.id} $idType, 
        ${UserFields.isLoggedIn} $boolType,
        ${UserFields.username} $textType,
        ${UserFields.password} $textType,
        ${UserFields.email} $textType,
        ${UserFields.listOfArticles} $textType
        )
      ''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    // final json = user.toJson();
    // final columns =
    //     '${UserFields.title}, ${UserFields.description}, ${UserFields.time}';
    // final values =
    //     '${json[UserFields.title]}, ${json[UserFields.description]}, ${json[UserFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableUsers, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser(String email, String password) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.email} = ? and ${UserFields.password} = ?',
      whereArgs: [email, password],
    );
    // final maps = await db.rawQuery('SELECT * FROM $tableUsers WHERE ${UserFields.email}=? and ${UserFields.password}=?', [email, password]);

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<User> readUserById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${UserFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableUsers ORDER BY $orderBy');

    final result = await db.query(tableUsers, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
