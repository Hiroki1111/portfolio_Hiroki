import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ヘッダー
            Column(
              children: [
                Row(
                  children: const [
                    Text('ロゴ'),
                    Text('アイコン'),
                    Text('アイコン'),
                  ],
                ),
                Row(
                  children: const [
                    Text('About'),
                    Text('Creates'),
                  ],
                ),
              ],
            ),

            // About
            Column(
              children: [
                const Text('About'),
                Row(
                  children: [
                    const Text('写真'),
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
                const Text('Creates'),
                Row(
                  children: const [
                    Text('スクリーンショット'),
                    Text('スクリーンショット'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
