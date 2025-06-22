import 'package:flutter/material.dart';
import 'package:headway/constants/theme_colors.dart';
import 'package:headway/screens/audio_book_page.dart';
import 'dart:math' as math;
import 'package:headway/screens/player_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          'Headway',
          style: kTextTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ListTile(
                tileColor: Colors.amber[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                leading: Icon(
                  Icons.double_arrow_sharp,
                  color: Colors.amber,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Free daily \nsummary',
                            style: kTextTheme.displayMedium,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioBookPage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Get it now',
                                    style: kTextTheme.bodySmall,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: kDefaultIconLightColor,
                                  )
                                ],
                              ))
                        ],
                      ),
                      Transform.rotate(
                        angle: math.pi / 12.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image(
                            height: 150.0,
                            image: const AssetImage(
                                'assets/images/placeholder.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Text(
              'You might also like',
              style: kTextTheme.displayMedium,
            ),
            Text(
              'Summaries based on your ratings',
              style: kTextTheme.displaySmall,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 30.0),
            //   child: ListTile(
            //     tileColor: Colors.amber[800],
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0)),
            //     leading: Icon(
            //       Icons.double_arrow_sharp,
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 30.0),
            //   child: ListTile(
            //     tileColor: Colors.amber[800],
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0)),
            //     leading: Icon(
            //       Icons.double_arrow_sharp,
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 30.0),
            //   child: ListTile(
            //     tileColor: Colors.amber[800],
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0)),
            //     leading: Icon(
            //       Icons.double_arrow_sharp,
            //       color: Colors.amber,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: kBackgroundColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme.of(context).textTheme,
        ),
        child: BottomNavigationBar(
          backgroundColor: kBackgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'For you',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Activity',
            ),
          ],
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}
