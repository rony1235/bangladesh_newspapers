import 'package:bangladesh_newspapers/screens/webTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/models/DataCategoryModel.dart';
import 'package:flutter_svg/svg.dart';

class BoxNewsPaper extends StatefulWidget {
  final NewspaperList newspaper;
  final double fontSize;
  final double boderWidth;
  final double heartFontSize;
  final Function onPress;
  final Color iconColor;
  final IconData heartIcon;

  final String page;

  BoxNewsPaper(
      this.fontSize,
      this.newspaper,
      this.boderWidth,
      this.heartFontSize,
      this.onPress,
      this.iconColor,
      this.heartIcon,
      this.page);

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
        elevation: 2,
        color: Colors.white, //kPrimaryCardColor,
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: Container(
            //decoration: BoxDecoration(
            // border: Border(
            //     right: BorderSide(
            //         color: kPrimaryColor, width: widget.boderWidth))),
            //alignment: Alignment.center,
            child: Stack(
                alignment: Alignment.topRight,
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 15,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Hero(
                              tag:
                                  '${widget.page}imageHero${widget.newspaper.url}',
                              child: widget.newspaper.icon.contains("svg")
                                  ? SvgPicture.asset(
                                      "images/${widget.newspaper.icon}",
                                    )
                                  : Image.asset(
                                      "images/${widget.newspaper.icon}",
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: Column(
                          children: [
                            Text(
                              widget.newspaper.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      //padding: EdgeInsets.all(0),

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(23, 23, 8, 8.0),
                        child: Icon(widget.heartIcon,
                            size: widget.heartFontSize,
                            color: widget.iconColor),
                      ),
                      onTap: widget.onPress,
                      //onPressed: ,
                    ),
                  )
                ]),
          ),
        ),
      ),
      onTap: () {
        //showAds();
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           MyWebTestView(widget.newspaper, widget.page)),
        // );

        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1700),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return MyWebTestView(widget.newspaper, widget.page);
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
