class News {
  final String title;
  final String email;
  final String dates;
  final String id;
  News(this.title, this.email, this.dates, this.id);

  News.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        email = json['email'],
        dates = json['dates'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'name': title,
    'email': email,
    'date' : dates,
    'id' : id,
  };

}