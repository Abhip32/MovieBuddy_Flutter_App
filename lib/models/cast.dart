class Cast {
  final List cast;
  Cast({required this.cast});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      cast: json['cast'],
    );
  }
}