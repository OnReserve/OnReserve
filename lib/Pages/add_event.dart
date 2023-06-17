import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/model/data_model/check_data_model.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/model/data_model/time_data_model.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/form.dart';
import 'package:gsform/gs_form/widget/section.dart';
import 'package:on_reserve/Controllers/add_event_controller.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: MultiSectionForm(),
    );
  }
}

// ignore: must_be_immutable
class MultiSectionForm extends StatelessWidget {
  MultiSectionForm({Key? key}) : super(key: key);

  late GSForm form;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AddEventController>();
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: form = GSForm.multiSection(
                context,
                style: GSFormStyle(
                  backgroundFieldColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.12),
                  titleStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withAlpha(200),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  sectionCardPadding: 12.0,
                  sectionCardElevation: 0.0,
                  fieldRadius: 8.0,
                  backgroundFieldColorDisable: Colors.grey.withOpacity(0.12),
                  sectionTitleStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                sections: [
                  GSSection(
                    sectionTitle: 'Event information',
                    key: const Key('Event information'),
                    fields: [
                      GSField.spinner(
                        tag: 'companyId',
                        title: "Company",
                        weight: 12,
                        items: List<SpinnerDataModel>.generate(
                          controller.args['companies'].length,
                          (index) => SpinnerDataModel(
                            name: controller.args['companies'][index]['company']
                                ['name'],
                            id: controller.args['companies'][index]['company']
                                ['id'],
                          ),
                        ),
                      ),
                      GSField.text(
                        tag: 'title',
                        title: "Event Title",
                        maxLength: 20,
                        maxLine: 1,
                      ),
                      GSField.textPlain(
                        tag: 'desc',
                        title: "Event Description",
                        minLine: 5,
                        maxLength: 90,
                      ),
                      GSField.checkList(
                          tag: 'categories',
                          title: "Event Category",
                          searchable: false,
                          selectedIcon: const Icon(
                            Icons.check_box,
                            color: Colors.green,
                            size: 20.0,
                          ),
                          items: List<CheckDataModel>.generate(
                            controller.args['categories'].length,
                            (index) => CheckDataModel(
                              title: controller.args['categories'][index]
                                  ['name'],
                              data: controller.args['categories'][index]['id'],
                              isSelected: false,
                            ),
                          ),
                          callBack: (value) {}),
                    ],
                  ),
                  GSSection(
                    sectionTitle: 'Date & Time',
                    key: const Key('Date & Time'),
                    fields: [
                      GSField.datePicker(
                        tag: 'eventStart',
                        title: 'Event Date',
                        weight: 12,
                        required: true,
                        postfixWidget: const Icon(
                          Icons.calendar_month,
                          color: Color(0xff676767),
                        ),
                        displayDateType: GSDateFormatType.numeric,
                        calendarType: GSCalendarType.gregorian,
                        availableFrom: GSDate(
                          year: DateTime.now().year,
                          month: DateTime.now().month,
                          day: DateTime.now().day,
                        ),
                        availableTo: GSDate(
                          year: DateTime.now().year + 1,
                          month: DateTime.now().month,
                          day: DateTime.now().day,
                        ),
                      ),
                      GSField.time(
                        tag: 'eventStartTime',
                        title: 'Start Time',
                        weight: 6,
                        hint: '10:00',
                        initialTime: TimeOfDay.now(),
                        required: true,
                      ),
                      GSField.time(
                        tag: 'eventEndTime',
                        title: 'End Time',
                        weight: 6,
                        hint: '12:00',
                        initialTime: TimeOfDay.now(),
                        required: true,
                      ),
                      GSField.datePicker(
                        tag: 'Deadline Date',
                        title: 'Deadline Date & Time',
                        weight: 8,
                        required: true,
                        postfixWidget: const Icon(
                          Icons.calendar_month,
                          color: Color(0xff676767),
                        ),
                        displayDateType: GSDateFormatType.numeric,
                        calendarType: GSCalendarType.gregorian,
                        availableFrom: GSDate(
                          year: DateTime.now().year,
                          month: DateTime.now().month,
                          day: DateTime.now().day + 1,
                        ),
                      ),
                      GSField.time(
                        tag: 'eventDeadline',
                        weight: 4,
                        hint: '10:00',
                        initialTime: TimeOfDay.now(),
                        required: true,
                      ),
                    ],
                  ),
                  GSSection(
                    sectionTitle: 'Location Information',
                    fields: [
                      GSField.text(
                        tag: 'city',
                        title: "City",
                        weight: 12,
                        required: true,
                      ),
                      GSField.text(
                        tag: 'street',
                        title: "Street",
                        weight: 12,
                        required: true,
                      ),
                      GSField.text(
                        tag: 'venue',
                        title: "Venue",
                        weight: 12,
                        required: true,
                      ),
                      GSField.number(
                        tag: 'latitude',
                        title: "Latitude",
                        weight: 6,
                        required: true,
                      ),
                      GSField.number(
                        tag: 'longitude',
                        title: "Longitude",
                        weight: 6,
                        required: true,
                      ),
                    ],
                  ),
                  GSSection(
                    sectionTitle: 'Seat Information',
                    fields: [
                      GSForm.multiSection(
                        context,
                        sections: [
                          GSSection(sectionTitle: 'VIP', fields: [
                            GSField.number(
                              tag: 'vipSeats',
                              title: "No. of Seats",
                              weight: 6,
                              required: true,
                            ),
                            GSField.price(
                              tag: "vipPrice",
                              title: "Price",
                              currencyName: 'ETB',
                              weight: 6,
                              required: true,
                            ),
                          ]),
                          GSSection(sectionTitle: 'Economy', fields: [
                            GSField.number(
                              tag: 'economySeats',
                              title: "No. of Seats",
                              weight: 6,
                              required: true,
                            ),
                            GSField.price(
                              tag: "economyPrice",
                              title: "Price",
                              currencyName: 'ETB',
                              weight: 6,
                              required: true,
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                  GSSection(
                    sectionTitle: 'Event Pictures',
                    fields: [
                      GSField.multiImagePicker(
                        tag: 'images',
                        required: false,
                        title: 'Event Pictures',
                        hint: 'Select Pictures',
                        iconWidget: const Icon(Icons.add),
                        maximumImageCount: 5,
                        showCropper: false,
                        weight: 12,
                        maximumSizePerImageInKB: 5000,
                        onErrorSizeItem: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Maximum size exception"),
                          ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isValid = form.isValid();
                      Map<String, dynamic> map = form.onSubmit();
                      debugPrint(isValid.toString());
                      var x = map.map((key, value) {
                        var val;
                        if (value is SpinnerDataModel) {
                          val = value.id;
                        }
                        if (key == 'categories' && value != null) {
                          val = (value as List<CheckDataModel>)
                              .where((element) => element.isSelected)
                              .map((e) => e.data)
                              .toList();
                        }
                        if (value is DateDataModel) {
                          val = value.showDateStr;
                        }
                        if (value is TimeDataModel) {
                          val = value.displayTime;
                        }
                        return MapEntry(key, val ?? value);
                      });
                      debugPrint(jsonEncode(x));
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
