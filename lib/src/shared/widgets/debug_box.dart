import "dart:math" as math;

import "package:flutter/material.dart";

class DebugBox extends StatelessWidget {
  final Widget child;
  late final Color color;
  final bool isActive;
  late final bool _isFilled;

  DebugBox({
    required this.child,
    this.isActive = true,
    super.key,
  }) {
    _isFilled = false;
    color = isActive
        ? Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
        : Colors.transparent;
  }

  DebugBox.filled({
    required this.child,
    this.isActive = true,
    super.key,
  }) {
    _isFilled = true;
    color = isActive
        ? Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
        : Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        color: _isFilled
            ? color.withAlpha((255 * 0.2).ceil())
            : Colors.transparent,
      ),
      child: child,
    );
  }
}
