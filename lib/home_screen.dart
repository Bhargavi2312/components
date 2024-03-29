import 'package:flutter/material.dart';
import 'package:single_page_demo/widgets/bottom_bar.dart';
import 'package:single_page_demo/widgets/feature_heading.dart';
import 'package:single_page_demo/widgets/features_tile.dart';
import 'package:single_page_demo/widgets/floating_quick_access_bar.dart';
import 'package:single_page_demo/widgets/top_bar_contents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MediaQuery.of(context).size.width > 600
          ? PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1000),
              child: const TopBarContents(0),
            )
          : AppBar(
              backgroundColor: Colors.blueGrey.shade900.withOpacity(0),
              elevation: 0,
              title: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey.shade100,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenSize.height * 0.45,
                  width: screenSize.width,
                  child: Image.asset(
                    'lib/assets/cover.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    FloatingQuickAccessBar(screenSize: screenSize),
                    Column(
                      children: [
                        FeaturedHeading(
                          screenSize: screenSize,
                        ),
                        FeaturedTiles(screenSize: screenSize)
                      ],
                    ),
                  ],
                )
              ],
            ),
            // DestinationHeading(screenSize: screenSize),
            // DestinationCarousel(),
            SizedBox(height: screenSize.height / 10),
            const BottomBar(),
          ],
        ),
      ),
    );
  }
}
