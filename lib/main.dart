import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_managment_getx/model/data_model.dart';
import 'package:student_managment_getx/providers/db_providers.dart';
import 'package:student_managment_getx/providers/screen_editor_provider.dart';
import 'package:student_managment_getx/providers/screen_home_provier.dart';
import 'package:student_managment_getx/views/home_screen.dart';

void main(List<String> args) async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentmodelAdapter().typeId)) {
    Hive.registerAdapter(StudentmodelAdapter());
  }
  // await Provider.of(context). loadAllStudents();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => DbProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => EditingProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //CALL HERE
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const ScreenHome(),
    );
  }
}
