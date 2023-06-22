import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuhee/Examples/pagination/provider%20pagination/provider_pagination.dart';

class ProviderPaginationScreen extends StatefulWidget {
  const ProviderPaginationScreen({Key? key}) : super(key: key);

  @override
  State<ProviderPaginationScreen> createState() => _ProviderPaginationScreenState();
}

class _ProviderPaginationScreenState extends State<ProviderPaginationScreen> {
  final _scrollController = ScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final paginationProvider = Provider.of<PaginationProvider>(context, listen: false);

    _scrollController.addListener(_scrollListener);
    paginationProvider.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final paginationProvider = Provider.of<PaginationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Example Two"),
      ),
      body: Consumer<PaginationProvider>(
        builder: (context, currentProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  controller: _scrollController,
                  itemCount: currentProvider.posts.length,
                  // itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                  itemBuilder: (context, index) {
                    // if(index < posts.length) {
                    final post = currentProvider.posts[index];
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

              if(currentProvider.isLoadingMore) ...[
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 40),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],

              if(currentProvider.hasNextPage == false) ...[
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  color: Colors.amber,
                  child: const Center(
                    child: Text('You have fetched all of the content'),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }

  Future <void> _scrollListener() async {
    final paginationProvider = Provider.of<PaginationProvider>(context, listen: false);

    if(paginationProvider.isLoadingMore) return;

    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {

      paginationProvider.toggleIsLoadingMore(true);
      paginationProvider.incrementPages(1);

      debugPrint('Latest Page = ${paginationProvider.page}');

      await paginationProvider.fetchPosts();

      paginationProvider.toggleIsLoadingMore(false);
    }
    else {
      debugPrint("don't call");
    }
    // debugPrint("Scroll Listener called");
  }
}
