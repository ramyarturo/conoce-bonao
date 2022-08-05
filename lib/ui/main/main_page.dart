import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/theme.dart';
import '../../controllers/main_controller.dart';
import 'components/main_app_bar.dart';
import 'components/main_carousel.dart';
import 'components/main_ecotourism.dart';
import 'components/main_hotels.dart';
import 'components/main_restaurants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          const MainAppBar(),
          const SliverToBoxAdapter(child: VerticalSpacing(defaultPadding * 2.9)),
          const SliverToBoxAdapter(
            child: MainCarousel(),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const MainEcotourism(),
                const VerticalSpacing(),
                const MainRestaurants(),
                const VerticalSpacing(),
                const MainHotels(),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
