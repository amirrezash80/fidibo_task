import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:rock_papar_scissors_task/Game_Screen.dart';
import 'constants.dart';
class FinalScreen extends StatelessWidget {
  final String winner;

  const FinalScreen({Key? key, required this.winner}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: AnimatedTextKit(
                animatedTexts: [
                ColorizeAnimatedText(
                "we have a ",
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
                ColorizeAnimatedText(
                "winner",
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
                ColorizeAnimatedText(
                "and winner is",
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
                ColorizeAnimatedText(
                winner.toString().split('.').last,
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
          ],
          pause: const Duration(milliseconds: 100),
              ),
    ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> GameScreen()));
                } ,
                child: Text("Play Again"),
            )
          ],
        ),
      ) ,
    );
  }
}
