import 'dart:ui';

import 'package:flutter/material.dart';

class WithBlur extends StatelessWidget {
  const WithBlur({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        )
      ],
    );
  }
}
