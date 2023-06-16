import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/profile_controller.dart';

enum OnReserveTheme { light, dark, system }

class AddCompanyBottomSheet extends StatelessWidget {
  const AddCompanyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            top: 20,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'Add Company',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close_outlined)),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: profileController.formKey,
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 75,
                              minHeight: 65,
                            ),
                            child: TextFormField(
                              controller: profileController.name,
                              validator:
                                  ValidationBuilder().minLength(3).build(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Company Name',
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // ConstrainedBox(
                          //   constraints: const BoxConstraints(
                          //     maxHeight: 45,
                          //   ),
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       labelText: 'Company Phone Number',
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 75,
                              minHeight: 65,
                            ),
                            child: TextFormField(
                              controller: profileController.bio,
                              validator:
                                  ValidationBuilder().minLength(10).build(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Company Description',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // Logo Upload
                          GetBuilder<ProfileController>(
                              builder: (profileController) {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      profileController.getImage(profile: true);
                                    },
                                    child: Container(
                                      height: 90,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: profileController.profilePic ==
                                              null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_a_photo,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                SizedBox(height: 8),
                                                Text(
                                                  "Profile Image",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                )
                                              ],
                                            )
                                          : Image.file(
                                              File(profileController
                                                  .profilePic!.path),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      profileController.getImage(
                                          profile: false);
                                    },
                                    child: Container(
                                      height: 90,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: profileController.coverPic == null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_a_photo,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                SizedBox(height: 8),
                                                Text(
                                                  "Cover Image",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                )
                                              ],
                                            )
                                          : Image.file(
                                              File(profileController
                                                  .coverPic!.path),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
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
                                if (profileController.formKey.currentState!
                                    .validate()) {
                                  if (await profileController.addCompany()) {
                                    Get.back();
                                    Get.snackbar('Success', 'Company Added',
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Something went wrong',
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                }
                              },
                              child: Text('Add Company'),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
