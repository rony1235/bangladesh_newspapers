import 'package:bangladesh_newspapers/screens/webTest.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';

class BoxNewsPaper extends StatefulWidget {
  final NewspaperList newspaper;
  final double fontSize;
  final double boderWidth;
  final double heartFontSize;
  final Function onPress;
  final Color iconColor;

  BoxNewsPaper(
      @required this.fontSize,
      @required this.newspaper,
      @required this.boderWidth,
      this.heartFontSize,
      this.onPress,
      this.iconColor);

  @override
  _BoxNewsPaperState createState() => _BoxNewsPaperState();
}

class _BoxNewsPaperState extends State<BoxNewsPaper>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 2.0,
        color: kPrimaryCardColor,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
                        color: kPrimaryColor, width: widget.boderWidth))),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: 'imageHero${widget.newspaper.url}',
                      child: Image.asset(
                        "images/${widget.newspaper.icon}",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          widget.newspaper.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: widget.fontSize,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.solidHeart,
                                  size: widget.heartFontSize,
                                  color: widget.iconColor),
                              onPressed: widget.onPress,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        //showAds();
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return MyWebTestView(widget.newspaper);
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
