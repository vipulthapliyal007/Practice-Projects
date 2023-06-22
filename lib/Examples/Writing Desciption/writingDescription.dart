/// Todo: Writing description using MultiTextFieldLine

import 'package:flutter/material.dart';

class WritingDescription extends StatefulWidget {
  const WritingDescription({Key? key}) : super(key: key);

  @override
  State<WritingDescription> createState() => _WritingDescriptionState();
}

class _WritingDescriptionState extends State<WritingDescription> {
  final TextEditingController _TextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Writing Description"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (_TextController.value.text.isEmpty)
            ? Text("Please Enter Message") : Text("Sent Message: ${_TextController.value.text}"),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _TextController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Enter a message here",
                  helperStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10)
                    ),
                  ),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _TextController.notifyListeners();
                });
              },
              child: Text("Send Message")
            ),
          ],
        ),
      ),
    );
  }
}
