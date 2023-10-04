import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/pallets.dart';
import '../navigation/route_url.dart';
import '_shared.dart';

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: 'Back to Home',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Pallets.primary,
      decoration: TextDecoration.underline,
      onTap: () {
        context.goNamed(PageUrl.home);
      },
    );
  }
}
