import 'package:flutter/material.dart';
import 'package:conoce_bonao/ui/main/components/search_bar.dart';

import '../../../utils/theme/colors.dart';

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final List<Widget> actions;

  AppBarDelegate({required this.title, required this.actions});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: maxExtent,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(43),
                bottomRight: Radius.circular(43),
              )),
          child: IconTheme(
            data: const IconThemeData(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Expanded(child: SizedBox()),
                ...actions,
              ],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.0, 1.5),
          child: AnimatedScale(
            scale: 1 + (-shrinkOffset / maxExtent),
            duration: const Duration(milliseconds: 100),
            child: const SizedBox(
              height: 56,
              width: 300,
              child: MainSearchBar(),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 130;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
