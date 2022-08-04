
import 'package:flutter/material.dart';

class UserTags extends StatelessWidget {
  const UserTags({
    Key? key,
    required this.tags,
  }) : super(key: key);

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 0.5,
      spacing: 6.9,
      children: [
        for (var tag in tags)
          Chip(
            label: Text(
              "#$tag",
              style: const TextStyle(
                color: Color(0xff828282),
              ),
            ),
            backgroundColor: Colors.transparent,
            shape: const StadiumBorder(
              side: BorderSide(
                color: Color(0xfff2f2f2),
              ),
            ),
          )
      ],
    );
  }
}
