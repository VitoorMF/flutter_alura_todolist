import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String image;
  final int difficultyLevel;

  //final bool isOpacityVisible;

  const Task(this.nome, this.image, this.difficultyLevel, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  var nivel = 0;
  int constantNivel = 0;
  bool levelMax = false;

  bool isAsset() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  maestryColor() {
    if (constantNivel >= widget.difficultyLevel * 10 &&
        constantNivel < widget.difficultyLevel * 20) {
      return Colors.green;
    } else if (constantNivel >= widget.difficultyLevel * 20 &&
        constantNivel < widget.difficultyLevel * 30) {
      return Colors.amberAccent;
    } else if (constantNivel >= widget.difficultyLevel * 30 &&
        constantNivel < widget.difficultyLevel * 40) {
      return Colors.orange;
    } else if (constantNivel >= widget.difficultyLevel * 40 &&
        constantNivel < widget.difficultyLevel * 50) {
      return Colors.red;
    } else if (constantNivel >= widget.difficultyLevel * 50 &&
        constantNivel < widget.difficultyLevel * 60) {
      return Colors.purple;
    } else if (constantNivel >= widget.difficultyLevel * 60) {
      return Colors.black;
    } else {
      return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: maestryColor(),
          ),
        ),
        Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white70,
              ),
              child: Row(
                children: [
                  Container(
                      width: 72,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: isAsset()
                              ? Image.asset(widget.image, fit: BoxFit.cover)
                              : Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                ))),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(fontSize: 24),
                              overflow: TextOverflow.ellipsis,
                            )),
                        Difficulty(difficultyLevel: widget.difficultyLevel),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: SizedBox(
                      height: 65,
                      width: 65,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              nivel++;
                              constantNivel++;
                              if (nivel == widget.difficultyLevel * 10) {
                                nivel = 0;
                              } else if (constantNivel >=
                                  widget.difficultyLevel * 60) {
                                levelMax = true;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.arrow_drop_up),
                              Text('UP', style: TextStyle(fontSize: 12))
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.blue,
                        value:
                            levelMax ? 1 : (nivel / widget.difficultyLevel) / 10,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    //"Nível: $nivel",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    levelMax ? 'MAX' : 'Nivel: $nivel',
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
