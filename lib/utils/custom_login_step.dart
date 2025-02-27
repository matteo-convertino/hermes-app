import 'package:flutter/cupertino.dart';

AnimatedPositioned customLoginStep({
  required BuildContext context,
  required int loginStep,
  required int activeStep,
  required Widget inputForm,
}) {
  return AnimatedPositioned(
    duration: const Duration(milliseconds: 250),
    left: (loginStep - activeStep) * MediaQuery.sizeOf(context).width,
    width: MediaQuery.sizeOf(context).width,
    child: inputForm,
  );
}
