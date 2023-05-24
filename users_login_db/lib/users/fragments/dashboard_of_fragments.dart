import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:users_login_db/users/fragments/home_fragment_screen.dart';
import 'package:users_login_db/users/fragments/own_tasks_screen.dart';
import 'package:users_login_db/users/fragments/profile_fragment_screen.dart';
import 'package:users_login_db/users/userPreferences/current_user.dart';

class DashboardOfFragments extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  List<Widget> _fragmentScreens = [
    HomeFragmentScreen(),
    OwnTasksScreen(),
    ProfileFragmentScreen(),
  ];

  List _navigationButtonsProperties = [
    {
      "icon": Icons.home,
      "label": "Home",
    },
    {
      "icon": Icons.task,
      "label": "Tasks",
    },
    {
      "icon": Icons.person,
      "label": "Profile",
    },
  ];

  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Obx(
                    () => _fragmentScreens[_indexNumber.value],
              )),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
            child: Obx(
                  () => BottomNavigationBar(
                backgroundColor: Color(0xFF1C8750),
                currentIndex: _indexNumber.value,
                onTap: (value) {
                  _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Color.fromARGB(255, 255, 255, 255),
                iconSize: 24,
                unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
                items: List.generate(3, (index) {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["icon"], color: Color.fromARGB(255, 0, 0, 0), shadows: [Shadow(color: Colors.white,blurRadius: 15)],),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
