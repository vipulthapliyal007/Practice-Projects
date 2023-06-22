import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int myIndex = 0; // For changing index on tap of bottomNavigation bar items
  // myIndex variable should be outside of the build method
  @override
  Widget build(BuildContext context) {

    List<Widget> widgetList = const [
      Text("Home", style: TextStyle(fontSize: 40),),
      Text("Music", style: TextStyle(fontSize: 40),),
      Text("News", style: TextStyle(fontSize: 40),),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bottom Navigation Bar"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // showSelectedLabels: false,
        // showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            // print("index: $index");
            myIndex = index;
            // print("myIndex: $myIndex");
          });
        },
        currentIndex: myIndex, // Changing tabs
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: "Music",
            backgroundColor: Colors.indigo,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "News",
            backgroundColor: Colors.orange,
          )
        ],
      ),
      body: Center(
        child: widgetList[myIndex],
      ),
    );
  }
}
