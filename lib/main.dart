import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hiroki's Portfolio",
      theme: ThemeData(
        // primarySwatch: Colors.white,
        textTheme: GoogleFonts.sawarabiMinchoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: PortfolioPage(),
      // home: index(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  PortfolioPage({super.key});

  final _controller = AutoScrollController();
  @override
  Widget build(BuildContext context) {
    final items = [
      // About
      Column(
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Container(
                width: 60,
              ),
              Image.asset(
                'assets/images/profile_image.png',
                width: 500,
              ),
              Column(
                children: const [
                  Text('○○○○'),
                  Text('○○○○'),
                  Text('○○○○'),
                ],
              ),
            ],
          ),
        ],
      ),

      // Creates
      Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Creates',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            color: const Color.fromARGB(255, 232, 229, 229),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      "じゃんけん",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          await launchUrlString(
                              "https://github.com/Hiroki1111/janken");
                        },
                        child: Image.asset(
                          'assets/images/janken_image.png',
                          // width: 600,
                          height: 600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "あっち向いてホイ",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () async {
                          await launchUrlString(
                              "https://github.com/Hiroki1111/attimuitehoi");
                        },
                        child: Image.asset(
                          'assets/images/attimuitehoi_image.png',
                          width: 600,
                          height: 600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ];
    return Scaffold(
      body: Column(
        children: [
          // ヘッダー
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  Image.asset(
                    'assets/images/logo_image.png',
                    width: 250,
                  ),
                ],
              ),
              Row(
                children: [
                  // InkWell:テキストをボタンにできる
                  InkWell(
                    onTap: () {
                      _controller.scrollToIndex(
                        0,
                        // ボタンを押したら上にスクロール
                        preferPosition: AutoScrollPosition.begin,
                      );
                    },
                    child: const Text(
                      'About',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () {
                      _controller.scrollToIndex(
                        1,
                        preferPosition: AutoScrollPosition.begin,
                      );
                    },
                    child: const Text(
                      'Creates',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                    key: ValueKey(index),
                    controller: _controller,
                    index: index,
                    child: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
