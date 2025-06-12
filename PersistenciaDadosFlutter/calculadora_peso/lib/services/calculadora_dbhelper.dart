import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:calculadora_peso/models/perfil_model.dart';
import 'package:calculadora_peso/models/calculadora_model.dart';


class CalculadoraDBHelper {
  static Database? _database;

  static final CalculadoraDBHelper _instance = CalculadoraDBHelper._internal();

  CalculadoraDBHelper._internal();
  factory CalculadoraDBHelper() {
    return _instance;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "calculadora_peso.db");

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE IF NOT EXISTS calculadora_peso (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      valor REAL NOT NULL,
      data TEXT NOT NULL,
      perfil_nome TEXT NOT NULL
    ) ''');
    print("Tabela calculadora_peso criada com sucesso!");

    await db.execute('''
CREATE TABLE IF NOT EXISTS perfil (
     nome TEXT PRIMARY KEY,
      altura TEXT NOT NULL,
      sexo TEXT NOT NULL,
      data_nascimento TEXT NOT NULL
    ) ''');
    print("Tabela perfil criada com sucesso!");
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<int> insertPerfil(Perfil perfil) async {
    final db = await database;
    return await db.insert('perfil', perfil.toMap());
  }

  Future<List<Perfil>> getPerfil() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "perfil",
    ); 
    return maps.map((e) => Perfil.fromMap(e)).toList(); 
  }

  Future<Perfil> updatePerfil(Perfil perfil) async {
    final db = await database;
    await db.update(
      "perfil",
      perfil.toMap(),
      where: "nome = ?",
      whereArgs: [perfil.nome],
    );
    return perfil;
  }

  Future<int> deletePerfil(String nome) async {
    final db = await database;
    return await db.delete("perfil", where: "nome=?", whereArgs: [nome]);
  }

  Future<int> insertPeso(Calculadora peso) async {
    final db = await database;
    return await db.insert('calculadora_peso', peso.toMap());
  }

  //Calculadora
  Future<List<Calculadora>> getPesosPerfil(String perfilNome) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      "calculadora_peso",
      where: "perfil_nome = ?",
      whereArgs: [perfilNome],
      orderBy: "data ASC",
    );
    return maps.map((e) => Calculadora.fromMap(e)).toList();
  }
}
