class movie {
  final int id;
  final String title;
  final String imageUrl;
  final int rating;
  final String genre;
  final String duration;

  movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.genre,
    required this.duration,
  });

  factory movie.fromJson(Map<String, dynamic> json) {
    return movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? "noTitle",
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : 'https://placehold.co/600x400',
      rating: json['rating'] ?? 0,
      genre: json['genre'] ?? 'Unknown',
      duration: json['duration'] ?? '0 min',
    );
  }
}
