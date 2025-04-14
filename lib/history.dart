import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    _history.add(History(correctAnswers: 12, correctDoubleJeopardyCount: 2, finalScore: -500, finalJeopardyBet: 0));
    _history.add(History(correctAnswers: 13, correctDoubleJeopardyCount: 1, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 14, correctDoubleJeopardyCount: 3, finalScore: 20000, finalJeopardyBet: 10000));
    _history.add(History(correctAnswers: 15, correctDoubleJeopardyCount: 1, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 16, correctDoubleJeopardyCount: 2, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 17, correctDoubleJeopardyCount: 3, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 18, correctDoubleJeopardyCount: 3, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 19, correctDoubleJeopardyCount: 2, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 20, correctDoubleJeopardyCount: 1, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 21, correctDoubleJeopardyCount: 1, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 22, correctDoubleJeopardyCount: 1, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 23, correctDoubleJeopardyCount: 2, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 24, correctDoubleJeopardyCount: 2, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 25, correctDoubleJeopardyCount: 2, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 26, correctDoubleJeopardyCount: 3, finalScore: 10000, finalJeopardyBet: 100));
    _history.add(History(correctAnswers: 27, correctDoubleJeopardyCount: 3, finalScore: 10000, finalJeopardyBet: 100));

    _history.sort((a, b) => a.when!.compareTo(b.when!));
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
          Row(
            children: [
              Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[0], child: Text('Date', textAlign: TextAlign.center, style: centerHeading)),
              Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[2], child: Text('Answered', textAlign: TextAlign.center, style: centerHeading)),
              Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[3], child: Text('Daily Doubles', textAlign: TextAlign.center, style: centerHeading)),
              Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[4], child: Text('Final Bet', textAlign: TextAlign.right, style: centerHeading)),
              Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[1], child: Text('Final Score', textAlign: TextAlign.right, style: centerHeading)),
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
                          return HistoryWidget(
                            history: item,
                            widths: widths,
                            // key: UniqueKey(),
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
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[0], child: Text(DateFormat("yyyy-MM-dd").format(history.when!), textAlign: TextAlign.center, softWrap: false)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[2], child: Text('${history.correctAnswers}', textAlign: TextAlign.center)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[3], child: Text('${history.correctDoubleJeopardyCount}', textAlign: TextAlign.center)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[4], child: Text('${history.finalJeopardyBet}', textAlign: TextAlign.right)),
        Container(padding: EdgeInsets.symmetric(horizontal: 16), width: widths[1], child: Text('${history.finalScore}', textAlign: TextAlign.right)),
      ],
    );
  }
}

class History {
  DateTime? when;
  int finalScore;
  int correctAnswers;
  int correctDoubleJeopardyCount;
  int finalJeopardyBet;

  History({
    this.when,
    this.finalScore = 0,
    this.correctAnswers = 0,
    this.correctDoubleJeopardyCount = 0,
    this.finalJeopardyBet = 0,
  }) {
    when ??= DateTime.now();
  }
}
