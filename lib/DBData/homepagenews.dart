class HomeNews {
  final String title;
  final String email;
  final String dates;
  final String id;
  final String images;
  final String caption;

  HomeNews(this.title, this.email, this.dates, this.id, this.images, this.caption);

  HomeNews.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        email = json['email'],
        dates = json['dates'],
        id = json['id'],
        images = json['images'],
        caption = json['captions'];

  Map<String, dynamic> toJson() => {
    'name': title,
    'email': email,
    'date' : dates,
    'image' : images,
    'id' : id,
    'caption' : caption,
  };
}