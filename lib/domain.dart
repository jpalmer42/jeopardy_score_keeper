enum GameType {
  standard(2),
  celebrity(3);

  final int rounds;
  const GameType(this.rounds);
}

class GameInfo {
  GameInfo._() {
    newGame();
  }

  GameInfo? _instance;
  GameInfo get instance => _instance ??= GameInfo._();

  late GameType gameType;
  late int round;

  void newGame({GameType gameType = GameType.standard}) {
    this.gameType = gameType;
    round = 1;
  }

  static final Map<GameType, GameOption> gameOptions = {
    GameType.celebrity: GameOption(rounds: 3, roundNames: [
      "Jeopardy",
      "Double Jeopardy",
      "Tripple Jeopardy"
    ], roundDollars: {
      1: [100, 200, 300, 400, 500],
      2: [200, 400, 600, 800, 1000],
      3: [300, 600, 900, 1200, 1500],
    }),
    GameType.standard: GameOption(rounds: 2, roundNames: [
      "Jeopardy",
      "Double Jeopardy"
    ], roundDollars: {
      1: [200, 400, 600, 800, 1000],
      2: [400, 800, 1200, 1600, 2000],
    }),
  };
}

class GameOption {
  int rounds;
  List<String> roundNames;
  Map<int, List<int>> roundDollars;

  GameOption({
    required this.rounds,
    required this.roundNames,
    required this.roundDollars,
  });
}
