/// Cliff Climbers Pagination
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationExampleThree extends StatefulWidget {
  const PaginationExampleThree({Key? key}) : super(key: key);

  @override
  State<PaginationExampleThree> createState() => _PaginationExampleTwoState();
}

class _PaginationExampleTwoState extends State<PaginationExampleThree> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool _hasNextPage = true;

  List posts = [];
  int page = 1;

  Future<void> fetchPosts() async {
    debugPrint("fetchPosts() called");
    const url = "https://api.cliffclimbers.in/api/all-filter-products-paginate";

    final uri = Uri.parse(url);

    final payloadObj = jsonEncode(
      {
        "subcategory": "Rucksack & Knapsack",
        "color": "",
        "size": "",
        "brand": "",
        "maxPrice": "",
        "minPrice": "",
        "sort": "",
        "page": "$page"
      }
    );

    debugPrint("before api call");

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: payloadObj
    );

    // debugPrint(response.body.toString());

    if(response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body.toString());
      // debugPrint(jsonResponse.toString());

      final json = jsonResponse["data"] as List;
      debugPrint(json.toString());

      if(json.isNotEmpty) {
        setState(() {
          // posts = json;
          // posts = posts + json;
          posts.addAll(json);
        });
      }
      else {

        setState(() {
          _hasNextPage = false;
        });

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _hasNextPage = true;
          });
        });
      }

    }
    else {
      debugPrint("Unexpected response");
    }
  }

  Future <void> _scrollListener() async {
    debugPrint("_scrollListener() called");
    if(isLoadingMore) return;

    if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      // debugPrint("call");
      page = page + 1;
      debugPrint('Latest Page = $page');
      await fetchPosts();

      setState(() {
        isLoadingMore = false;
      });
    }
    else {
      debugPrint("don't call");
    }
    // debugPrint("Scroll Listener called");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    // const url = 'https://jsonplaceholder.typicode.com/posts';
    const url = 'https://jsonplaceholder.typicode.com/posts?per_page=10&page=10';
    // const url = 'https://test.kindacode.com/one-two-three?search=flutter&sort=asc';

    final uri = Uri.parse(url);

    // debugPrint("origin ${uri.origin}"); // https://test.kindacode.com
    // debugPrint("host ${uri.host}"); // test.kindacode.com
    // debugPrint("scheme ${uri.scheme}");
    // debugPrint("port ${uri.port}"); // 443
    // debugPrint("path ${uri.path}"); // /one-two-three
    // debugPrint("pathSegments ${uri.pathSegments}"); // [one-two-three]
    // debugPrint("query${uri.query}"); // search=flutter&sort=asc
    // debugPrint("queryParameters ${uri.queryParameters.toString()}"); // {search: fl

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Example Three"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(12),
                controller: scrollController,
                itemCount: posts.length,
                // itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                itemBuilder: (context, index) {
                  // if(index < posts.length) {
                  final post = posts[index];
                  final title = post["id"];
                  final description = post["productType"];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(
                        '$title',
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        '$description',
                        maxLines: 2,
                      ),
                    ),
                  );
                  // }
                  /// else
                  // else {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                }
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              fetchPosts();
            },
            child: const Text("Load More"),
          ),

          if(isLoadingMore) ...[
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],

          if(_hasNextPage == false) ...[
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: const Center(
                child: Text('You have fetched all of the content'),
              ),
            ),
          ]
        ],
      ),
    );
  }

}
