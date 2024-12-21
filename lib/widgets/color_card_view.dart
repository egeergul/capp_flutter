import 'package:capp_flutter/helpers/color_helper.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:capp_flutter/utils/copy_clipboard.dart';
import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

// TODO: yatay ekranda da güzel dursun
class ColorCardDetailedView extends StatelessWidget {
  final Map map;
  const ColorCardDetailedView({
    super.key,
    required this.map,
  });

  // str is the full string to show
  // strToCopy is the part to be copied
  // if strToCopy is null, entire str is copied
  Widget copiableStr(
    String str, {
    String? strToCopy,
    TextStyle? style,
    double? width,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => copyClipboard(strToCopy ?? str),
          child: Icon(Icons.copy, size: 16.w),
        ),
        SizedBox(width: 5.w),
        SizedBox(
          width: width != null ? width - 21.w : null,
          child: Text(
            str,
            style: style,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String? name = map["name"];
    String? hexStr = map["hex"];
    if (hexStr == null) return const EmptyWidget();

    Color color = ColorHelper.parseColorFromHexString(hexStr);
    String rgbStr = ColorHelper.getRGBString(color);
    String cmykStr = ColorHelper.getCMYKString(color);
    ThemeData themeData = Theme.of(context);

    double w = 225.w;
    double h = 175.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            color: color,
            constraints: BoxConstraints(maxHeight: h),
            width: w,
          ),
        ),
        Container(
          width: w,
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 1.h),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name != null) ...[
                Text(name, style: themeData.textTheme.headlineSmall),
              ],
              copiableStr(
                hexStr,
                style: themeData.textTheme.bodyMedium,
                width: w - 30.w,
              ),
            ],
          ),
        ),
        Container(
          width: w,
          color: Colors.white,
          padding: EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              copiableStr(
                "RGB: $rgbStr",
                strToCopy: rgbStr,
                style: themeData.textTheme.bodyMedium,
                width: w - 30.w,
              ),
              copiableStr(
                "CMYK: $cmykStr",
                strToCopy: cmykStr,
                style: themeData.textTheme.bodyMedium,
                width: w - 30.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ColorCardPreviewView extends StatelessWidget {
  final Map map;
  const ColorCardPreviewView({
    super.key,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    String? hexStr = map["hex"];
    if (hexStr == null) return const EmptyWidget();

    Color color = ColorHelper.parseColorFromHexString(hexStr);

    return GestureDetector(
      onTap: () => copyClipboard(hexStr),
      child: Container(
        height: 60.h,
        width: 60.w,
        color: color,
      ),
    );
  }
}
