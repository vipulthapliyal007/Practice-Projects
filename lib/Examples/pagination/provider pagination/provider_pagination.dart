import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationProvider with ChangeNotifier {
  bool isLoadingMore = false;
  bool hasNextPage = true;

  List posts = [];
  int page = 1;
  int limit = 20; /// No of posts at one go

  void toggleIsLoadingMore(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }

  void incrementPages(int value) {
    page = page + value;
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    // const url = 'https://jsonplaceholder.typicode.com/posts';
    final url = 'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit';

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
          // posts = json;
          // posts = posts + json;
        posts.addAll(json);
        notifyListeners();
      }
      else {
        hasNextPage = false;

        Future.delayed(const Duration(seconds: 2), () { // Use notify listeners here also
          hasNextPage = true;
          notifyListeners();
        });
        notifyListeners();
      }
    }
    else {
      debugPrint("Unexpected response");
    }
  }

  // scrollListener(scrollController) async {
  //   if(isLoadingMore) return;
  //
  //   if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
  //     isLoadingMore = true;
  //     // debugPrint("call");
  //     page = page + 1;
  //     debugPrint('Latest Page = $page');
  //
  //     await fetchPosts();
  //     isLoadingMore = false;
  //   }
  //   else {
  //     debugPrint("dont call");
  //   }
  //   // debugPrint("Scroll Listener called");
  // }

}