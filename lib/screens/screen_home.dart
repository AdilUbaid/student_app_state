import 'package:flutter/material.dart';
import 'package:student_app_state/db/functions/db_funtions.dart';
import 'package:student_app_state/screens/searchScreen.dart';
import '../widget/addStudent.dart';
import '../widget/listViewStudent.dart';



class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      body:  SafeArea(
        child: ListViewStudent(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          // onAddStudentButtonClicked();
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            // enableDrag: true,
            // elevation: 1000,
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  // child: FormTextField(passId:gData.id!,passValue: ata,));
                  child: FormTextField());
            },
          );
        },
        label: const Text(''),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
