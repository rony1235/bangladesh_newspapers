import 'package:bangladesh_newspapers/screens/webInappwebview.dart';
import 'package:bangladesh_newspapers/screens/webTest.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
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
  final double textImageBetweenPadding;
  final double textImagePadding;

  final String page;

  BoxNewsPaper(
      this.fontSize,
      this.newspaper,
      this.boderWidth,
      this.heartFontSize,
      this.onPress,
      this.iconColor,
      this.heartIcon,
      this.page,
      this.textImageBetweenPadding,
      this.textImagePadding);

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
        elevation: 0,
        //color: Color(0xFFF1F2F3),
        // shape: Border(
        //   right: BorderSide(color: Color(0xFFF1F2F3), width: 1),
        //   left: BorderSide(color: Color(0xFFF1F2F3), width: 1),
        //   top: BorderSide(color: Color(0xFFF1F2F3), width: 1),
        //   bottom: BorderSide(color: Color(0xFFF1F2F3), width: 1),
        // ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
                color: Color(0xFFF1F2F3), width: 2)), //kPrimaryCardColor,
        child: Container(
          //decoration: BoxDecoration(
          // border: Border(
          //     right: BorderSide(
          //         color: kPrimaryColor, width: widget.boderWidth))),
          //alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(widget.textImagePadding),
            child: Stack(
                alignment: Alignment.topRight,
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
                        child: Container(
                          child: Hero(
                            tag:
                                '${widget.page}imageHero${widget.newspaper.url}',
                            child: widget.newspaper.icon.contains("svg")
                                ? SvgPicture.asset(
                                    kMainImageLocation + widget.newspaper.icon,
                                    height: 55,
                                  )
                                : widget.newspaper.colorFiltered
                                    ? ColorFiltered(
                                        child: Image.asset(
                                          kMainImageLocation +
                                              widget.newspaper.icon,
                                          height: 55,
                                        ),
                                        colorFilter: ColorFilter.mode(
                                            Colors.greenAccent,
                                            BlendMode.srcIn),
                                      )
                                    : Image.asset(
                                        kMainImageLocation +
                                            widget.newspaper.icon,
                                        height: 55,
                                      ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, widget.textImageBetweenPadding, 0, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.0),
                              ), //
                              color: kPrimaryColor,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                                  child: Text(
                                    widget.newspaper.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: widget.fontSize,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      //padding: EdgeInsets.all(0),

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(23, 8, 8, 8.0),
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
            transitionDuration: Duration(milliseconds: 1400),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return webInappwebview(widget.newspaper, widget.page);
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
