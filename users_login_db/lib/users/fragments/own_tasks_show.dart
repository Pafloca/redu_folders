import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:users_login_db/api/api_connection.dart';
import 'package:users_login_db/users/fragments/dashboard_of_fragments.dart';
import 'package:users_login_db/users/model/own_task.dart';
import 'package:users_login_db/users/model/taskAlumn.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';

class OwnTaskShow extends StatefulWidget {
  final OwnTask taskOwn;

  const OwnTaskShow(
      {super.key,
      required this.taskOwn});

  @override
  _OwnTaskShowState createState() => _OwnTaskShowState();
}

class _OwnTaskShowState extends State<OwnTaskShow> {

  getData() async {
    var res = await http.post(
      Uri.parse(API.deleteTask),
      body: {
        "task_id": widget.taskOwn.id.toString()
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1C8750),
          centerTitle: true,
          title: Text("Task"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 25),
                border: OutlineInputBorder(),
                enabled: false,
              ),
              controller: TextEditingController(text: widget.taskOwn.title),
              style: TextStyle(fontSize: 30),
              textAlign:
                  TextAlign.center, // Set the initial value of the TextField
            ),
            SizedBox(height: 20),
            Text(
                widget.taskOwn.description,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),
              Center(
          child: Material(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {
                getData();
                Fluttertoast.showToast(msg: "Task Eliminated Correctly");
                Get.to(DashboardOfFragments());
              },
              borderRadius: BorderRadius.circular(32),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                child: Text(
                  "Delete Task",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        )
          ],
        )));
  }
}
