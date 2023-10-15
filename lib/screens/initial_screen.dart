import 'package:flutter/material.dart';
import 'package:flutter_alura/data/task_dao.dart';
import 'package:flutter_alura/data/task_inherited.dart';
import 'package:flutter_alura/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}
double level = TaskDao().getLevel();
double levelGlobal = 0;

class _InitialScreenState extends State<InitialScreen> {



  Future refresh() async{
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Icon(Icons.notes, color: Colors.white, size: 30),
        backgroundColor: Colors.blueGrey,
        title: Text('Tarefas',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25)),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Task>>(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<Task>? items = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.waiting:
                    return const Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.active:
                    return const Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task tarefa = items[index];
                              return tarefa;
                            });
                      }
                      return const Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline_sharp,
                                size: 80,
                                color: Colors.black38,
                              ),
                              Text(
                                'Não há nenhuma tarefa',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black45),
                              )
                            ]),
                      );
                    }
                    return Text(' Erro ao carregar tarefas ');
                    break;
                }
                return Text('Erro desconhecido');
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(
                  taskContext: context,
                ),
              ),
            ).then((value) => setState(() => {}));
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
