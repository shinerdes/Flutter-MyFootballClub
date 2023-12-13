class ClubInfomation {
  const ClubInfomation({
    required this.name,
    required this.logo,
    required this.league,
    required this.recentFive,
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
    required this.forGoals,
    required this.againstGoals,
    required this.cleanSheet,
    required this.failedToScore,
    required this.bestFormation,
    required this.bestFormationplay,
  });

  final String name;

  final String logo;
  final String league;

  final String recentFive;

  final int played;
  final int win;
  final int draw;
  final int lose;

  final int goals;
  final int forGoals;
  final int againstGoals;

  final int cleanSheet;
  final int failedToScore;

  final String bestFormation;
  final int bestFormationplay;
}


/*
flutter: {league: {id: 39, name: Premier League, country: England, logo: https://media-4.api-sports.io/football/leagues/39.png,
 flag: https://media-4.api-sports.io/flags/gb.svg, season: 2023}, team: {id: 40, name: Liverpool,
  logo: https://media-4.api-sports.io/football/teams/40.png}, form: DWWWWWLDWWDW,
   fixtures: {played: {home: 6, away: 6, total: 12}, wins: {home: 6, away: 2, total: 8}, draws: {home: 0, away: 3, total: 3}
   , loses: {home: 0, away: 1, total: 1}}, goals: {for: {total: {home: 17, away: 10, total: 27}, 
   average: {home: 2.8, away: 1.7, total: 2.3}, 
   minute: {0-15: {total: 1, percentage: 3.85%}, 16-30: {total: 3, percentage: 11.54%}, 31-45: {total: 5, percentage: 19.23%},
    46-60: {total: 5, percentage: 19.23%}, 61-75: {total: 4, percentage: 15.38%}, 76-90: {total: 4, percentage: 15.38%}, 91-105:
     {total: 4, percentage: 15.38%}, 106-120: {total: null, percentage: null}}}, 
     against: {total: {home: 2, away: 8, total: 10}, average: {home: 0.3, away: 1.3, total: 0.8},
      minute: {0-15: {total: 2, <…>
*/