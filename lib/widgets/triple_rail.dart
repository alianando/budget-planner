import 'package:flutter/material.dart';

class TripleRail extends StatelessWidget {
  const TripleRail({
    super.key,
    this.leading,
    this.middle,
    this.trailing,
  });

  final Widget? leading;
  final Widget? middle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1,
            child: leading,
          ),
        ),
        if (middle != null) middle!,
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            heightFactor: 1,
            child: trailing,
          ),
        ),
      ],
    );
  }
}
