import 'package:flutter/material.dart';
import 'package:flutter_alura/data/task_inherited.dart';
import 'package:flutter_alura/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

double levelGlobal = 0;

class _InitialScreenState extends State<InitialScreen> {
  void calculateLevelGlobal() {
    double level = 0;
    for (Task task in TaskInherited.of(context).taskList) {
      level += task.constantNivel / 10 * task.difficulty;
    }
    levelGlobal = level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Icon(Icons.notes, color: Colors.white, size: 30),
        backgroundColor: Colors.blueGrey,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 50.0),
              child: Text('Tarefas',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 25)),
            ),
            Row(
              children: [
                SizedBox(
                    width: 230,
                    height: 9,
                    child: LinearProgressIndicator(
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      color: Colors.blue,
                      value: levelGlobal / 100,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Nível do Usuário'),
                          content: Text(
                              'Usuário nível: ${levelGlobal.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 15)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      setState(() {
                        calculateLevelGlobal();
                      });
                    },
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (contextNew) => FormScreen(
                          taskContext: context,
                        )));
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
