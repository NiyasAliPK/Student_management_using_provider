import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:student_managment_getx/model/data_model.dart';
import 'package:student_managment_getx/providers/db_providers.dart';
import 'package:student_managment_getx/views/home_screen.dart';

class HomeProvider with ChangeNotifier {
  void submission(
      {required BuildContext context,
      required String name,
      required String age,
      required String admn,
      required String std,
      required String parent,
      required String place}) async {
    if (name.isEmpty ||
        age.isEmpty ||
        admn.isEmpty ||
        std.isEmpty ||
        parent.isEmpty ||
        place.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text('Please fill all seven fields including image.'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      final student = Studentmodel(
          name: name,
          age: age,
          admissionNumber: admn,
          std: std,
          parentName: parent,
          place: place,
          img: Provider.of<DbProvider>(context, listen: false).img);
      Provider.of<DbProvider>(context, listen: false).addStudent(student);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text('Student added Succesfully.'),
        ),
        backgroundColor: Colors.greenAccent[400],
      ));
      Get.to(const ScreenHome());
    }
  }
}
