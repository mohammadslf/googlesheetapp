import 'package:flutter/material.dart';

class NavigateUsersWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedPrevious;
  final VoidCallback onCLickedNext;
  const NavigateUsersWidget(
      {Key? key,
      required this.text,
      required this.onClickedPrevious,
      required this.onCLickedNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 48,
          onPressed: onClickedPrevious,
          icon: Icon(Icons.navigate_before),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(
          iconSize: 48,
          onPressed: onCLickedNext,
          icon: Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}
