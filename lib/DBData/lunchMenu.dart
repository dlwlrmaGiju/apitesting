class LunchMenu {
  final String id;
  final String type;
  final String date;
  final String menu;

  LunchMenu(this.id, this.type, this.date, this.menu);

  LunchMenu.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        date = json['date'],
        menu = json['menu'];

  Map<String, dynamic> toJson() => {
    'name': id,
    'email': type,
    'date' : date,
    'image' : menu,
  };
}