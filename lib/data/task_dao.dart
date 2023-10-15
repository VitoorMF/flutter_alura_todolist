import 'package:flutter_alura/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      '$_nivel INTEGER)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _nivel = 'nivel';


  save(Task tarefa) async {
    print('iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    var isExistent = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (isExistent.isEmpty) {
      print('a tarefa não existia.');
      return await bancoDeDados.insert(_tableName, taskMap);
    } else {
      taskMap = toMap(tarefa);
      print('Atualizar task');
      return await bancoDeDados.update(_tableName, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('convertendo tarefa em map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    mapaDeTarefas[_image] = tarefa.image;
    mapaDeTarefas[_nivel] = tarefa.nivel;
    print('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    print('procurando dados no banco de dados... encontrado $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('convertendo toList: ');

    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
          linha[_name],
          linha[_image],
          linha[_difficulty],
          linha[_nivel],);
      tarefas.add(tarefa);
    }
    print('lista de tarefas: $tarefas');
    return tarefas;
  }

  getLevel() async{
    final Database bancoDeDados = await getDatabase();
    print('NIVEL: $_nivel');
    return _nivel;
  }
  getDifficulty() async{
    final Database bancoDeDados = await getDatabase();
    return _difficulty;
  }

  updateLevel(Task tarefa) async {
    print('update');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);

    print('Atualizar tarefa');
    return await bancoDeDados.update(_tableName, taskMap,
        where: '$_name = ?', whereArgs: [tarefa.nome]);
  }


  Future<List<Task>> find(String nomeDaTarefa) async {
    print('acessando o find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print('tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('deletando tarefa: ');
    final Database bancoDeDados = await getDatabase();
    bancoDeDados.delete(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }

  deleteTudo() async {
    print('deletando tarefas: ');
    final Database bancoDeDados = await getDatabase();
    bancoDeDados.delete(_tableName);
  }
}
