import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headway/constants/theme_colors.dart';
import 'package:headway/screens/player_page.dart';
import 'package:headway/models/book.dart';
import 'package:http/http.dart' as http;

class AudioBookPage extends StatefulWidget {
  const AudioBookPage({super.key});

  @override
  State<AudioBookPage> createState() => _AudioBookPageState();
}

class _AudioBookPageState extends State<AudioBookPage> {
  Book? _book;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  String _baseUrl = 'https://musical-happiness.onrender.com';

  Future<Book?> fetchBook({http.Client? client}) async {
    client ??= http.Client();
    final response = await client.get(Uri.parse('$_baseUrl/book'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _loading = false;
        _book = Book.fromJson(data);
      });
      return Book.fromJson(data);
    } else {
      setState(() {
        _loading = false;
      });
      throw Exception('Failed to load book');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: size.height * 0.5,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset(
                                'assets/images/placeholder.jpg',
                                height: size.height * 0.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 25),
                            Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.share,
                                          color: Colors.white),
                                      onPressed: () {
                                        // TODO: Implement share functionality
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.download,
                                          color: Colors.white),
                                      onPressed: () {
                                        // TODO: Implement download functionality
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.bookmark_border,
                                          color: Colors.white),
                                      onPressed: () {
                                        // TODO: Implement save functionality
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text('Summary',
                                style: kTextTheme.headlineMedium
                                    ?.copyWith(color: kFadedWhiteColor)),
                            Text(_book?.title ?? '',
                                style: kTextTheme.headlineLarge),
                            Text(_book?.writer ?? '',
                                style: kTextTheme.headlineMedium
                                    ?.copyWith(color: kFadedWhiteColor)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(Icons.access_time,
                                color: kFadedWhiteColor, size: 18),
                            SizedBox(width: 4),
                            Text('15 min', style: kTextTheme.headlineSmall),
                            Spacer(),
                            Icon(Icons.headset,
                                color: kFadedWhiteColor, size: 18),
                            SizedBox(width: 4),
                            Text('Audio', style: kTextTheme.headlineSmall),
                            Spacer(),
                            Icon(Icons.star_border,
                                color: kFadedWhiteColor, size: 18),
                            SizedBox(width: 4),
                            Text('4.8', style: kTextTheme.headlineSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.white,
                          elevation: 2,
                        ),
                        onPressed: () {
                          debugPrint('Close button tapped');
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kInactiveDotColor,
                                  foregroundColor: kWhiteColor,
                                  textStyle: const TextStyle(fontSize: 18),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  // TODO: Implement Read functionality
                                },
                                icon: Icon(Icons.format_align_left_rounded),
                                label: const Text(
                                  'Read',
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SizedBox(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor,
                                    foregroundColor: kWhiteColor,
                                    textStyle: const TextStyle(fontSize: 18),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => PlayerPage()),
                                    );
                                  },
                                  icon: const Icon(Icons.headphones),
                                  label: const Text('Listen'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
