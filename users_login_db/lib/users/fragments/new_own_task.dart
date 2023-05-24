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
import 'package:users_login_db/users/model/group.dart';
import 'package:users_login_db/users/model/own_task.dart';
import 'package:users_login_db/users/model/taskAlumn.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';

class NewOwnTask extends StatefulWidget {
  @override
  _NewOwnTaskState createState() => _NewOwnTaskState();
}

class _NewOwnTaskState extends State<NewOwnTask> {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late int _groupId;
  String dropdownValue = '';
  late List<String> groupsString = [];
  late List<Group> groups = [];

  Future<dynamic> getData() async {
    var res = await http.post(
      Uri.parse(API.groups),
      body: {"user_id": _currentUser.user.id.toString()},
    );
    return res;
  }

  Future<void> showGroups() async {
    try {
      var res = await getData();

      groupsString = [];
      groups = [];

      if (res.statusCode == 200) {
        print(res.body);
        var data = jsonDecode(res.body);

        if (data["success"] == true) {
          for (var i = 0; i < data["groupsData"].length; i++) {
            Group group = Group.fromJson(data["groupsData"][i]);
            String name = group.id.toString() + '.' + group.name;
            groupsString.add(name);
            groups.add(group);
          }

        }
      }
    } catch (e) {
      print("Error :: " + e.toString());
    }
  }

  saveTaskAlumn() async {
    if (_formKey.currentState!.validate()) {
      if(dropdownValue == '') {
        Fluttertoast.showToast(msg: "Please choose one group!!");                
      } else {
      int idUser = _currentUser.user.id;
      OwnTask task = OwnTask(
        1,
        _name,
        _description,
        idUser,
        int.parse(dropdownValue),
      );

      try {
        var res = await http.post(
          Uri.parse(API.addOwnTask),
          body: task.toJson(),
        );

        if (res.statusCode == 200) {
          print(res.body);
          var resStudentTask = await jsonDecode(res.body);

          if (resStudentTask['success'] == true) {

            Fluttertoast.showToast(msg: "Task Created Successfully");
            setState(() {
              _name = "";
              _description = "";
            });

            Get.to(DashboardOfFragments());
          } else {
            Fluttertoast.showToast(msg: "Error ocurred. Try Again");
          }
        }
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future: showGroups(),
            builder: ((context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFF1C8750),
                  centerTitle: true,
                  title: const Text('Make Task'),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Title';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          DropdownButtonFormField(items: groupsString.map((name) {
                            return DropdownMenuItem(child: Text(name),
                            value: name,);
                          }).toList(),
                          onChanged: (value) {
                            if(value != null) {
                              dropdownValue = value.substring(0,1);
                              print(dropdownValue);
                            }
                          }),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Color(0xFF1C8750),
                              side: BorderSide(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: saveTaskAlumn,
                            child: Text(
                              'Make',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })));
  }
}
