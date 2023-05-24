import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_login_db/api/api_connection.dart';
import 'package:http/http.dart' as http;

class OwnTask {
  int id;
  String title;
  String description;
  int user_id;
  int group_id;

  OwnTask(
    this.id,
    this.title,
    this.description,
    this.user_id,
    this.group_id
  );

  factory OwnTask.fromJson(Map<String, dynamic> json) => OwnTask(
    int.parse(json["id"]),
    json["title"],
    json["description"],
    int.parse(json["user_id"]),
    int.parse(json["group_id"]),
  );

  Map<String, dynamic> toJson() => {
    'id' : id.toString(),
    'title' : title,
    'description' : description,
    'user_id' : user_id.toString(),
    'group_id' : group_id.toString(),

  };
}