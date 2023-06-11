import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:gsform/gs_form/enums/field_status.dart';
import 'package:gsform/gs_form/enums/required_check_list_enum.dart';
import 'package:gsform/gs_form/model/data_model/check_data_model.dart';
import 'package:gsform/gs_form/model/data_model/date_data_model.dart';
import 'package:gsform/gs_form/model/data_model/radio_data_model.dart';
import 'package:gsform/gs_form/model/data_model/spinner_data_model.dart';
import 'package:gsform/gs_form/model/fields_model/image_picker_model.dart';
import 'package:gsform/gs_form/widget/field.dart';
import 'package:gsform/gs_form/widget/form.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Center(
        child: SingleSectionForm(),
      ),
    );
  }
}

// ignore: must_be_immutable
class SingleSectionForm extends StatelessWidget {
  SingleSectionForm({Key? key}) : super(key: key);

  late GSForm form;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: form = GSForm.singleSection(
                  style: GSFormStyle(
                      titleStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  )),
                  context,
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
                      tag: 'time',
                      title: 'Start Time',
                      weight: 6,
                      hint: '10:00',
                      required: true,
                    ),
                    GSField.time(
                      tag: 'time',
                      title: 'End Time',
                      weight: 6,
                      hint: '12:00',
                      required: true,
                    ),
                    GSField.datePicker(
                      tag: 'EventStartDate',
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
                      tag: 'time',
                      // title: 'Time',
                      weight: 4,
                      hint: '10:00',
                      required: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Event Location",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
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
                    GSField.imagePicker(
                      tag: 'image',
                      iconWidget: const Icon(
                        Icons.image,
                      ),
                      title: 'image',
                      imageSource: GSImageSource.both,
                    ),

                    GSField.text(
                      status: GSFieldStatusEnum.disabled,
                      tag: 'name',
                      title: 'First Name',
                      minLine: 1,
                      maxLine: 1,
                      weight: 6,
                      hint: 'jhon',
                      required: false,
                      errorMessage: 'please enter a name',
                    ),
                    GSField.text(
                      tag: 'lastName',
                      title: 'Last name',
                      minLine: 1,
                      maxLine: 1,
                      weight: 6,
                      required: true,
                    ),
                    GSField.password(
                      tag: 'password',
                      title: 'Password',
                      helpMessage: 'contain letter and number',
                      errorMessage: 'error',
                      weight: 12,
                      required: true,
                    ),

                    GSField.spinner(
                      tag: 'customer_type',
                      required: false,
                      weight: 12,
                      title: 'Gender',
                      items: [
                        SpinnerDataModel(
                          name: 'man',
                          id: 1,
                        ),
                        SpinnerDataModel(
                          name: 'woman',
                          id: 2,
                          isSelected: true,
                        ),
                      ],
                    ),
                    GSField.mobile(
                      tag: 'mobile',
                      title: 'Phone number',
                      maxLength: 11,
                      helpMessage: '9357814747',
                      weight: 12,
                      required: false,
                      hint: 'مسیاصعا',
                      errorMessage: 'some error',
                    ),
                    GSField.email(
                      tag: 'email',
                      title: 'Email',
                      errorMessage: 'error',
                      helpMessage: 'someemail@gmail.com',
                      postfixWidget:
                          const Icon(Icons.email, color: Color(0xff676767)),
                      weight: 12,
                      required: false,
                    ),
                    GSField.checkList(
                      hint: 'CheckBox List',
                      tag: 'check',
                      showScrollBar: true,
                      scrollBarColor: Colors.red,
                      height: 200,
                      scrollable: true,
                      requiredCheckListEnum: RequiredCheckListEnum.none,
                      weight: 12,
                      title: 'Size number',
                      searchable: true,
                      searchHint: 'Search...',
                      searchIcon: const Icon(Icons.search),
                      searchBoxDecoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      items: [
                        CheckDataModel(title: 'checkbox  ', isSelected: true),
                        CheckDataModel(title: 'ipsum', isSelected: false),
                        CheckDataModel(title: 'item', isSelected: true),
                        CheckDataModel(title: 'size', isSelected: false),
                        CheckDataModel(title: 'size 1', isSelected: false),
                        CheckDataModel(title: 'size 2', isSelected: false),
                        CheckDataModel(title: 'sample 1', isSelected: false),
                        CheckDataModel(title: 'Sample 2', isSelected: false),
                        CheckDataModel(title: 'Radio', isSelected: false),
                        CheckDataModel(title: 'Tv', isSelected: false),
                        CheckDataModel(title: 'data 1', isSelected: false),
                        CheckDataModel(title: 'data 2', isSelected: false),
                      ],
                      callBack: (data) {},
                    ),
                    GSField.radioGroup(
                      hint: 'Radio Group',
                      tag: 'radio',
                      showScrollBar: true,
                      scrollBarColor: Colors.red,
                      height: 200,
                      scrollable: true,
                      required: true,
                      weight: 12,
                      title: 'Size number',
                      searchable: true,
                      searchHint: 'Search...',
                      searchIcon: const Icon(Icons.search),
                      searchBoxDecoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      items: [
                        RadioDataModel(title: 'lorem', isSelected: true),
                        RadioDataModel(title: 'ipsum', isSelected: false),
                      ],
                      callBack: (data) {},
                    ),
                    GSField.textPlain(
                      tag: 'explain',
                      title: 'Description',
                      weight: 12,
                      maxLength: 150,
                      required: true,
                    ),
                    // GSField.imagePicker(
                    //   tag: 'a',
                    //   title: 'انتخاب تصویر',
                    //   hint: 'فایل خود را انتخاب کنید',
                    //   iconWidget: Lottie.asset(
                    //     'assets/cam.json',
                    //     width: 70,
                    //     height: 70,
                    //   ),
                    //   maximumSizePerImageInBytes: 100,
                    //   onErrorSizeItem: () {
                    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //       content: Text("maximum size exception"),
                    //     ));
                    //   },
                    // ),
                    GSField.multiImagePicker(
                      tag: 'multi',
                      required: true,
                      title: 'انتخاب تصویر',
                      hint: 'فایل خود را انتخاب کنید',
                      iconWidget: const Icon(Icons.add),
                      maximumImageCount: 5,
                      showCropper: false,
                      // defaultImagePathValues: const [
                      //   '/data/user/0/com.golrang.salesplus2/app_flutter/testImage.png'
                      // ],
                      maximumSizePerImageInKB: 80,
                      onErrorSizeItem: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("maximum size exception"),
                        ));
                      },
                    ),
                    GSField.textPlain(
                      tag: 'explain',
                      title: 'Description',
                      weight: 12,
                      maxLine: 2,
                      required: true,
                    ),
                    GSField.textPlain(
                      showCounter: true,
                      tag: 'explain',
                      title: 'Description',
                      weight: 12,
                      maxLine: 5,
                      required: true,
                    ),
                  ],
                ),
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
