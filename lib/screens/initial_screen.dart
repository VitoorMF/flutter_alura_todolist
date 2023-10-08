import 'package:flutter/material.dart';
import 'package:flutter_alura/data/task_inherited.dart';
import 'package:flutter_alura/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isOpacityVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.notes,
          size: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
        title: const Text('Tarefas',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (contextNew) => FormScreen(taskContext: context,)));
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
