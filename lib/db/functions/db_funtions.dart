// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotfier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
 final studentDB = await Hive.openBox<StudentModel>('student_db'); 
  final _id = await studentDB.add(value);
  // value.id = _id;
  // studentListNotfier..add(value.id);
  studentListNotfier.value.add(value);
  studentListNotfier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotfier.value.clear();
  
  studentListNotfier.value.addAll(studentDB.values);
  studentListNotfier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(id);
  // Text("Age : ${studentDB.get('name').where}")
  getAllStudents();
} 

Future<void> updateNew(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotfier.value.clear();
  
  // studentListNotfier.value.insert(studentDB.value,where((value.id) => _id));
  studentListNotfier.notifyListeners();
}
