import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:users_login_db/api/api_connection.dart';
import 'package:users_login_db/users/fragments/tasks_screen.dart';
import 'package:users_login_db/users/model/group.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';

class HomeFragmentScreen extends StatelessWidget {
  late CurrentUser _currentUser = Get.put(CurrentUser());
  late List<Group> grupos = [];

  Future<dynamic> getData(int idUser) async {
    var idUserString = idUser.toString();
    var res = await http.post(
      Uri.parse(API.groups),
      body: {
        "user_id": idUserString,
      },
    );
    return res;
  }

  Future<void> showGroups() async {
    try {
      int idUser = _currentUser.user.id;

      var res = await getData(idUser);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        if (data["success"] == true) {
          for (var i = 0; i < data["groupsData"].length; i++) {
            Group group = Group.fromJson(data["groupsData"][i]);
            grupos.add(group);
          }
        } else {
          Fluttertoast.showToast(msg: "No groups at the moment");
        }
      }
    } catch (e) {
      print("Error :: " + e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    grupos = [];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFF1C8750),
        centerTitle: true,
        title: Text("Groups"),
      ),
          resizeToAvoidBottomInset: true,
          body: Container(
                child: FutureBuilder(
                  future: showGroups(),
                  builder: ((context, snapshot) {
                  return Scaffold(
                    backgroundColor: Color(0xFFFFFFFF),
                  resizeToAvoidBottomInset: true,
                  body: Container(
                      decoration: BoxDecoration(
                      image: DecorationImage(
                      image: AssetImage('images/redulogo.png'),
                    ),
                    ),
                    child: Wrap(
                  spacing: 1.0,
                  runSpacing: 1.0,
                  children: <Widget>[
                    if (grupos.length != 0)
                      for (var i = 0; i < grupos.length; i+=2)
                        Row(
                          children: [
                            cuadro(grupos[i], context),
                            if (i+1 < grupos.length) cuadro(grupos[i+1], context),
                          ],
                        )
                    else
                      IgnorePointer(
                        child: Container(
                          child: const Center(
                            child: Text(
                              'You don\'t have any GROUP!',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: 675,
                        ),
                      ),
                  ],
                    ),
                  ),
              );
            })),
          ),
        ),
    );
  }


  Widget cuadro(Group grupo, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(27.2),
            width: 150,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
             color:Color(0xFF1C8750),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                var idGroupString = grupo.id.toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TasksScreen(idGroup: idGroupString)));
              },
              child: Text(
                grupo.acronym,
                style: TextStyle(
                    fontSize: 38,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent, backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric( horizontal: 40),
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 3,
                  ),
                ),
                elevation: 0,
                shadowColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ],
    );
  }
}