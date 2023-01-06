import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/model/data_model.dart';
import '../screens/searchScreen.dart';

final imageProvider = StateProvider<String>((ref) => 'X');

final addImageProvider = StateProvider<String>((ref) => 'X');

final searchprovider =
    StateProvider<List<StudentModel>>(((ref) => studentBoxList));
