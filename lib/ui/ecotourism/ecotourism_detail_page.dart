import 'package:conoce_bonao/models/ecotourism.dart';
import 'package:conoce_bonao/ui/ecotourism/components/ecotourism_description.dart';
import 'package:conoce_bonao/ui/ecotourism/components/ecoutourism_image.dart';
import 'package:conoce_bonao/utils/intent_utils.dart';
import 'package:conoce_bonao/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

class EcotourismDetailPage extends StatelessWidget {
  final Ecotourism ecotourism;

  const EcotourismDetailPage({super.key, required this.ecotourism});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            EcotourismImage(ecotourism: ecotourism),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, value, _) {
                    final transform = Curves.elasticOut.transform(value);
                    return Transform(
                      transform: Matrix4.identity().scaled(1.0, transform),
                      child: Column(
                        children: [
                          
                          const SizedBox(height: 15),
                          EcotourismDescription(ecotourism: ecotourism),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 300,
                            child: CustomButton(
                              text: "Llegar",
                              icon: Icons.map,
                              secundary: true,
                              onPressed: () {
                                final location = ecotourism.location;
                                IntentUtils.openNavigationMap(latLng: location.toLatLng());
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
