class movie {
  final int id;
  final String title;
  final String releaseDate;
  final String imgUrl;
  final String rating;
  final List<String> genre;
  final String createdAt;
  final String description;
  final String director;
  final List<String> cast;
  final String language;
  final String duration;

  movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.imgUrl,
    required this.rating,
    required this.genre,
    required this.createdAt,
    required this.description,
    required this.director,
    required this.cast,
    required this.language,
    required this.duration,
  });

  factory movie.fromJson(Map<String, dynamic> json) {
    return movie(
      id: json['id'] is String
          ? int.tryParse(json['id']) ?? 0
          : json['id'] ?? 0,
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      rating: json['rating']?.toString() ?? '',
      genre: List<String>.from(
          json['genre']?.map((item) => item.toString()) ?? []),
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? '',
      director: json['director'] ?? '',
      cast:
          List<String>.from(json['cast']?.map((item) => item.toString()) ?? []),
      language: json['language'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}
