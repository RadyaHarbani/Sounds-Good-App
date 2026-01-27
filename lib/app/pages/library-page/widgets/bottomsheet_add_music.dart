import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_button.dart';
import 'package:sounds_good_app/app/global/global-components/common_text_field.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class BottomsheetAddMusic extends StatelessWidget {
  final LibraryPageController controller = Get.find<LibraryPageController>();
  BottomsheetAddMusic({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: height * 0.02,
            bottom: height * 0.04,
            left: width * 0.05,
            right: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: width * 0.15,
                  height: height * 0.005,
                  decoration: BoxDecoration(
                    color: greyColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * 0.02),
                    width: width * 0.013,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Music to Your Library',
                        style: tsTitleMediumBold(context, blackColor),
                      ),
                      Text(
                        'Add your personal library.',
                        style: tsBodyMediumRegular(
                          context,
                          blackColor,
                        ).copyWith(height: 1.3),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITLE',
                      style: tsBodyMediumSemibold(context, greyColor),
                    ),
                    CommonTextField(
                      fieldController: controller.titleController,
                      obscureText: false,
                      hintText: 'Enter Title',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'ARTIST',
                      style: tsBodyMediumSemibold(context, greyColor),
                    ),
                    CommonTextField(
                      fieldController: controller.artistController,
                      obscureText: false,
                      hintText: 'Enter Artist',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an artist';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'THUMBNAIL IMAGE',
                      style: tsBodyMediumSemibold(context, greyColor),
                    ),

                    Obx(
                      () => GestureDetector(
                        onTap: controller.pickImage,
                        child: Container(
                          width: double.infinity,
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),

                            color: greyColor.withValues(alpha: 0.05),
                          ),
                          child: controller.selectedImage.value == null
                              ? Center(
                                  child: Text(
                                    'Tap to select image',
                                    style: tsBodyMediumRegular(
                                      context,
                                      greyColor.withValues(alpha: 0.5),
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    controller.selectedImage.value!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Text(
                      'AUDIO FILE (Max. 10MB)',
                      style: tsBodyMediumSemibold(context, greyColor),
                    ),

                    Obx(
                      () => GestureDetector(
                        onTap: controller.pickAudio,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: greyColor.withValues(alpha: 0.05),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.music_note,
                                color: greyColor.withValues(alpha: 0.5),
                              ),
                              SizedBox(width: width * 0.03),
                              Expanded(
                                child: Text(
                                  controller.selectedAudio.value == null
                                      ? 'Tap to select audio'
                                      : controller.selectedAudio.value!.path
                                            .split('/')
                                            .last,
                                  style: tsBodyMediumRegular(
                                    context,
                                    greyColor.withValues(alpha: 0.5),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.03),
              Obx(
                () => CommonButton(
                  isLoading: controller.isUploading.value,
                  text: 'Upload Music',
                  backgroundColor: blackColor,
                  textColor: whiteColor,
                  onPressed: () {
                    controller.addUserMusic();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
