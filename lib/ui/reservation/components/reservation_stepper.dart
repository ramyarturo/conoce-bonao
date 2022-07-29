import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/controllers/reservation_controller.dart';

class ReservationStepper extends StatelessWidget {
  ReservationStepper({super.key});
  final controller = Get.find<ReservationController>();

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      currentStep: controller.currentStep,
      elevation: 0,
      steps: controller.steps.entries.map((step) {
        final stepIndex = controller.steps.keys.toList().indexOf(step.key);
        return Step(
          isActive: controller.stepState[stepIndex] ?? false,
          title: Text(step.key),
          content: step.value(),
          state: controller.stepState[stepIndex] == true ? StepState.complete : StepState.indexed,
        );
      }).toList(),
      controlsBuilder: (_, __) => const SizedBox(),
    );
  }
}
