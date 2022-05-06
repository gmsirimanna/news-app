import 'package:flutter/cupertino.dart';

final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, isLoggedIn, username, password, email, listOfArticles
  ];

  static final String id = '_id';
  static final String isLoggedIn = 'isLoggedIn';
  static final String username = 'username';
  static final String password = 'password';
  static final String email = 'email';
  static final String listOfArticles = 'listOfArticles';
}

class User {
  final int id;
  final bool isLoggedIn;
  final String username;
  final String password;
  final String email;
  final String listOfArticles;

  const User({
    this.id,
    @required this.isLoggedIn,
    @required this.username,
    @required this.password,
    @required this.email,
    @required this.listOfArticles,
  });

  User copy({
    int id,
    bool isLoggedIn,
    String username,
    String password,
    String email,
    String listOfArticles,
  }) =>
      User(
        id: id ?? this.id,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        listOfArticles: listOfArticles ?? this.listOfArticles,
      );

  static User fromJson(Map<String, Object> json) => User(
        id: json[UserFields.id] as int,
        isLoggedIn: json[UserFields.isLoggedIn] == 1,
        username: json[UserFields.username] as String,
        password: json[UserFields.password] as String,
        email: json[UserFields.email] as String,
        listOfArticles: json[UserFields.listOfArticles] as String,
      );

  Map<String, Object> toJson() => {
        UserFields.id: id,
        UserFields.password: password,
        UserFields.isLoggedIn: isLoggedIn ? 1 : 0,
        UserFields.username: username,
        UserFields.email: email,
        UserFields.listOfArticles: listOfArticles,
      };
}
