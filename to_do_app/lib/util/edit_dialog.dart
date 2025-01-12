import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditDialog extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller1;
  // ignore: prefer_typing_uninitialized_variables
  final controller2;
  VoidCallback save;
  VoidCallback cancel;
  EditDialog({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.save,
    required this.cancel,
  });

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(style: BorderStyle.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.tealAccent,
      content: SizedBox(
        height: 350,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 25,
          children: [
            Text(
              "Edit Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                hintText: "Enter task name",
                focusedBorder: textFieldBorder(),
                enabledBorder: textFieldBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                hintText: "Enter task description",
                focusedBorder: textFieldBorder(),
                enabledBorder: textFieldBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 30,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    save();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    cancel();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
