import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeopardy_score_keeper/data.dart';

class ScoreHistory extends StatefulWidget {
  const ScoreHistory({super.key});

  @override
  State<ScoreHistory> createState() => _ScoreHistoryState();
}

class _ScoreHistoryState extends State<ScoreHistory> {
  final List<History> _history = [];
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _history.clear();

    _history.addAll(DataAccess.instance.getHistory());

    _history.sort((a, b) => a.gameDate!.compareTo(b.gameDate!));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final centerHeading = Theme.of(context).textTheme.labelMedium;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.biggest.width / 5;
      final List<double> widths = [
        width + 40,
        width + 10,
        width - 25,
        width - 25,
        width,
      ];

      return Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _history.clear();
                  _history.addAll(
                    DataAccess.instance.addHistory(
                      History(
                        gameDate: DateTime.now(),
                        correctAnswers: 45,
                        correctDoubleJeopardyCount: 3,
                        finalJeopardyBet: 10000,
                        finalScore: 0,
                      ),
                    ),
                  );
                });
              },
              child: Text("Add Sample")),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16), width: widths[0], child: Text('Date', textAlign: TextAlign.center, style: centerHeading)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16), width: widths[2], child: Text('Correct', textAlign: TextAlign.center, style: centerHeading)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: widths[3],
                  child: Text('Daily Doubles', textAlign: TextAlign.center, style: centerHeading)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16), width: widths[4], child: Text('Wager', textAlign: TextAlign.right, style: centerHeading)),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16), width: widths[1], child: Text('Final', textAlign: TextAlign.right, style: centerHeading)),
            ],
          ),
          Expanded(
            child: RawScrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      ...List.generate(
                        _history.length,
                        (index) {
                          final item = _history[index];
                          return InkWell(
                            onLongPress: () {
                              setState(() {
                                _history.clear();
                                _history.addAll(DataAccess.instance.delHistory(item.id!));
                              });
                            },
                            child: HistoryWidget(
                              history: item,
                              widths: widths,
                              // key: UniqueKey(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class HistoryWidget extends StatelessWidget {
  final History history;
  final List<double> widths;
  const HistoryWidget({
    super.key,
    required this.history,
    required this.widths,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: widths[0],
            child: Text(DateFormat("yyyy-MM-dd").format(history.gameDate!), textAlign: TextAlign.center, softWrap: false)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[2], child: Text('${history.correctAnswers}', textAlign: TextAlign.center)),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 16), width: widths[3], child: Text('${history.correctDoubleJeopardyCount}', textAlign: TextAlign.center)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[4], child: Text('${history.finalJeopardyBet}', textAlign: TextAlign.right)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[1], child: Text('${history.finalScore}', textAlign: TextAlign.right)),
      ],
    );
  }
}

class History {
  int? id;
  DateTime? gameDate;
  int finalScore;
  int correctAnswers;
  int correctDoubleJeopardyCount;
  int finalJeopardyBet;

  History({
    this.id,
    this.gameDate,
    this.finalScore = 0,
    this.correctAnswers = 0,
    this.correctDoubleJeopardyCount = 0,
    this.finalJeopardyBet = 0,
  }) {
    gameDate ??= DateTime.now();
  }
}
