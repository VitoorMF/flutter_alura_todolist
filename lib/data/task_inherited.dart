import 'package:flutter/material.dart';
import 'package:flutter_alura/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);



  final List<Task> taskList = [
     Task( 'Aprender Flutter', 'assets/images/flutter.png', 3, 0,),
  ];

  void newTask(String name, String image, int difficulty, int constantNivel, int nivel) {
    taskList.add(Task( name,  image, difficulty, nivel,));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
