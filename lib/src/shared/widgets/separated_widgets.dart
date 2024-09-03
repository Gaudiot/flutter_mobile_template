import "package:flutter/material.dart";

class SeparatedRow extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  const SeparatedRow({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    super.key,
  });

  SeparatedRow.builder({
    required List<Widget> children,
    required Widget separator,
    super.key,
  })  : itemCount = children.length,
        itemBuilder = ((_, index) => children[index]),
        separatorBuilder = ((_, __) => separator);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        itemCount * 2 - 1,
        (index) {
          if (index.isEven) {
            return itemBuilder(context, index ~/ 2);
          } else {
            return separatorBuilder(context, index ~/ 2);
          }
        },
      ),
    );
  }
}

class SeparatedColumn extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  const SeparatedColumn({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    super.key,
  });

  SeparatedColumn.builder({
    required List<Widget> children,
    required Widget separator,
    super.key,
  })  : itemCount = children.length,
        itemBuilder = ((_, index) => children[index]),
        separatorBuilder = ((_, __) => separator);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount * 2 - 1,
        (index) {
          if (index.isEven) {
            return itemBuilder(context, index ~/ 2);
          } else {
            return separatorBuilder(context, index ~/ 2);
          }
        },
      ),
    );
  }
}
