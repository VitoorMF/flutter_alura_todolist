import 'package:flutter/material.dart';
import 'package:flutter_alura/components/task.dart';
import 'package:flutter_alura/data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSaveButtonPressed = false;

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nova tarefa',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            width: 375,
            height: 650,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (valueValidator(value)) {
                        return 'Insira o nome da tarefa';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (difficultyValidator(value)) {
                        return 'Insira um número entre 1 a 5';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: difficultyController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Dificuldade',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (valueValidator(value)) {
                        return 'insira um URL de imagem';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.url,
                    controller: imageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'imagem',
                      fillColor: Colors.white70,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 72,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.blue),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exeption,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/nophoto.jpg',
                          fit: BoxFit.fitHeight,
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    setState(() {});
                    if (_formKey.currentState!.validate()) {
                      int nivel = 0;
                      await TaskDao().save(Task(
                        nameController.text,
                        imageController.text,
                        int.parse(difficultyController.text),
                        nivel,
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Criando nova tarefa!')));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('adicionar'),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
