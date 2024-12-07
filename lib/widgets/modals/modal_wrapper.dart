import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';

class ModalWrapper extends StatelessWidget {
  final Widget child;

  const ModalWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 60.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }
}
