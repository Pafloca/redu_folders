import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:users_login_db/api/api_connection.dart';
import 'package:users_login_db/users/fragments/new_own_task.dart';
import 'package:users_login_db/users/fragments/own_tasks_show.dart';
import 'package:users_login_db/users/fragments/task_edit_form.dart';
import 'package:users_login_db/users/fragments/task_form.dart';
import 'package:users_login_db/users/model/group.dart';
import 'package:users_login_db/users/model/own_task.dart';
import 'package:users_login_db/users/model/task.dart';
import 'package:users_login_db/users/model/taskAlumn.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class OwnTasksScreen extends StatelessWidget {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  late List<OwnTask> tasks = [];

  Future<dynamic> getData() async {
    var res = await http.post(
      Uri.parse(API.ownTasks),
      body: {
        "user_id": _currentUser.user.id.toString()
      },
    );
    return res;
  }

  Future<void> showTasks() async {
    try {
      await showGroups();

      var res = await getData();

      if (res.statusCode == 200) {
        print(res.body);
        var data = jsonDecode(res.body);

        if (data["success"] == true) {
          for (var i = 0; i < data["tasksData"].length; i++) {
            OwnTask task = OwnTask.fromJson(data["tasksData"][i]);
            tasks.add(task);
          }
        } else {
          Fluttertoast.showToast(msg: "No task at the moment");
        }
      }
    } catch (e) {
      print("Error :: " + e.toString());
    }
  }

  late List<Group> groups = [];

  Future<dynamic> getData2() async {
    var res = await http.post(
      Uri.parse(API.groups),
      body: {"user_id": _currentUser.user.id.toString()},
    );
    return res;
  }

  Future<void> showGroups() async {
    try {
      var res = await getData2();

      if (res.statusCode == 200) {
        print(res.body);
        var data = jsonDecode(res.body);

        if (data["success"] == true) {
          for (var i = 0; i < data["groupsData"].length; i++) {
            Group group = Group.fromJson(data["groupsData"][i]);
            groups.add(group);
          }
        }
      }
    } catch (e) {
      print("Error :: " + e.toString());
    }
  }

  findGroup(id) {
    for(int i = 0; i < groups.length; i++) {
      if(groups[i].id == id) {
        return groups[i].name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    tasks = [];
    return Center(
      child: FutureBuilder(
        future: showTasks(),
        builder: ((context, snapshot) {
          return Scaffold(
            appBar: AppBar(
        backgroundColor: Color(0xFF1C8750),
        centerTitle: true,
        title: Text("Personal Tasks"),
      ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                  for (var i = 0; i < tasks.length; i++)
                    cuadro(tasks[i], findGroup(tasks[i].group_id), context),
                ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xFF1C8750),
                onPressed :  () {
                  Get.to(NewOwnTask());
                },
                child: Icon(Icons.add,),
              ),
        );
      }),
    ));
    
  }
}

Widget cuadro(OwnTask task, String groupName, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C8750),
          borderRadius: BorderRadius.all(Radius.zero),border: Border.all(style: BorderStyle.solid),
        ),
        margin: const EdgeInsets.only(top: 15,bottom: 15),
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        height: 200,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OwnTaskShow(taskOwn: task),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                   groupName,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}