import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../controllers/provider.dart';
import '../db/model/data_model.dart';

final List<StudentModel> studentBoxList =
    Hive.box<StudentModel>('student_db').values.toList();

// final searchProvider = StateProvider<String>((ref) => 'X');

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  late List<StudentModel> displayStudent =
      List<StudentModel>.from(studentBoxList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(searchprovider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 7),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search'),
                controller: _searchController,
                onChanged: (value) {
                  ref.read(searchprovider.notifier).state = studentBoxList
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  displayStudent = values;
                },
              ),
            ),
            Expanded(
              child: (displayStudent.length != 0)
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        File imageFile = File(displayStudent[index].image);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(imageFile),
                            radius: 20,
                          ),
                          title: Text(displayStudent[index].name),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: displayStudent.length,
                    )
                  : const Center(child: Text("The data is not Found")),
            ),
          ],
        ),
      ),
    );
  }

  // void searchStudentList(String value, WidgetRef ref) {
    // setState(() {
    //   displayStudent = studentBoxList
    //       .where((element) =>
    //           element.name.toLowerCase().contains(value.toLowerCase()))
    //       .toList();
    // });
  // }
}
