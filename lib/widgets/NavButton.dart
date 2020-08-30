import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';

class NavButton extends StatelessWidget {
  NavButton(@required this._page, @required this._icons,
      @required this.owoNumber, @required this.text);

  final int _page;
  final IconData _icons;
  final int owoNumber;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(_icons,
          size: 30,
          color: _page == owoNumber ? kPrimaryTextColor : Colors.black87),
    );
  }
}
