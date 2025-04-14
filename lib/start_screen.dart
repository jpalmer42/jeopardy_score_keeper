import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jeopardy_score_keeper/history.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height);
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeopardy Score Keeper'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: width,
            height: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: InkWell(
                    autofocus: true,
                    // overlayColor: WidgetStateColor.fromMap({}),
                    customBorder: Border.all(color: const Color.fromRGBO(255, 255, 255, 1), width: 12),
                    child: Image.asset('assets/images/start-button.png').animate(
                      effects: [ShimmerEffect(angle: 0.45, duration: 2.seconds)],
                      onPlay: (controller) {
                        controller.repeat();
                      },
                    ),
                    onTap: () {
                      debugPrint("Test");
                    },
                  ),
                ),
                const Divider(),
                Text(
                  "Play History",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Expanded(child: const ScoreHistory()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
