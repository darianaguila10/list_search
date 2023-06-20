import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  
  final Widget text;

  const EmptyListWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 160,
          width: 160,
          alignment: Alignment.center,
          child: Icon(
            Icons.search_off_rounded,
            size: 60,
            color: Color(0xFF5F6670),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF2F3F5),
          ),
        ),
        Divider(
          color: Colors.transparent,
        ),
        text,
      ],
    );
  }
}
