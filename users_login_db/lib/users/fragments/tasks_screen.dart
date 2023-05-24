import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:users_login_db/api/api_connection.dart';
import 'package:users_login_db/users/fragments/task_edit_form.dart';
import 'package:users_login_db/users/fragments/task_form.dart';
import 'package:users_login_db/users/model/task.dart';
import 'package:users_login_db/users/model/taskAlumn.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class TasksScreen extends StatelessWidget {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  late List<Task> tasks = [];
  late List<dynamic> taskRealized = [];
  late Map<dynamic, dynamic> taskRealized2 = {};

  final String idGroup;

  TasksScreen({super.key, required this.idGroup});

  Future<dynamic> getData(String idGroup) async {
    var res = await http.post(
      Uri.parse(API.tasks),
      body: {
        "group_id": idGroup,
        "user_id": _currentUser.user.id.toString()
      },
    );
    return res;
  }

  Future<void> showTasks() async {
    try {
      var res = await getData(idGroup);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        var data2 = data["taskId"];

        for(var i = 0; i < data2.length; i++) {
          taskRealized.add(data2[i]["task_id"]);
          taskRealized2[i] = {data2[i]["task_id"] : data2[i]["id"]};
        }
        print(taskRealized);
        print(taskRealized2);

        if (data["success"] == true) {
          for (var i = 0; i < data["tasksData"].length; i++) {
            Task task = Task.fromJson(data["tasksData"][i]);
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

  findItem(int id) {
    for(int i = 0; i < taskRealized.length; i++) {
      if(int.parse(taskRealized[i]) == id) {
        print(taskRealized2[i][taskRealized[i]]);
        return int.parse(taskRealized2[i][taskRealized[i]]);
      }
    }
    return false;
  }

  dateBefore(DateTime date) {
    DateTime now = new DateTime.now();
    if(now.isAfter(date)) {
      return true;
    } else {
      return false;
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
                centerTitle: true,
                backgroundColor: Color(0xFF1C8750),
                title: const Text("Tasks"),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              resizeToAvoidBottomInset: true,
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/redulogo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                child:SingleChildScrollView(
                  child: Column(
                  children: <Widget>[
                  for (var i = 0; i < tasks.length; i++)
                    if(dateBefore(tasks[i].date_end) &&
                     findItem(tasks[i].id) == false)
                      cuadro3(tasks[i], context)
                    else
                      if(findItem(tasks[i].id) != false)
                        cuadro2(tasks[i], findItem(tasks[i].id), context)
                      else
                        cuadro(tasks[i], context)
                ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}


Widget cuadro3(Task task, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.zero),border: Border.all(style: BorderStyle.solid),
        ),
        margin: const EdgeInsets.only(top: 15,bottom: 15),
        padding: const EdgeInsets.all(5.0),
        width: double.infinity,
        height: 200,
        child: InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: "You didn't make it on time. Sorry...",);
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
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                  ),
                  Text(
                    task.date_end.toString().substring(0, 10),
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



Widget cuadro2(Task task, int idTaskStudent, context) {
  return Column(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C8750),
          borderRadius: BorderRadius.all(Radius.zero),border: Border.all(style: BorderStyle.solid),
        ),
        margin: const EdgeInsets.only(top: 15,bottom: 15),
        padding: const EdgeInsets.all(5.0),
        width: double.infinity,
        height: 200,
        child: InkWell(
          onTap: () {
            var idTaskString = task.id;
            var dateTask = task.date_end;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskEditForm(idTask: idTaskString, idTaskStudent: idTaskStudent, dateTask: dateTask),
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
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                  ),
                  Text(
                    task.date_end.toString().substring(0, 10),
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



Widget cuadro(Task task, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.zero),border: Border.all(style: BorderStyle.solid),
        ),
        margin: const EdgeInsets.only(top: 15,bottom: 15),
        padding: const EdgeInsets.all(5.0),
        width: double.infinity,
        height: 200,
        child: InkWell(
          onTap: () {
            var idTaskString = task.id;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskForm(idTask: idTaskString),
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
                  Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.black,
                  ),
                  Text(
                    task.date_end.toString().substring(0, 10),
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