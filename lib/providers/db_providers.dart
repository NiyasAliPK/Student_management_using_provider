import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_managment_getx/model/data_model.dart';

class DbProvider with ChangeNotifier {
  List<Studentmodel> studentlistNotifier = [];

  List<Studentmodel> searchData = [];

  void addStudent(Studentmodel value) async {
    final studentDataBase =
        await Hive.openBox<Studentmodel>('Student_Data_Base');
    final id = await studentDataBase.add(value);
    value.id = id;

    studentDataBase.put(value.id, value);
    studentlistNotifier.clear();
    studentlistNotifier.addAll(studentDataBase.values);
    notifyListeners();
  }

  loadAllStudents() async {
    final studentDataBase =
        await Hive.openBox<Studentmodel>('Student_Data_Base');
    studentlistNotifier.clear();
    studentlistNotifier.addAll(studentDataBase.values);
    notifyListeners();
  }

  void deleteStudent(int id) async {
    final studentDataBase =
        await Hive.openBox<Studentmodel>('Student_Data_Base');
    await studentDataBase.delete(id);
    loadAllStudents();
  }

  updateStudent(Studentmodel value) async {
    final studentDataBase =
        await Hive.openBox<Studentmodel>('Student_Data_Base');
    await studentDataBase.put(value.id, value);
    loadAllStudents();
  }

  searchStudent(String value) {
    searchData.clear();
    for (var index in studentlistNotifier) {
      if (index.name.toString().toLowerCase().contains(value.toLowerCase())) {
        Studentmodel findings = Studentmodel(
          name: index.name,
          age: index.age,
          admissionNumber: index.admissionNumber,
          std: index.std,
          parentName: index.parentName,
          place: index.place,
          img: index.img,
        );
        searchData.add(findings);
        notifyListeners();
      }
    }
  }

  String img = '';

  pickimage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      notifyListeners();
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
    }
  }
}
