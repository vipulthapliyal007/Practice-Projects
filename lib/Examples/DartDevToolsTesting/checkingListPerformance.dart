import 'package:flutter/material.dart';

class ListPerformance extends StatefulWidget {
  const ListPerformance({Key? key}) : super(key: key);

  @override
  State<ListPerformance> createState() => _ListPerformanceState();
}

class _ListPerformanceState extends State<ListPerformance> {
  List elements = [];


  @override
  Widget build(BuildContext context) {
    elements.clear();
    for(int i = 0; i < 1000; i++) {
      elements.add(i);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("List Performance"),
      ),
      body: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print("Tapped");
            },
            child: Card(
              child: Text("i: ${elements[index]}")
            )
          );
        }
      ),
    );
  }
}
