import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(HiraganaApp());
}

class HiraganaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Hiragana Flashcards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 11, 88), 
          brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: HiraganaHomePage(),
    );
  } 
}

class HiraganaHomePage extends StatefulWidget {
  @override
  _HiraganaHomePageState createState() => _HiraganaHomePageState();
}

class _HiraganaHomePageState extends State<HiraganaHomePage> {
  final List<String> hiraganaCharacters = [
    "あ", "い", "う", "え", "お",
    "か", "き", "く", "け", "こ",
    "さ", "し", "す", "せ", "そ",
    "た", "ち", "つ", "て", "と",
    "な", "に", "ぬ", "ね", "の",
    "は", "ひ", "ふ", "へ", "ほ",
    "ま", "み", "む", "め", "も",
    "や", "ゆ", "よ",
    "ら", "り", "る", "れ", "ろ",
    "わ", "を", "ん",
    "が", "ぎ", "ぐ", "げ", "ご",
    "ざ", "じ", "ず", "ぜ", "ぞ",
    "だ", "ぢ", "づ", "で", "ど",
    "ば", "び", "ぶ", "べ", "ぼ",
    "ぱ", "ぴ", "ぷ", "ぺ", "ぽ"

  ];

  final Map<String, String> hiraganaToRomaji = {
    "あ": "a", "い": "i", "う": "u", "え": "e", "お": "o",
    "か": "ka", "き": "ki", "く": "ku", "け": "ke", "こ": "ko",
    "さ": "sa", "し": "shi", "す": "su", "せ": "se", "そ": "so",
    "た": "ta", "ち": "chi", "つ": "tsu", "て": "te", "と": "to",
    "な": "na", "に": "ni", "ぬ": "nu", "ね": "ne", "の": "no",
    "は": "ha", "ひ": "hi", "ふ": "fu", "へ": "he", "ほ": "ho",
    "ま": "ma", "み": "mi", "む": "mu", "め": "me", "も": "mo",
    "や": "ya", "ゆ": "yu", "よ": "yo",
    "ら": "ra", "り": "ri", "る": "ru", "れ": "re", "ろ": "ro",
    "わ": "wa", "を": "wo", "ん": "n",
    "が": "ga", "ぎ": "gi", "ぐ": "gu", "げ": "ge", "ご": "go",
    "ざ": "za", "じ": "ji", "ず": "zu", "ぜ": "ze", "ぞ": "zo",
    "だ": "da", "ぢ": "ji", "づ": "zu", "で": "de", "ど": "do",
    "ば": "ba", "び": "bi", "ぶ": "bu", "べ": "be", "ぼ": "bo",
    "ぱ": "pa", "ぴ": "pi", "ぷ": "pu", "ぺ": "pe", "ぽ": "po"

  };

  String currentCharacter = "";
  String currentRomaji = "";
  double romajiOpacity = 0.0;//for romaji dislay animation

  void getRandomCharacter() {
    final randomIndex = Random().nextInt(hiraganaCharacters.length);
    setState(() {
      currentCharacter = hiraganaCharacters[randomIndex];
      currentRomaji = ""; // Reset Romaji when a new character is generated
    });
  }

  void showRomaji() {
  setState(() {
    currentRomaji = hiraganaToRomaji[currentCharacter] ?? "";
    romajiOpacity = 0.0; // Start from invisible
  });

  // Trigger fade-in after a short delay (to allow rebuild)
  Future.delayed(Duration(milliseconds: 50), () {
    setState(() {
      romajiOpacity = 0.5;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Material(
            elevation: 6,
            shadowColor: const Color.fromARGB(255, 0, 77, 74).withAlpha(255),
            color: Color.fromARGB(255, 0, 71, 69), // or any color you like
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'HIRAGANA FLASHCARDS',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold, 
                  letterSpacing: 1.2,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: romajiOpacity,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Text(
                currentRomaji.isEmpty ? "" : "Romaji: $currentRomaji",
                style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: currentCharacter.isEmpty
                  ? SizedBox(
                      key: ValueKey("empty"),
                      height: 200,
                      child: Text(
                        "Press the button!",
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Card(
                      key: ValueKey(currentCharacter),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color.fromARGB(255, 255, 244, 183),
                      child: Container(
                        width: 200,
                        height: 200,
                        alignment: Alignment.center,
                        child: Text(
                          currentCharacter,
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade800,
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: getRandomCharacter,
                  icon: Icon(Icons.refresh_outlined),
                  label: Text("New Character"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 158, 48, 38), // Traditional Japanese red
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: StadiumBorder(), // pill-shapeda
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    elevation: 4,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: currentCharacter.isEmpty ? null : showRomaji,
                  icon: Icon(Icons.visibility),
                  label: Text("Show Romaji"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 49, 97),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: StadiumBorder(),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    elevation: 4,
                  ),
                ),
              ],
            ), 
          ],
        ),
      ),
    );
  }
}