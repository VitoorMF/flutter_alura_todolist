import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.edit_note),
          title: Text('Flutter, Atividade'),
        ),
        body: Column(
          children: [
            Param(),
            Param(),
            Param(),
            Param(),
          ],
        ),
      ),
    );
  }
}

class Param extends StatefulWidget {
  const Param({super.key});

  @override
  State<Param> createState() => _ParamState();
}

class _ParamState extends State<Param> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  child: Icon(Icons.question_mark_sharp),
                  width: 90,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 3),
                    color: funcTrade(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  child: Icon(Icons.question_mark_sharp),
                  width: 90,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 3),
                    color: funcTrade(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  child: Icon(Icons.question_mark_sharp),
                  width: 90,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 3),
                    color: funcTrade(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        funcTrade();
                      });
                    },
                    child: Icon(Icons.restart_alt_sharp)),
              )
            ],
          ),
        ),
      ],
    );
  }

  funcTrade() {
    final color0 = Colors.amber;
    final color1 = Colors.yellow;
    final color2 = Colors.blue;
    final color3 = Colors.red;
    final color4 = Colors.purple;
    final color5 = Colors.pink;
    final color6 = Colors.green;

    var random = Random().nextInt(6);

    print(random);

    if (random == 0) {
      return color0;
    } else if (random == 1) {
      return color1;
    } else if (random == 2) {
      return color2;
    } else if (random == 3) {
      return color3;
    } else if (random == 4) {
      return color4;
    } else if (random == 5) {
      return color5;
    } else if (random == 6) {
      return color6;
    }
  }
}
