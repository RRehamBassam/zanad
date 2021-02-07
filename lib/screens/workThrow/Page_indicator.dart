import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  PageIndicator(this.currentIndex, this.pageCount);

  _indicator(bool isActive) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: isActive?
            Container(

              width: 25,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(width: 4,color: Colors.white),
                color: Color(0xFF007A43)
              ),

            ):Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color:Colors.white
          ),
        ),
      );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < pageCount; i++) {
      indicatorList
          .add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _buildPageIndicators(),
    );
  }
}