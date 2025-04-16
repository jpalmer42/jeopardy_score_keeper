import 'package:flutter/material.dart';
import 'package:jeopardy_score_keeper/domain.dart';

class PlayBoard extends StatefulWidget {
  const PlayBoard({super.key});

  @override
  State<PlayBoard> createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  late GameInfo _gameInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeopardy Score Keeper'),
        actions: [
          DropdownButton(
            value: 2,
            items: [
              DropdownMenuItem(value: 1, child: Text("Celeb - 3 Rounds")),
              DropdownMenuItem(value: 2, child: Text("200 - 1500")),
              DropdownMenuItem(value: 3, child: Text("400 - 1500")),
              DropdownMenuItem(value: 4, child: Text("Final")),
            ],
            onChanged: (value) {},
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Column(children: [
            Text("Single Jeopardy"),
            Row(
              children: [],
            ),
          ]),
        ),
      ),
    );
  }
}
