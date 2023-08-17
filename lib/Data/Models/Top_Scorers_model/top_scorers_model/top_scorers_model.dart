class TopScorersModel {
  final int success;
  final List<TopScorer> topScorers;

  TopScorersModel({required this.success, required this.topScorers});

  factory TopScorersModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> topScorersJson = json['result'];
    final List<TopScorer> topScorers = topScorersJson
        .map((dynamic scorerJson) => TopScorer.fromJson(scorerJson))
        .toList();

    return TopScorersModel(success: json['success'], topScorers: topScorers);
  }
}

class TopScorer {
  final int place;
  final String name;
  final int key;
  final String teamName;
  final int teamKey;
  final int goals;
  final int? assists;
  final int penaltyGoals;

  TopScorer({
    required this.place,
    required this.name,
    required this.key,
    required this.teamName,
    required this.teamKey,
    required this.goals,
    this.assists,
    required this.penaltyGoals,
  });

  factory TopScorer.fromJson(Map<String, dynamic> json) {
    return TopScorer(
      place: json['player_place'],
      name: json['player_name'],
      key: json['player_key'],
      teamName: json['team_name'],
      teamKey: json['team_key'],
      goals: json['goals'],
      assists: json['assists'],
      penaltyGoals: json['penalty_goals'],
    );
  }
}
