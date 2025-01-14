import 'package:flutter/material.dart';
import 'package:to_do_app/local_storage/data.dart';
import 'package:to_do_app/util/add_dialog.dart';
import 'package:to_do_app/util/edit_dialog.dart';
import 'package:to_do_app/util/help_dialog.dart';
import 'package:to_do_app/util/to_do_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  final _myBox = Hive.box("myBox");

  Data data = Data();
  @override
  void initState() {
    _myBox.get("TaskList") == null ? data.initialData() : data.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: addTaskButton(),
    );
  }

  FloatingActionButton addTaskButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        addTask();
      },
      label: Text(
        "Add new Task",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Colors.tealAccent.shade700,
    );
  }

  Padding buildBody() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // search bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All ToDo's List",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      data.list.clear();
                    });
                    data.updateData();
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.black,
                  iconSize: 25,
                ),
              ],
            ),
          ), // heading and delete all button
          Expanded(
            child: ListView.builder(
              itemCount: data.list.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  taskName: data.list[index][0],
                  taskDescription: data.list[index][1],
                  taskCompleted: data.list[index][2],
                  onChanged: (value) => onChanged(value, index),
                  deleteTask: (context) => removeTask(index),
                  editTask: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EditDialog(
                            controller1: _controller1,
                            controller2: _controller2,
                            save: () {
                              setState(() {
                                _controller1.text.isNotEmpty
                                    ? data.list[index][0] = _controller1.text
                                    : HomePage();
                                _controller2.text.isNotEmpty
                                    ? data.list[index][1] = _controller2.text
                                    : HomePage();
                                _controller1.clear();
                                _controller2.clear();
                              });
                              data.updateData();
                              Navigator.of(context).pop();
                            },
                            cancel: () => Navigator.of(context).pop());
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(style: BorderStyle.none),
    );
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        shadowColor: Colors.teal,
        title: Text("To Do App"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
        actions: [
          buildHelpButton(),
        ],
        elevation: 10,
      );

  IconButton buildHelpButton() {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return HelpDialog();
            });
      },
      icon: Icon(Icons.help),
      color: Colors.white,
      iconSize: 35,
    );
  }

  void saveTask() {
    setState(() {
      _controller1.text.isNotEmpty
          ? data.list.add([_controller1.text, _controller2.text, false])
          : HomePage();
      _controller1.clear();
      _controller2.clear();
    });
    data.updateData();
    Navigator.of(context).pop();
  }

  void onChanged(bool? value, int index) {
    setState(() {
      data.list[index][2] = !data.list[index][2];
    });
    data.updateData();
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddDialog(
            controller1: _controller1,
            controller2: _controller2,
            save: saveTask,
            cancel: () => Navigator.of(context).pop());
      },
    );
  }

  void removeTask(int index) {
    setState(() {
      data.list.removeAt(index);
    });
    data.updateData();
  }
}
