class EventOverview {
  int id;
  String title;
  String date;
  String imageURL;

  EventOverview({
    required this.id,
    required this.title,
    required this.date,
    required this.imageURL,
  });

  factory EventOverview.fromJson(Map<dynamic, dynamic> json) {
    return EventOverview(
      id: json['id'],
      title: json['fname'],
      date: json['date'],
      imageURL: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': title,
      'date': date,
      'image': imageURL,
    };
  }
}
