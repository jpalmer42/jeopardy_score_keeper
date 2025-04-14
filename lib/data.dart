import 'package:flutter/foundation.dart';
import 'package:jeopardy_score_keeper/history.dart';
import 'package:sqlite3/sqlite3.dart';

class DataAccess {
  late Database db;
  DataAccess._() {
    db = sqlite3.open('jeopardy.sqlite');
    try {
      final resultSet = db.select("SELECT name FROM sqlite_master WHERE type='table' AND name='history'");
      if (resultSet.isEmpty) {
        _createTables();
      }
    } catch (e) {
      _createTables();
    }
  }
  static DataAccess? _instance;
  static DataAccess get instance => _instance ??= DataAccess._();

  _createTables() {
    try {
      db.execute(//
          '''
          CREATE TABLE history (
            id INTEGER NOT NULL PRIMARY KEY,
            gameDate LONG,
            correctAnswers INTEGER NOT NULL,
            correctDoubleJeopardyCount INTEGER NOT NULL,
            finalJeopardyBet INTEGER NOT NULL,
            finalScore INTEGER NOT NULL
          );
        ''' //
          );
    } catch (ex_) {
      debugPrint("Can't Create Table");
    }
  }

  List<History> getHistory() {
    List<History> response = [];
    final resultSet = db.select("SELECT * FROM history");
    for (final Row row in resultSet) {
      response.add(History(
        id: row['id'],
        gameDate: DateTime.fromMillisecondsSinceEpoch(row['gameDate']),
        correctAnswers: row['correctAnswers'],
        correctDoubleJeopardyCount: row['correctDoubleJeopardyCount'],
        finalJeopardyBet: row['finalJeopardyBet'],
        finalScore: row['finalScore'],
      ));
    }
    return response;
  }

  List<History> addHistory(History history) {
    history.gameDate ??= DateTime.now();

    final stmt = db.prepare("INSERT INTO history (gameDate, correctAnswers, correctDoubleJeopardyCount, finalJeopardyBet, finalScore) values (?, ?, ?, ?, ?)");
    stmt.execute([
      history.gameDate!.millisecondsSinceEpoch,
      history.correctAnswers,
      history.correctDoubleJeopardyCount,
      history.finalJeopardyBet,
      history.finalScore,
    ]);

    return getHistory();
  }

  List<History> delHistory(int id) {
    final stmt = db.prepare("DELETE FROM history WHERE id = ?");
    stmt.execute([
      id,
    ]);
    return getHistory();
  }
}
