import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffects extends StatefulWidget {
  const ShimmerEffects({Key? key}) : super(key: key);

  @override
  State<ShimmerEffects> createState() => _ShimmerEffectsState();
}

class _ShimmerEffectsState extends State<ShimmerEffects> {
  bool enable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      enable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat List"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                if(enable) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: enable,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      title: Container(
                        color: Colors.white,
                        height: 10,
                        width: 100,
                      ),
                      subtitle: Container(
                        color: Colors.white,
                        height: 10,
                        width: 100,
                      ),
                    ),
                  );
                }
                else {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    // baseColor: Colors.blue,
                    highlightColor: Colors.grey.shade100,
                    // highlightColor: Colors.black,
                    enabled: enable,
                    child: const ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black,
                      ),
                      title: Text(
                        "John Wick",
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                      subtitle: Text("Who killed my dog"),
                    ),
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
