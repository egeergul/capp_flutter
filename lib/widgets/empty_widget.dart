import 'package:capp_flutter/helpers/logger_helper.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? debugSentence;
  const EmptyWidget({
    super.key,
    this.debugSentence,
  });

  @override
  Widget build(BuildContext context) {
    if (debugSentence != null) {
      LoggerHelper.logInfo("EmptyWidget.build", debugSentence!);
    }
    return const SizedBox.shrink();
  }
}
