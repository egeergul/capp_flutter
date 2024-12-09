import 'package:capp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';

enum PopupType { nil }

extension _StringExtensions on PopupType {
  String? get name {
    switch (this) {
      default:
        return null;
    }
  }

  String get title {
    switch (this) {
      default:
        return "";
    }
  }

  String get description {
    switch (this) {
      default:
        return "";
    }
  }
}

extension _WidgetExtensions on PopupType {
  Widget? confirmButton({
    VoidCallback? onTap,
  }) {
    switch (this) {
      default:
        return const EmptyWidget();
    }
  }

  Widget rejectButton({
    VoidCallback? onTap,
  }) {
    switch (this) {
      default:
        return const EmptyWidget();
    }
  }

  Widget get icon {
    switch (this) {
      default:
        return const EmptyWidget();
    }
  }
}

extension _PaddingExtensions on PopupType {
  double get bottomPaddingSize {
    switch (this) {
      default:
        return 32.h;
    }
  }

  double get heightBetweenTitleAndDescription {
    switch (this) {
      default:
        return 16.h;
    }
  }

  double get heightBetweenDescriptionAndButton {
    switch (this) {
      default:
        return 24.h;
    }
  }

  double get heightBetweenIconAndTitle {
    switch (this) {
      default:
        return 30.h;
    }
  }

  double get topPaddingSize {
    switch (this) {
      default:
        return 34.h;
    }
  }
}

extension _CloseIconExtensions on PopupType {
  bool get showCloseIcon {
    switch (this) {
      default:
        return false;
    }
  }
}
