import "package:flutter/material.dart";

class SeparatedRow extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  SeparatedRow({
    required List<Widget> children,
    required Widget separator,
    super.key,
  })  : itemCount = children.length,
        itemBuilder = ((_, index) => children[index]),
        separatorBuilder = ((_, __) => separator);

  const SeparatedRow.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    super.key,
  });

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

  SeparatedColumn({
    required List<Widget> children,
    required Widget separator,
    super.key,
  })  : itemCount = children.length,
        itemBuilder = ((_, index) => children[index]),
        separatorBuilder = ((_, __) => separator);

  const SeparatedColumn.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    super.key,
  });

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
