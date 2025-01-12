import 'package:hive_flutter/hive_flutter.dart';

class Data {
  List list = [];
  final _myBox = Hive.box("myBox");

  void initialData() {
    list = [
      ["Task Name", "Task Description", false]
    ];
  }

  void loadData() {
    list = _myBox.get("TaskList");
  }

  void updateData() {
    _myBox.put("TaskList", list);
  }
}
