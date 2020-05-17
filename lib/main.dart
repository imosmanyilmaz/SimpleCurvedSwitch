import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Switch"),
      ),
      body: Container(
        child: Center(
          child: SimpleSwitch(),
        ),
      ),
    );
  }
}

class SimpleSwitch extends StatefulWidget {
  @override
  _SimpleSwitch createState() => _SimpleSwitch();
}

class _SimpleSwitch extends State<SimpleSwitch>
    with SingleTickerProviderStateMixin {
  bool isChecked = false;
  Animation<Alignment> _typeOfAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this, //comes from SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 50), //you can change animation speed
    );

    _typeOfAnimation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.linear,
          reverseCurve: Curves.linear), //you can change animated type like Curves.bounceInOut
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 400,
          height: 50,
          padding: EdgeInsets.fromLTRB(6, 6, 6, 6),
          decoration: BoxDecoration(
            color: isChecked ? Colors.grey : Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(48),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _typeOfAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                      isChecked = !isChecked;
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(48),
                      ),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
