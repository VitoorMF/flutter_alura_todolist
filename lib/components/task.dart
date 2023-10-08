import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String image;
  final int difficulty;
  int maestria = 0;

  Task({
    this.maestria = 0,
    required this.nome,
    required this.image,
    required this.difficulty,
    Key? key,
  }) : super(key: key);

  int constantNivel = 0;
  bool levelMax = false;
  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isAsset() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  maestryColor() {
    if (widget.constantNivel >= widget.difficulty * 10 &&
        widget.constantNivel < widget.difficulty * 20) {
      return Colors.green;
    } else if (widget.constantNivel >= widget.difficulty * 20 &&
        widget.constantNivel < widget.difficulty * 30) {
      return Colors.amberAccent;
    } else if (widget.constantNivel >= widget.difficulty * 30 &&
        widget.constantNivel < widget.difficulty * 40) {
      return Colors.orange;
    } else if (widget.constantNivel >= widget.difficulty * 40 &&
        widget.constantNivel < widget.difficulty * 50) {
      return Colors.red;
    } else if (widget.constantNivel >= widget.difficulty * 50 &&
        widget.constantNivel < widget.difficulty * 60) {
      return Colors.purple;
    } else if (widget.constantNivel >= widget.difficulty * 60) {
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
                        Difficulty(difficultyLevel: widget.difficulty),
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
                              widget.nivel++;
                              widget.constantNivel++;
                              if (widget.nivel == widget.difficulty * 10) {
                                widget.nivel = 0;
                              } else if (widget.constantNivel >=
                                  widget.difficulty * 60) {
                                widget.levelMax = true;
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
                        value: widget.levelMax
                            ? 1
                            : (widget.nivel / widget.difficulty) / 10,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    widget.levelMax ? 'MAX' : 'Nivel: ${widget.nivel}',
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
