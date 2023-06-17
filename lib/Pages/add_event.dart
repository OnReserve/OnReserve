import 'package:flutter/material.dart';
import 'package:gsform/gs_form/model/data_model/check_data_model.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/form.dart';
import 'package:gsform/gs_form/widget/section.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: form = GSForm.multiSection(context, sections: [
                GSSection(
                  sectionTitle: 'Event information',
                  key: const Key('Event information'),
                  fields: [
                    GSField.spinner(
                      tag: 'Company Name',
                      title: "Select Company",
                      weight: 12,
                      items: [
                        SpinnerDataModel(name: 'Company 1', id: 1),
                        SpinnerDataModel(name: 'Company 2', id: 2),
                        SpinnerDataModel(name: 'Company 3', id: 3),
                      ],
                    ),
                    GSField.text(tag: 'Event Title', title: "Event Title"),
                    GSField.textPlain(
                      tag: 'Event Description',
                      title: "Event Description",
                      minLine: 5,
                      maxLength: 10,
                    ),
                    GSField.checkList(
                        tag: 'Event Category',
                        title: "Event Category",
                        searchable: false,
                        selectedIcon: const Icon(
                          Icons.check_box,
                          color: Colors.green,
                          size: 20.0,
                        ),
                        items: [
                          CheckDataModel(
                              title: 'Category 1', isSelected: false),
                          CheckDataModel(
                              title: 'Category 2', isSelected: false),
                          CheckDataModel(
                              title: 'Category 3', isSelected: false),
                        ],
                        callBack: (value) {}),
                  ],
                ),
                GSSection(
                  sectionTitle: 'Date & Time',
                  key: const Key('Date & Time'),
                  fields: [
                    GSField.datePicker(
                      tag: 'EventStartDate',
                      title: 'Event Date',
                      weight: 12,
                      required: true,
                      postfixWidget: const Icon(
                        Icons.calendar_month,
                        color: Color(0xff676767),
                      ),
                      displayDateType: GSDateFormatType.numeric,
                      calendarType: GSCalendarType.gregorian,
                    ),
                    GSField.time(
                      tag: 'Starttime',
                      title: 'Start Time',
                      weight: 6,
                      hint: '10:00',
                      required: true,
                    ),
                    GSField.time(
                      tag: 'Endtime',
                      title: 'End Time',
                      weight: 6,
                      hint: '12:00',
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
                    ),
                    GSField.time(
                      tag: 'Deadlinetime',
                      // title: 'Time',
                      weight: 4,
                      hint: '10:00',
                      required: true,
                    ),
                  ],
                ),
                GSSection(
                  sectionTitle: 'Location Information',
                  fields: [
                    GSField.text(
                      tag: 'Event Location',
                      title: "City",
                      weight: 12,
                      required: true,
                    ),
                    GSField.text(
                      tag: 'Event Location',
                      title: "Street",
                      weight: 12,
                      required: true,
                    ),
                    GSField.text(
                      tag: 'Event Location',
                      title: "Venue",
                      weight: 12,
                      required: true,
                    ),
                    GSField.number(
                      tag: 'Event Location',
                      title: "Latitude",
                      weight: 6,
                      required: true,
                    ),
                    GSField.number(
                      tag: 'Event Location',
                      title: "Latitude",
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
                            tag: 'Seat Information',
                            title: "No. of Seats",
                            weight: 6,
                            required: true,
                          ),
                          GSField.price(
                            tag: "Seat Information",
                            title: "Price",
                            currencyName: 'ETB',
                            weight: 6,
                            required: true,
                          ),
                        ]),
                        GSSection(sectionTitle: 'Economy', fields: [
                          GSField.number(
                            tag: 'Seat Information',
                            title: "No. of Seats",
                            weight: 6,
                            required: true,
                          ),
                          GSField.price(
                            tag: "Seat Information",
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
                      tag: 'multi',
                      required: true,
                      title: 'Event Pictures',
                      hint: 'Select Pictures',
                      iconWidget: const Icon(Icons.add),
                      maximumImageCount: 5,
                      showCropper: false,
                      weight: 12,
                      // defaultImagePathValues: const [
                      //   '/data/user/0/com.golrang.salesplus2/app_flutter/testImage.png'
                      // ],
                      maximumSizePerImageInKB: 80,
                      onErrorSizeItem: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Maximum size exception"),
                        ));
                      },
                    ),
                  ],
                ),
              ]),
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
                      debugPrint(map.toString());
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
