import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_state/screens/screen_home.dart';

import '../db/functions/db_funtions.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import '../db/model/data_model.dart';
import '../controllers/provider.dart';
import 'package:flutter/services.dart';

class editStudent extends ConsumerWidget {
  editStudent({
    super.key,
    required this.passValue1,
    required this.index,
  });
  StudentModel passValue1;
  int index;

  var _nameController = TextEditingController();

  var _ageController = TextEditingController();

  var _classController = TextEditingController();

  var _emailController = TextEditingController();

  String? imagePath;

  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, ref) {
    _nameController.text = passValue1.name;
    _ageController.text = passValue1.age;
    _classController.text = passValue1.sClass;
    _emailController.text = passValue1.email;
    imagePath = ref.watch(imageProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 45),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          // FileImage(File(imagePath!))
                          // FileImage(File(passValue1.image))

                          // AssetImage('assets/pro.jpg'),
                          imagePath == 'X'
                              ? FileImage(File(passValue1.image))
                              : FileImage(File(imagePath!))
                      //
                      ),
                  Positioned(
                    bottom: 10,
                    right: 25,
                    child: InkWell(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onTap: () {
                        takePhoto(ref);
                      },
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',

                // hintText: '${widget.passValue1.name}',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _classController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Class',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                // hintText: 'Enter Your Name'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // const snackBar =SnackBar(
              //   content: Text("student updated"),
              // );
              // Scaffold.of(context).showSnackBar(snackBar);

              onAddStudentButtonClicked(index);
              // Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => ScreenHome()),
                  (route) => false);
              ref.read(imageProvider.notifier).state = "X";
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _sClass = _classController.text.trim();
    final _email = _emailController.text.trim();
    final _image = imagePath;

    final _id = DateTime.now().toString();
    if (_name.isEmpty || _age.isEmpty) {
      return;
    }
    // print('$_name $_age');

    final _student = StudentModel(
        name: _name,
        age: _age,
        sClass: _sClass,
        email: _email,
        image: imagePath!,
        id: _id);
    imagePath = 'X';
    print(imagePath);

    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, _student);
    // imagePath = 'X';
    getAllStudents();
    // imagePath = 'X';
  }

  void takePhoto(WidgetRef ref) async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    } else {
      this.imagePath = PickedFile.path;
      ref.read(imageProvider.notifier).state = PickedFile.path;
    }

    // setState(
    //   () {
    //     this.imagePath = PickedFile.path;
    //   },
    // );
  }
}
