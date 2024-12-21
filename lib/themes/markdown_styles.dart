import 'package:capp_flutter/utils/base_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownStyles {
  static MarkdownStyleSheet getMarkdownStyleFrom(TextStyle style) {
    final double fs = style.fontSize ?? 14.sp;
    return MarkdownStyleSheet(
      a: style,
      p: style,
      code: style.copyWith(color: Colors.orange),
      codeblockDecoration: const BoxDecoration(
        color: Colors.black,
      ),
      h1: style.copyWith(
        fontSize: fs * 2.5,
      ),
      h2: style.copyWith(
        fontSize: fs * 2.0,
      ),
      h3: style.copyWith(
        fontSize: fs * 1.75,
      ),
      h4: style.copyWith(
        fontSize: fs * 1.5,
      ),
      h5: style.copyWith(
        fontSize: fs * 1.25,
      ),
      h6: style.copyWith(
        fontSize: fs * 1.1,
      ),
      em: style.copyWith(
        fontStyle: FontStyle.italic,
      ),
      strong: style.copyWith(
        fontWeight: FontWeight.bold,
      ),
      del: style,
      blockquote: style,
      img: style,
      checkbox: style,
      listBullet: style,
      tableHead: style,
      tableBody: style,
    );
  }
}
