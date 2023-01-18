import 'dart:math';

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
                width: 400,
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
            height: 10,
          ),
          Container(
            color: const Color.fromARGB(255, 232, 229, 229),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrlString("https://github.com/Hiroki1111/janken");
                      },
                      child: const Text(
                        "じゃんけん",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 600,
                      width: 320,
                      child: JankenPage(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        launchUrlString(
                            "https://github.com/Hiroki1111/attimuitehoi");
                      },
                      child: const Text(
                        "あっち向いてホイ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 600,
                      width: 320,
                      child: AttimuitehoiPage(),
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

// じゃんけん
class JankenPage extends StatefulWidget {
  const JankenPage({super.key});

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {
  // 変数はここに書く
  String myHand = "👊";
  String completerHand = "👊";
  String result = "引き分け";
  String judgePrint = "";
  int judgeCount = 0;
  int winCount = 0;
  int loseCount = 0;
  int drawCount = 0;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateCompleterHand();
    judge();
    judgeCounter();
    winCounter();
    loseCounter();
    drawCounter();
    judgePrinter();
    setState(() {});
  }

  void generateCompleterHand() {
    final randomNumber = Random().nextInt(3);
    completerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return "👊";
      case 1:
        return "✌︎";
      case 2:
        return "🖐";
      default:
        return "👊";
    }
  }

  void judge() {
    // 引き分けの場合
    if (myHand == completerHand) {
      result = "引き分け";
    } else if (myHand == "👊" && completerHand == "✌️" ||
        myHand == "✌️" && completerHand == "🖐" ||
        myHand == "🖐" && completerHand == "👊") {
      result = "勝ち";
    } else {
      result = "負け";
    }
  }

  void judgeCounter() {
    judgePrint = "";
    judgeCount++;
    if (judgeCount == 5) {
      judgePrinter();
      myHand = "👊";
      completerHand = "👊";
      result = "引き分け";
      judgeCount = 0;
      winCount = 0;
      loseCount = 0;
      drawCount = 0;
    }
  }

  void winCounter() {
    if (result == "勝ち") {
      winCount++;
    }
  }

  void loseCounter() {
    if (result == "負け") {
      loseCount++;
    }
  }

  void drawCounter() {
    if (result == "引き分け") {
      drawCount++;
    }
  }

  void judgePrinter() {
    if (judgeCount == 4) {
      judgePrint = "5戦$winCount勝$loseCount敗$drawCount分";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("じゃんけん"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              judgePrint,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              result,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              completerHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 48),
            Text(
              myHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand("👊");
                  },
                  child: const Text("👊"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("✌️");
                  },
                  child: const Text("✌️"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("🖐");
                  },
                  child: const Text("🖐"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// あっち向いてホイ
class AttimuitehoiPage extends StatefulWidget {
  const AttimuitehoiPage({super.key});

  @override
  State<AttimuitehoiPage> createState() => _AttimuitehoiPageState();
}

class _AttimuitehoiPageState extends State<AttimuitehoiPage> {
  String myHand = "↑";
  String completerHand = "↑";
  String result = "";
  String kaihiPrint = "スタート";
  int kaihiCount = 0;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateCompleteHand();
    judge();
    kaihiCounter();
    kaihiPrinter();
    setState(() {});
  }

  void generateCompleteHand() {
    final randomNumber = Random().nextInt(4);
    completerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '↑';
      case 1:
        return '↓';
      case 2:
        return '→';
      case 3:
        return '←';
      default:
        return '↑';
    }
  }

  void judge() {
    if (myHand == completerHand) {
      result = "回避失敗";
    } else {
      result = "回避成功";
    }
  }

  void kaihiCounter() {
    kaihiCount++;
    if (result == "回避失敗") {
      kaihiPrint = "スタート";
      kaihiCount = 0;
    }
  }

  void kaihiPrinter() {
    kaihiPrint = "回避成功回数$kaihiCount回";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("あっち向いてホイ"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              kaihiPrint,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            Text(
              completerHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            Text(
              myHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand("↑");
                  },
                  child: const Text("↑"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("↓");
                  },
                  child: const Text("↓"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("→");
                  },
                  child: const Text("→"),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand("←");
                  },
                  child: const Text("←"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
