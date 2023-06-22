import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatefulWidget {
  const CustomDropDownWidget({Key? key}) : super(key: key);

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  bool isOpen = false;

  String selectOption = "Select Option";

  List<String> politicsList = ["Left Wing", "Liberal", "Moderate", "Conservative", "Libertarian", "Appolitical"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drop Down"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              InkWell(
                onTap: () {
                  isOpen = !isOpen;
                  setState(() {
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.grey.shade300,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(50),
                    //   topRight: Radius.circular(50),
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectOption),
                        Icon( isOpen ? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ),
              ),
              if(isOpen)
                ListView(
                primary: true,
                shrinkWrap: true,
                children: politicsList.map((e) => Container(
                  decoration: BoxDecoration(
                    color: selectOption == e  ? Colors.pink : Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        selectOption = e;
                        isOpen = false;
                        setState(() {

                        });
                      },
                      child: Text(e)
                    ),
                  ),
                )).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
