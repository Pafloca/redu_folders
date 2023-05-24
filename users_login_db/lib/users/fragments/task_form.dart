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

class TaskForm extends StatefulWidget {

  final int idTask;

  const TaskForm({super.key, required this.idTask});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late File _imgFile;
  late String? _imageFile ='';

  saveTaskAlumn() async {
    if (_formKey.currentState!.validate()) {
      int idUser = _currentUser.user.id;
      TaskAlumn task =
      TaskAlumn(
        1,
        _name,
        _description,
        _imageFile!,
        idUser,
        widget.idTask,
        0,
        ""
      );

      try{

      var res = await http.post(
        Uri.parse(API.tasksAlumnSave),
        body: task.toJson(),
      );

      if(res.statusCode == 200) {
        print(res.body);
        var resStudentTask = await jsonDecode(res.body);

        if(resStudentTask['success'] == true) {

          String data = resStudentTask['task'][0]['id'];

          print(data);

          final uri = Uri.parse(API.imageSave);
          var request = http.MultipartRequest('POST', uri);
          request.fields['id'] = data;
          var pic = await http.MultipartFile.fromPath("image", _imgFile.path);
          request.files.add(pic);
          var response = await request.send();

          if(response.statusCode == 200) {
            print('image Uploaded');
          } else {
            print('image not Uploaded');
          }

          Fluttertoast.showToast(msg: "Task Created Successfully");
          setState(() {
            _name="";
            _description="";
            _imageFile="";
          });

          Get.to(DashboardOfFragments());
          
        } else {
          Fluttertoast.showToast(msg: "Error ocurred. Try Again");
        }
      }

    } catch(e) {
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

  @override
  Widget build(BuildContext context) {
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
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,backgroundColor: 
                    Color(0xFF1C8750), 
                    side: BorderSide(width: 2,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: saveTaskAlumn,
                  child: Text(
                      'Make',style: TextStyle(fontSize: 18),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}