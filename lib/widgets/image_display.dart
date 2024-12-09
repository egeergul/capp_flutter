import 'dart:typed_data';
import 'package:capp_flutter/widgets/custom_icon_button.dart';
import 'package:capp_flutter/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:get/route_manager.dart';

class ImageDisplay extends StatelessWidget {
  final Uint8List? base64String;
  const ImageDisplay({
    super.key,
    this.base64String,
  });

  Widget _getImage() {
    if (base64String != null) {
      return Image.memory(base64String!);
    }
    return const EmptyWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            _getImage(),
            Positioned(
              top: 10.h,
              left: 10.w,
              child: CustomIconButton(
                onTap: Get.back,
                iconData: Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
