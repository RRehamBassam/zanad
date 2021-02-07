import 'package:flutter/material.dart';
import '../themes/colors.dart';
class backgroundLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return      Container(
              height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                  color: themeColors.dark_green,
                  ),
                  child: Align(
                     alignment: Alignment.topCenter,
                    child: Image.asset('assets/logo_pages.png',height: 160,)),
          );
  }
}
