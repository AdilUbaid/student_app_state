import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String sClass;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.sClass,
      required this.email,
      required this.image,
      required this.id});
}
