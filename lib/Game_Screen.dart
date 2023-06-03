import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rock_papar_scissors_task/Final_Screen.dart';
import 'constants.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<GameObject> objects = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    createObject();
    startGame();
  }

  @override
  void dispose() {
    super.dispose();
  }
  void createObject() {
    objects.clear();
    createObjects(objects: objects, random: random, mytype: ObjectType.Rock);
    createObjects(objects: objects, random: random, mytype: ObjectType.Paper);
    createObjects(objects: objects, random: random, mytype: ObjectType.Scissors);

  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        updateDirection();
        checkCollisions();
        if(finalCheck()){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=> FinalScreen(winner: objects.first.type.toString(),)));
          timer.cancel();
        };
      });
    });
  }

  void updateDirection() {
    for (var object in objects) {
      object.x += object.dx;
      object.y += object.dy;

      if (object.x < 0 || object.x > MediaQuery.of(context).size.width - Object_width) {
        object.dx *= -1;
      }

      if (object.y < 0 || object.y > MediaQuery.of(context).size.height - Object_height - MediaQuery.of(context).padding.top - kToolbarHeight) {
        object.dy *= -1;
      }
    }
  }

  void checkCollisions() {
    for (int i = 0; i < objects.length; i++) {
      for (int j = i + 1; j < objects.length; j++) {
        if (objects[i].x < objects[j].x + Object_width/2+15 &&
            objects[i].x + Object_width/2+15 > objects[j].x &&
            objects[i].y < objects[j].y + Object_height/2+15 &&
            objects[i].y + Object_height/2+15 > objects[j].y) {
          handleCollision(objects[i], objects[j]);
        }
      }
    }
  }

  void handleCollision(GameObject obj1, GameObject obj2) {
    if (obj1.type == obj2.type) {
      obj1.dx *= -1;
      obj1.dy *= -1;

      obj2.dx *= -1;
      obj2.dy *= -1;
    } else {
      if ((obj1.type == ObjectType.Rock && obj2.type == ObjectType.Scissors) ||
          (obj1.type == ObjectType.Scissors && obj2.type == ObjectType.Paper) ||
          (obj1.type == ObjectType.Paper && obj2.type == ObjectType.Rock)) {
        objects.remove(obj2);
        obj1.dx *= -1;
        obj1.dy *= -1;
      } else {
        objects.remove(obj1);
        obj2.dx *= -1;
        obj2.dy *= -1;
      }
    }
  }

  bool finalCheck(){
    int num=0;
    for (int i = 0; i < objects.length; i++)
      for (int j = i + 1; j < objects.length; j++)
          if(objects[i].type != objects[j].type)
            num++;

      if(num == 0 )
        return true ;
    else
      return false ;
}


  Widget getGameObjectWidget(GameObject object) {
    Color color;
    String text;
    IconData iconData;

    switch (object.type) {
      case ObjectType.Rock:
        color = Colors.grey;
        text = 'Rock';
        iconData = Icons.handshake;
        break;
      case ObjectType.Paper:
        color = Colors.blue;
        text = 'Paper';
        iconData = Icons.back_hand_rounded;
        break;
      case ObjectType.Scissors:
        color = Colors.orange;
        text = 'Scissors';
        iconData = Icons.content_cut;
        break;
    }

    return Positioned(
      left: object.x,
      top: object.y,
      child: Container(
        width: Object_width,
        height: Object_height,
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            Text(text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rock Paper Scissors'),
            ElevatedButton(onPressed: createObject, child: Text("restart"))
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            for (var object in objects) getGameObjectWidget(object),
          ],
        ),
      ),

    );
  }
}