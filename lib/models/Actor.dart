class Actor {
  var birthday;
  var known_for_department;
  var name;
  var gender;
  var biography;
  var popularity;
  var place_of_birth;
  var profile_path;
  Actor({required this.birthday,required this.known_for_department,required this.name,required this.gender,required this.biography,required this.popularity,required this.profile_path, required this.place_of_birth});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      birthday: json['birthday'],
      known_for_department: json['known_for_department'],
      name:json['name'],
      gender: json['gender'],
      biography: json['biography'],
      popularity: json['popularity'],
      place_of_birth: json['place_of_birth'],
      profile_path: json['profile_path'],
    );
  }
}