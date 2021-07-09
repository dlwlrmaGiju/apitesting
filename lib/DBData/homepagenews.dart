class HomeNews {
  final String title;
  final String email;
  final String dates;
  final String id;
  final String images;
  final String caption;
  final String category;
  late final String read;

  HomeNews(this.title, this.email, this.dates, this.id, this.images,
      this.caption, this.category, this.read);

  HomeNews.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        email = json['email'],
        dates = json['dates'],
        id = json['id'],
        images = json['images'],
        caption = json['captions'],
        category = json['category'],
        read = json['readIt'];

  Map<String, dynamic> toJson() => {
        'name': title,
        'email': email,
        'date': dates,
        'image': images,
        'id': id,
        'caption': caption,
        'category': category,
        'read': read
      };
  void setState(){
    if(read == "no"){
      read = "yes";
    }
  }

}
