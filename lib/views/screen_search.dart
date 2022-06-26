import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_managment_getx/providers/db_providers.dart';
import 'package:student_managment_getx/views/screen_updater.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.amberAccent.shade200, Colors.amber],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Search Students'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter student name to search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        controller: searchController,
                        onChanged: (value) {
                          Provider.of<DbProvider>(context, listen: false)
                              .searchStudent(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<DbProvider>(builder: ((context, value, child) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var data = value.searchData[index];
                        var encodedimg = data.img;
                        var images = const Base64Decoder().convert(encodedimg);
                        if (data.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Card(
                              color: const Color.fromARGB(255, 255, 226, 123),
                              child: ListTile(
                                onTap: () {
                                  Get.to(ScreenProfile(data: data));
                                },
                                title: Text(data.name.toUpperCase()),
                                leading: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: MemoryImage(images)),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: value.searchData.length),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}
