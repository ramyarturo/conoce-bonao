import 'package:flutter/material.dart';

class HorizontalLinedText extends StatelessWidget {
  final String text;

  const HorizontalLinedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(
        child: _Line(
          margin: EdgeInsets.only(left: 10.0, right: 20.0),
        ),
      ),
      Text(text),
      const Expanded(
        child: _Line(
          margin: EdgeInsets.only(left: 20.0, right: 10.0),
        ),
      ),
    ]);
  }
}

class _Line extends StatelessWidget {
  final EdgeInsets margin;

  const _Line({required this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: const Divider(
          color: Colors.black,
          height: 36,
        ));
  }
}
