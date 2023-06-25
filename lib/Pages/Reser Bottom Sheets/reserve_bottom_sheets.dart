import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Components/revenue_counter.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:on_reserve/Controllers/event_controller.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ReserveBottomSheet extends StatelessWidget {
  const ReserveBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EventController());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 55,
                    height: 3,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withAlpha(130),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Reserve',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 45,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Economy Seats:',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withAlpha(150),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SpinBox(
                                  keyboardType: TextInputType.number,
                                  digits: 1,
                                  min: 1,
                                  max: 10,
                                  value: 1,
                                  onChanged: (value) =>
                                      controller.setEconomySeats(value)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 45,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'VIP Seats:',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withAlpha(150),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SpinBox(
                                    min: 0,
                                    max: 10,
                                    value: 0,
                                    onChanged: (value) =>
                                        controller.setVipSeats(value)),
                              ),
                            ],
                          )),
                      SizedBox(height: 35.0),
                      DottedLine(
                        dashColor: Theme.of(context).colorScheme.primary,
                        lineThickness: 1.0,
                        dashGapLength: 8.0,
                        dashRadius: 8.0,
                        dashLength: 8.0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Total Price
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: SizedBox()),
                            Text(
                              'Total Price : ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withAlpha(150),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GetBuilder<EventController>(builder: (controller) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.15),
                                ),
                                child: RevenueCountUpAnimation(
                                  startValue: controller.oldPrice + 0.0,
                                  endValue: controller.totalPrice == 0.0
                                      ? controller.args['economyPrice'] + 0.0
                                      : controller.totalPrice,
                                  duration: const Duration(milliseconds: 800),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            foregroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (await controller.reserveTicket()) {
                              Get.snackbar(
                                'Success',
                                'Your ticket has been reserved successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                duration: Duration(seconds: 3),
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Something went wrong',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                duration: Duration(seconds: 3),
                              );
                            }
                            Get.back();
                            _launchUrl(Uri.parse(
                                'https://yenepay.com/checkout/Home/Process/?ItemName=${controller.args['title']}&ItemId=${controller.bookingToken}&UnitPrice=${controller.totalPrice / (controller.vipSeats + controller.economySeats)}&Quantity=${controller.vipSeats + controller.economySeats}&Process=Express&ExpiresAfter=&DeliveryFee=&HandlingFee=&Tax1=&Tax2=&Discount=&SuccessUrl=&IPNUrl=&MerchantId=26459'));
                          },
                          child: Text('Pay Now'),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      logger(ReserveBottomSheet).e('Could not launch $_url');
    }
  }
}
