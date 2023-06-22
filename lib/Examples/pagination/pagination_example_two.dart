import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationExampleTwo extends StatefulWidget {
  const PaginationExampleTwo({Key? key}) : super(key: key);

  @override
  State<PaginationExampleTwo> createState() => _PaginationExampleTwoState();
}

class _PaginationExampleTwoState extends State<PaginationExampleTwo> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool _hasNextPage = true;

  List posts = [];
  int page = 1;

  Future<void> fetchPosts() async {
    debugPrint("fetchPosts() called");
    // const url = 'https://jsonplaceholder.typicode.com/posts';
    final url = 'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=20';

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


    final response = await http.get(uri);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;

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
      debugPrint("dont call");
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
        title: const Text("Pagination Example Two"),
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
                  final title = post["title"];
                  final description = post["body"];
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
