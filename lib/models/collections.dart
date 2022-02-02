class Collection {
  final int albumID;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Collection._({
    required this.albumID,
    required this.id,
    required this.thumbnailUrl,
    required this.title,
    required this.url,
  });

  factory Collection(Map<String, dynamic> json) {
    return Collection._(
      albumID: json['albumId'] as int,
      id: json['id'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );
  }
}
