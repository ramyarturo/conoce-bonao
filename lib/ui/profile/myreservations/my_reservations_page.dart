// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conoce_bonao/models/hotel.dart';
import 'package:conoce_bonao/models/restaurant.dart';
import 'package:conoce_bonao/utils/exts/string_exts.dart';
import 'package:flutter/material.dart';

import 'package:conoce_bonao/constants/controllers.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/controllers/user_controller.dart';
import 'package:conoce_bonao/utils/format_utils.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';
import 'package:conoce_bonao/widgets/rx_value_listeneable.dart';
import 'package:conoce_bonao/widgets/shimmer_loading_widget.dart';

import '../../../gen/assets.gen.dart';

class MyReservationsPage extends StatefulWidget {
  MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reservaciones",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Assets.icons.tagNote.image(
                  width: 29,
                ),
                const SizedBox(width: 15),
                Text(
                  "#MisReservaciones",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const VerticalSpacing(defaultVerticalSpacing),
            Flexible(
              child: RxValueListeneableBuilder<UserReservation>(
                value: userController.userReservations,
                onLoading: const _ReservationItemLoadingWidget(),
                builder: (context, value) {
                  final localizations = MaterialLocalizations.of(context);
                  return ListView.builder(
                    itemCount: value.hotels.length + value.restaurants.length,
                    itemBuilder: (context, index) {
                      final data = {
                        ...value.hotels.entries,
                        ...value.restaurants.entries,
                      }.toList();
                      data.sort((a, b) => b.key.state.compareTo(a.key.state));
                      final reservation = data[index];
                      final item = reservation.value;
                      final isRestaurant = item is RestaurantModel;
                      final isHotel = item is HotelModel;
                      return _ReservationItem(
                        reservationInfo: ReservationInfo(
                          title: isRestaurant ? item.name : (item as HotelModel).name,
                          state: reservation.key.state,
                          amountPeople: isRestaurant
                              ? reservation.key.restaurantReservationDetail!.amountPeople
                              : reservation.key.hotelReservationDetail!.amountNight,
                          amountNight: isHotel ? reservation.key.hotelReservationDetail!.amountNight : 0,
                          date: isRestaurant
                              ? localizations.formatTimeOfDay(reservation.key.restaurantReservationDetail!.arrivalTime)
                              : localizations.formatFullDate(reservation.key.hotelReservationDetail!.date),
                          amount: reservation.key.restaurantReservationDetail?.total.toStringAsFixed(2) ??
                              reservation.key.hotelReservationDetail!.total.toStringAsFixed(2),
                        ),
                        onCancel: () {
                          userController.updateUserReservation(reservation.key);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReservationInfo {
  String title;
  String state;
  String date;
  String amount;
  int amountPeople;
  int amountNight;
  ReservationInfo({
    required this.title,
    required this.state,
    required this.date,
    required this.amount,
    this.amountPeople = 0,
    this.amountNight = 0,
  });
}

class _ReservationItem extends StatelessWidget {
  final VoidCallback onCancel;
  final ReservationInfo reservationInfo;
  const _ReservationItem({
    super.key,
    required this.reservationInfo,
    required this.onCancel,
  });
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color(0xfff2f2f2),
          )),
      child: Container(
        padding: const EdgeInsets.only(
          top: defaultPadding * 2,
          bottom: defaultPadding,
          right: defaultPadding * 2,
          left: defaultPadding * 2,
        ),
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reservationInfo.title, style: textTheme.titleSmall),
                Text(
                  reservationInfo.state.capitalize(),
                  style: textTheme.labelSmall!.copyWith(
                    color: reservationInfo.state != "Cancelado" ? greenColor : orangeColor,
                  ),
                )
              ],
            ),
            const VerticalSpacing(defaultVerticalSpacing),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Personas ",
                    style: textTheme.labelSmall!.copyWith(
                      color: darkLightColor,
                    )),
                TextSpan(text: reservationInfo.amountPeople.toString(), style: textTheme.labelSmall),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(
                    text: "Noches ",
                    style: textTheme.labelSmall!.copyWith(
                      color: darkLightColor,
                    )),
                TextSpan(text: reservationInfo.amountNight.toString(), style: textTheme.labelSmall),
              ]),
            ),
            const VerticalSpacing(defaultVerticalSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reservationInfo.date, style: textTheme.labelSmall),
                Text(
                  FormatUtils.formatCurrency(15000),
                  style: textTheme.labelLarge,
                ),
              ],
            ),
            if (reservationInfo.state != "Cancelado")
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: onCancel,
                child: const Text("Cancelar"),
              )
          ],
        ),
      ),
    );
  }
}

class _ReservationItemLoadingWidget extends StatelessWidget {
  const _ReservationItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.filled(
        3,
        const Padding(
          padding: EdgeInsets.only(
            right: 7.0,
          ),
          child: ShimmerLoadingWidget(placeholder: _ReservationItemPlaceholder()),
        ),
      ),
    );
  }
}

class _ReservationItemPlaceholder extends StatelessWidget {
  const _ReservationItemPlaceholder();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(
        top: defaultPadding * 2,
        bottom: defaultPadding,
        right: defaultPadding * 2,
        left: defaultPadding * 2,
      ),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 120,
                color: Colors.white,
              ),
              Container(
                height: 10,
                width: 80,
                color: Colors.white,
              ),
            ],
          ),
          const VerticalSpacing(defaultVerticalSpacing),
          Row(
            children: [
              Container(
                height: 10,
                width: 80,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Container(
                height: 10,
                width: 80,
                color: Colors.white,
              ),
            ],
          ),
          const VerticalSpacing(defaultVerticalSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10,
                width: 80,
                color: Colors.white,
              ),
              Container(
                height: 10,
                width: 65,
                color: Colors.white,
              ),
            ],
          ),
          const VerticalSpacing(defaultVerticalSpacing),
          OutlinedButton(
            child: const Text("Placeholder"),
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
