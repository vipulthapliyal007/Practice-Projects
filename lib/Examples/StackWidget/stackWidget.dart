import 'package:flutter/material.dart';

class UsingStack extends StatefulWidget {
  const UsingStack({Key? key}) : super(key: key);

  @override
  State<UsingStack> createState() => _UsingStackState();
}

class _UsingStackState extends State<UsingStack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body:
      /// Largers Children ki width and height stack ko assign hogi
      // Stack(
      //   children: [
      //     Container(
      //       width: 200,
      //       height: 200,
      //       color: Colors.blueGrey,
      //     ),
      //     Positioned( // to give spacing to widget that where it should appear
      //       left: 21,
      //       top: 21,
      //       bottom: 21,
      //       right: 21,
      //       child: Container(
      //         width: 160,
      //         height: 160,
      //         color: Colors.grey,
      //       ),
      //     ),
      //
      //
      //   ],
      // ),

      /// Parent Widget ki width and height stack ko assign hogi
      Container(
        color: Colors.red,
        width: 300,
        height: 300,
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.blueGrey,
            ),
            Positioned( // to give spacing to widget that where it should appear
              left: 21,
              top: 21,
              // bottom: 21,
              // right: 21,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey,
              ),
            ),


          ],
        ),
      ),
    );
  }
}
