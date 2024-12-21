import 'package:capp_flutter/widgets/widgets.dart';
import 'package:capp_flutter/utils/base_imports.dart';
import 'package:flutter/material.dart';

class ColorPaletteDetailedView extends StatelessWidget {
  final dynamic colors;
  const ColorPaletteDetailedView({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    if (colors.runtimeType != List) return const EmptyWidget();
    List l = [...(colors as List)];
    return SizedBox(
      height: 310.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: l.length,
        itemBuilder: (c, i) {
          var e = l[i];
          return ColorCardDetailedView(map: e);
        },
      ),
    );
  }
}

class ColorPalettePreviewView extends StatelessWidget {
  final dynamic colors;
  const ColorPalettePreviewView({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    if (colors.runtimeType != List) return const EmptyWidget();
    List l = [...(colors as List)];
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: l.length,
        itemBuilder: (c, i) {
          var e = l[i];
          return ColorCardPreviewView(map: e);
        },
      ),
    );
  }
}
