import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
          Row(
            children: [
              const Text('写真'),
              Column(
                children: const [
                  Text('○○○○'),
                  Text('○○○○'),
                  Text('○○○○'),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Creates
      Column(
        children: [
          const Text(
            'Creates',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              Text('スクリーンショット'),
              Text('スクリーンショット'),
              SizedBox(
                height: 1600,
              ),
            ],
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
                      'Create',
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
