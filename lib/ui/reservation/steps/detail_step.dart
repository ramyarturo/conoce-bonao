import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/fees.dart';
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/ui/reservation/reservation_page.dart';
import 'package:conoce_bonao/ui/reservation/steps/base_step.dart';
import 'package:conoce_bonao/ui/reservation/steps/components/detail_heading.dart';
import 'package:conoce_bonao/ui/reservation/steps/components/detail_image.dart';
import 'package:conoce_bonao/ui/reservation/steps/components/detail_number_picker.dart';
import 'package:conoce_bonao/ui/reservation/steps/components/detail_time_picker.dart';
import 'package:conoce_bonao/utils/format_utils.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

import '../../../constants/theme.dart';
import '../../../controllers/reservation_controller.dart';

class DetailStep extends StatefulWidget {
  const DetailStep({super.key});
  @override
  State<DetailStep> createState() => _DetailStepState();
}

class _DetailStepState extends BaseStep<DetailStep> {
  ReservationDetails get details => controller.reservationDetails;

  @override
  Widget build(BuildContext context) {
    return details.isHotelReservation
        ? HotelDetailStep(
            hotel: details.hotel!,
          )
        : RestaurantDetailStep(
            restaurant: details.restaurant!,
          );
  }
}

class HotelDetailStep extends StatelessWidget {
  final HotelModel hotel;
  final controller = Get.find<ReservationController>();

  HotelDetailStep({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailImage(imagePath: hotel.image),
        const VerticalSpacing(defaultVerticalSpacing),
        DetailHeading(
          title: hotel.name,
          subtitle: "Reservar",
          rating: hotel.rating,
        ),
        const VerticalSpacing(defaultVerticalSpacing),
        Text(
          "Detalles",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const VerticalSpacing(20),
        DetailNumberPicker(
          title: "Cant Personas",
          onChanged: (value) {
            controller.hotelReservation.update((val) => val?.amountPeople = value);
          },
        ),
        DetailNumberPicker(
            title: "Cant Noches",
            onChanged: (value) {
              controller.hotelReservation.update((val) => val?.amountNight = value);
            }),
        const VerticalSpacing(15),
        DetailTimePicker(
            title: "Fecha",
            datePicker: true,
            onDateChange: (date) {
              controller.hotelReservation.value.date = date;
            }),
        const VerticalSpacing(25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Precio por noche"),
            Text(FormatUtils.formatCurrency(FeeReservation.hotelPriceByNight)),
          ],
        ),
        const Divider(thickness: 1),
        const VerticalSpacing(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Taxes"),
            Text(FormatUtils.formatCurrency(FeeReservation.hotelTaxes)),
          ],
        ),
        const Divider(thickness: 1),
        const VerticalSpacing(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total"),
            Obx(() {
              return Text(
                FormatUtils.formatCurrency(controller.hotelReservation.value.total),
                style: const TextStyle(
                  color: greenColor,
                ),
              );
            }),
          ],
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}

class RestaurantDetailStep extends StatelessWidget {
  final RestaurantModel restaurant;
  final controller = Get.find<ReservationController>();

  RestaurantDetailStep({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailImage(imagePath: restaurant.image),
        DetailHeading(
          title: restaurant.title,
          subtitle: "Reservar",
          rating: restaurant.rating,
        ),
        const VerticalSpacing(14),
        Text(
          "Detalles",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const VerticalSpacing(20),
        DetailNumberPicker(
          title: "Cant Personas",
          onChanged: (number) {
            controller.restaurantReservation.update((val) => val?.amountPeople = number);
          },
        ),
        const VerticalSpacing(15),
        DetailTimePicker(
          title: "Hora de llegada",
          onTimeChange: (time) {
            controller.restaurantReservation.value.arrivalTime = time;
          },
        ),
        const VerticalSpacing(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Fee de reservación"),
            Text(FormatUtils.formatCurrency(FeeReservation.restaurantFeeReservation)),
          ],
        ),
        const Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total"),
            Obx(() => Text(
                  FormatUtils.formatCurrency(controller.restaurantReservation.value.total),
                  style: const TextStyle(
                    color: greenColor,
                  ),
                )),
          ],
        ),
        const Divider(thickness: 2),
        _buildNote(),
      ],
    );
  }

  Widget _buildNote() {
    return const Text(
      "Recuerde que una vez pasada su hora de reservacion tiene 15 minutos antes de que la reservacion se cancele.",
      textAlign: TextAlign.center,
    );
  }
}
