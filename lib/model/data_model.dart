import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class Studentmodel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String admissionNumber;
  @HiveField(4)
  final String std;
  @HiveField(5)
  final String parentName;
  @HiveField(6)
  final String place;
  @HiveField(7)
  String img;

  Studentmodel({
    required this.name,
    required this.age,
    required this.admissionNumber,
    required this.std,
    required this.parentName,
    required this.place,
    required this.img,
    this.id,
  });
}
