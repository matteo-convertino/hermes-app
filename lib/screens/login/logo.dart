

import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height / 2),
      child: Image.asset(
        "./assets/images/${Theme.of(context).brightness == Brightness.light ? "logo_light" : "logo_dark"}.png",
        height: 150,
      ),
    );
  }

}