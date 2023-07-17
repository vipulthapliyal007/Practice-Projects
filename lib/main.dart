import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuhee/Examples/In%20App%20Review/in_ap_review.dart';
import 'package:yuhee/Examples/Shimmer/shimmer_effects.dart';
import 'package:yuhee/Examples/pagination/pagination_example.dart';
import 'package:yuhee/Examples/pagination/pagination_example_three.dart';
import 'package:yuhee/Examples/pagination/pagination_example_two.dart';
import 'package:yuhee/Examples/pagination/provider%20pagination/provider_pagination.dart';
import 'package:yuhee/Examples/pagination/provider%20pagination/provider_pagination_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PaginationProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        // BottomNavBar(), // Simple Bottom Navigation Bar inside Folder [BottomNavigationBar]
        // ListPerformance(), // Checking List Performance
        // UsingStack(), // Checking Stack Widget
        // WritingDescription(), // Enabling description writing feature
        // MapExample(), // Learning map method to use in widget tree
        // UploadPdf(), // Learing how to upload pdf
        // MyPDFList(), // Learing how to upload pdf
        // ShowAnyFile(), // Show any file
        // CustomDropDownWidget(), // Show custom drop down
        // const OpenLinkOnWebBrowser(), // Show link on browser
        // const PullRefreshPage(), /// Pull down to refresh page
        // const PaginationExampleScreen(), /// Pagination
        // const PaginationExampleTwo(), /// Pagination
        // const ProviderPaginationScreen(), /// Pagination With Provider
        const PaginationExampleThree(), /// Pagination With Provider
        // const InAppReviewExampleApp(), /// In App Review Screen
        // const ShimmerEffects(), /// Shimmer Effect Screen
      ),
    );
  }
}