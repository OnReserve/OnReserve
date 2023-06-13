class User {
  int id;
  String firstName;
  String lastName;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String? phoneNumber;
  String? profilePic;
  String? coverPic;
  String? bio;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.phoneNumber,
    this.profilePic,
    this.coverPic,
    this.bio,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['fname'],
      lastName: json['lname'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      phoneNumber: json['phoneNumber'],
      profilePic: json['profilePic'],
      coverPic: json['coverPic'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': firstName,
      'lname': lastName,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'coverPic': coverPic,
      'bio': bio,
    };
  }
}
