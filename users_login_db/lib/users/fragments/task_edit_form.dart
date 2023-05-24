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
import 'package:users_login_db/users/model/taskAlumn.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';

class TaskEditForm extends StatefulWidget {
  final int idTask;
  final int idTaskStudent;
  final DateTime dateTask;

  const TaskEditForm(
      {super.key, required this.idTask, required this.idTaskStudent, required this.dateTask});

  @override
  _TaskEditFormState createState() => _TaskEditFormState();
}

class _TaskEditFormState extends State<TaskEditForm> {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  final _formKey = GlobalKey<FormState>();
  List<TaskAlumn> tasksAlumns = [];
  String mark = "Not Corrected";
  String feedBack = "";
  late String _name;
  late String _description;
  late File _imgFile;
  late String? _imageFile = '';

  saveTaskAlumn() async {
    if (_formKey.currentState!.validate()) {
      int idUser = _currentUser.user.id;
      TaskAlumn task = TaskAlumn(widget.idTaskStudent, _name, _description,
          _imageFile!, idUser, widget.idTask, 0, "");

      try {
        var res = await http.post(
          Uri.parse(API.tasksAlumnUpdate),
          body: task.toJson(),
        );

        if (res.statusCode == 200) {
          print(res.body);
          var resStudentTask = await jsonDecode(res.body);

          if (resStudentTask['success'] == true) {
            String data = resStudentTask['task'][0]['id'];

            print(data);

            final uri = Uri.parse(API.imageSave);
            var request = http.MultipartRequest('POST', uri);
            request.fields['id'] = data;
            var pic = await http.MultipartFile.fromPath("image", _imgFile.path);
            request.files.add(pic);
            var response = await request.send();

            if (response.statusCode == 200) {
              print('image Uploaded');
            } else {
              print('image not Uploaded');
            }

            Fluttertoast.showToast(msg: "Task Edited Successfully");
            setState(() {
              _name = "";
              _description = "";
              _imageFile = "";
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

  _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imgFile = File(pickedFile!.path);
      _imageFile = _imgFile.path;
    });
  }

  Future<void> isFeedback() async {
    var res = await http.post(
      Uri.parse(API.getAlumnTask),
      body: {"task_id": widget.idTaskStudent.toString()},
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      if (data["success"] == true) {
        TaskAlumn tarea = TaskAlumn.fromJson(data["taskData"]);
        tasksAlumns.add(tarea);
        if (tasksAlumns[0].mark != 0) {
          mark = tasksAlumns[0].mark.toString();
          feedBack = tasksAlumns[0].feedback.toString();
        }
      } else {
        Fluttertoast.showToast(msg: "Error");
      }
    }
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
    print(widget.idTaskStudent);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C8750),
        centerTitle: true,
        title: Text("Edit Task"),
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
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Icon(Icons.camera_alt),
                  ),
                ),
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
                  onPressed: (){
                    if(dateBefore(widget.dateTask) && mark=="Not Corrected") {
                      Fluttertoast.showToast(msg: "The time limit has passed");
                    } else if(mark=="Not Corrected") {
                      saveTaskAlumn();
                    } else {
                      Fluttertoast.showToast(msg: "The task has been corrected");
                    }
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16.0),
                Center(
                    child: FutureBuilder(
                  future: isFeedback(),
                  builder: ((context, snapshot) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              labelText: 'Mark',
                              labelStyle: TextStyle(fontSize: 25),
                              border: OutlineInputBorder(),
                              enabled: false,
                            ),
                            controller: TextEditingController(text: mark),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign
                                .center, // Set the initial value of the TextField
                          ),
                          SizedBox(height: 20),
                          Text(
                            feedBack,
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      );                    
                  }),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
