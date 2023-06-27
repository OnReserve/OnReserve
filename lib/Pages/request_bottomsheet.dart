import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/payment_request.dart';
import 'package:on_reserve/helpers/log/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestMoneyBottomSheet extends StatelessWidget {
  const RequestMoneyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RequestMoneyController());
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
                        'Request Money',
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
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.formKey,
                    child: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 75,
                            minHeight: 65,
                          ),
                          child: TextFormField(
                            controller: controller.bank,
                            validator:
                                ValidationBuilder().minLength(10).build(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bank Account No.',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 75,
                            minHeight: 65,
                          ),
                          child: TextFormField(
                            controller: controller.bank,
                            validator:
                                ValidationBuilder().minLength(10).build(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Bank Account Name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetBuilder<RequestMoneyController>(
                            builder: (profileController) {
                          return Padding(
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
                                if (profileController.formKey.currentState!
                                    .validate()) {
                                  if (await profileController.sendRequest()) {
                                    Get.back();
                                    Get.snackbar('Success', 'Reqeust Sent',
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Something went wrong',
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                }
                              },
                              child: profileController.isLoading
                                  ? Container(
                                      width: 15,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxHeight: 15,
                                          maxWidth: 15,
                                        ),
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    )
                                  : Text('Send Request'),
                            ),
                          );
                        }),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      logger(RequestMoneyBottomSheet).e('Could not launch $_url');
    }
  }
}
