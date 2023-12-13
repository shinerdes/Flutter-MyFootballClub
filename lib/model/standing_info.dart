class StandingInfo {
  const StandingInfo({
    required this.rank,
    required this.logo,
    required this.name,
    required this.played,
    required this.points,
    required this.goalsDiff,
  });

  final int rank;
  final String logo;
  final String name;
  final int played;
  final int points;
  final int goalsDiff;
}




//{rank: 19, team: {id: 62, name: Sheffield Utd, logo: https://media-4.api-sports.io/football/teams/62.png},
// points: 5, goalsDiff: -21, group: Premier League, form: DWLLL, status: same, description: Relegation - Championship,
// all: {played: 12, win: 1, draw: 2, lose: 9, goals: {for: 10, against: 31}}, 
//home: {played: 6, win: 1, draw: 1, lose: 4, goals: {for: 6, against: 16}}, 
//away: {played: 6, win: 0, draw: 1, lose: 5, goals: {for: 4, against: 15}},
// update: 2023-11-13T00:00:00+00:00}


