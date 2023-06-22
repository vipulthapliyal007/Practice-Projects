import 'package:flutter/material.dart';

class MapExample extends StatefulWidget {
  const MapExample({Key? key}) : super(key: key);

  @override
  State<MapExample> createState() => _MapExampleState();
}

class _MapExampleState extends State<MapExample> {
  var userArray = ['User 1', 'User 2', 'User 3', 'User 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Method"),
      ),
      body: Column(
        children: [
          /// Todo: List.generate() arrow function
          // ...List.generate(userArray.length, (index) => Container(
          //     child: Text(userArray.elementAt(index).toString()),
          //   ),
          // ),

          /// Todo: List.generate()
          // ...List.generate(userArray.length, (index) {
          //     return Container(
          //       child: Text(userArray.elementAt(index).toString()),
          //     );
          //   }
          // ),

          /// Todo: List.generate with key,value pair
          // ...List.generate(userArray.length, (index) => Container(
          //     child: Text(userArray.elementAt(index).toString()),
          //   ),
          // ),
          // ...List.generate(userArray.asMap().entries.length, (index) => Text(userArray.elementAt(index).toString())),
          // ...List.generate(userArray),


          Text("hoi"),

          /// Todo: map.toList() arrow function
          // ...userArray.map((e) => Text(e.toString())).toList(),

          /// Todo: map.toList() without arrow function
          // ...userArray.map((e) {
          //   return Text(e.toString());
          // }).toList(),
          
          /// Todo: map() using key value pairs
          // ...userArray.asMap().entries.map((e) => Column(
          //   children: [
          //     Text(e.key.toString()),
          //     Text(e.value.toString()),
          //   ],
          // )),

          // Text("Yoi"),
        ],
      ),
    );
  }
}
