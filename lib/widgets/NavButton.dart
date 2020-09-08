import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';

class NavButton extends StatelessWidget {
  NavButton(this._page, this._icons, this.owoNumber, this.text);

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
