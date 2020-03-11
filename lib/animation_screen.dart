import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_izmir/controller.dart';
import 'package:flutter/rendering.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  AnimationHouseController _animationController;

  @override
  void initState() {
    _animationController = AnimationHouseController(animationUpdated: _update);
    super.initState();
  }
  _update() => setState((){});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Color(0XFF1b262c),
      child: Listener(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FlareActor(
            "assets/izmir.flr",
            controller: _animationController,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),

          Container(margin: EdgeInsets.only(left:40, right:40),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: <Widget>[
              Text("Flutter İzmir", style: TextStyle(color: Colors.white, fontSize:18),),
              Slider(
                min: 0,
                max: 3,
                divisions: 3,
                value: _animationController.rooms.toDouble() -3, onChanged: (double value){
                setState(() {
                  _animationController.rooms = value.toInt() + 3;
                });
              })
            ],
          ),)
        ],
      )),
    ));
  }
}
