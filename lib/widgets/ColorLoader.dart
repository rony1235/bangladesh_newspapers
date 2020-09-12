import 'package:bangladesh_newspapers/utilities/constant.dart';
import "package:flutter/material.dart";
import 'dart:math';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorLoader extends StatefulWidget {
  final double radius;
  final double dotRadius;

  ColorLoader({this.radius = 70.0, this.dotRadius = 3.0});

  @override
  _ColorLoaderState createState() => _ColorLoaderState();
}

class _ColorLoaderState extends State<ColorLoader>
    with SingleTickerProviderStateMixin {
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;
  Animation<double> animation_color;
  AnimationController controller;

  double radius;
  double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    //print(dotRadius);

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 1500),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );
    animation_color = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.25).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, .25, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0, 1.0, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        //if (controller.value >= 0.25 && controller.value <= 1.0)
        radius = widget.radius * animation_radius_in.value;
        //else if (controller.value >= 0.0 && controller.value <= 0.25)
        radius = widget.radius * animation_radius_out.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          //color: Colors.black12,
          child: Center(
            child: RotationTransition(
              turns: animation_rotation,
              child: Container(
                //color: Colors.limeAccent,
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: Icon(
                              FontAwesomeIcons.solidNewspaper,
                              color: kPrimaryColor
                                  .withOpacity(animation_color.value),
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0),
                          radius * sin(0.0),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 1 * pi / 4),
                          radius * sin(0.0 + 1 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 2 * pi / 4),
                          radius * sin(0.0 + 2 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 3 * pi / 4),
                          radius * sin(0.0 + 3 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 4 * pi / 4),
                          radius * sin(0.0 + 4 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 5 * pi / 4),
                          radius * sin(0.0 + 5 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 6 * pi / 4),
                          radius * sin(0.0 + 6 * pi / 4),
                        ),
                      ),
                      Transform.translate(
                        child: Dot(
                          radius: dotRadius,
                          color: Colors.white,
                        ),
                        offset: Offset(
                          radius * cos(0.0 + 7 * pi / 4),
                          radius * sin(0.0 + 7 * pi / 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 50),
        Text(
          "All Bangla Newspapers",
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              color: Colors.white.withOpacity(animation_color.value)),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
