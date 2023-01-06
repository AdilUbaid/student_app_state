
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app_state/widget/editStudent.dart';
import '../db/model/data_model.dart';

class ViewEdit extends StatelessWidget {
  ViewEdit({
    super.key,
    required this.passValue,
    required this.passId,
    // required this.index,
    // required this.studentList,
  });
  StudentModel passValue;
  final int passId;
  // int index;
  // Box<StudentModel> studentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('student name'),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: CircleAvatar(
                  radius: 100,
                  // final dpImage = passValue!.image;
                  // backgroundImage: passValue.image ==null
                  //           ? AssetImage('assets/pro.jpg')as ImageProvider
                  //           : FileImage(File(passValue.image)),
                  backgroundImage: FileImage(File(passValue.image)),
                ),
              ),
              ListTile(
                leading: Text(style: TextStyle(fontSize: 23,),"Name : ${passValue.name}"),
                // title: Text('${passValue.name}'),
              ),
               ListTile(
                leading: Text(style: TextStyle(fontSize: 23),"Age : ${passValue.age}"),
              ),
               ListTile(
                leading: Text(style: TextStyle(fontSize: 23,),"Class : ${passValue.sClass}"),
              ),
               ListTile(
                leading: Text(style: TextStyle(fontSize: 23,),"Email : ${passValue.email}"),
                // title: ,
              ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Setting'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          // onAddStudentButtonClicked();
          showModalBottomSheet<void>(
            
            context: context,
            isScrollControlled:true ,
            builder: (BuildContext context) {
              
              // return FormTextField(passId:gData.id!,passValue: gData,);
              return editStudent(
                            passValue1: passValue,
                            index: passId,
                            // studentList:studentList,
                            );
            },
          );
        },
        label: const Text(''),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> searchFind(var idNew) async {
    // final studentDB = await Hive.openBox<StudentModel>('student_db');
    // for (var data in StudentModel) {
    //   var data = studentDB.values
    //       .where((StudentModel) => StudentModel.id == passId)
    //       .toList();
    //   print(data.name);
    // }
  }
}
