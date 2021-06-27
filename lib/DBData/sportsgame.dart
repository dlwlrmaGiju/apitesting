class Sportss {
  final String id;
  final String home;
  final String guest;
  final String homeScore;
  final String guestScore;
  final String status;
  final String link;
final String title;

  Sportss(this.id, this.home, this.guest, this.homeScore, this.guestScore, this.status, this.link, this.title);

  Sportss.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        home = json['Home'],
        guest = json['Guest'],
        homeScore = json['HomeScore'],
        guestScore = json['GuestScore'],
        status = json['status'],
        link = json['liveLink'],
        title = json['title'];
  Map<String, dynamic> toJson() => {
    'id': id,
    'Home': home,
    'Guest': guest,
    'HomeScore': homeScore,
    'GuestScore': guestScore,
    'status': status,
    'liveLink' : link,
    'title': title
  };
}