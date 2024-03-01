import 'dart:convert';

class UserFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String email = 'email';
  static final String isBeginner = 'isBeginner';

  static List<String> getFields() => [id, name, email, isBeginner];
}

class User {
  final int? id;
  final String name;
  final String email;
  final bool? isBeginner;

  User({this.id, required this.name, required this.email, this.isBeginner});

  User copy({int? id, String? name, String? email, bool? isBeginner}) => User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isBeginner: isBeginner ?? this.isBeginner);

  static User fromJson(Map<String, dynamic> json) => User(
      id: jsonDecode(json[UserFields.id]),
      name: json[UserFields.name],
      email: json[UserFields.email],
      isBeginner: jsonDecode(json[UserFields.isBeginner]));

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.isBeginner: isBeginner
      };
}
