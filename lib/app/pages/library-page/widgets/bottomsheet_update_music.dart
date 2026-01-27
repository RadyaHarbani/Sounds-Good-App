import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sounds_good_app/app/global/global-components/common_button.dart';
import 'package:sounds_good_app/app/global/global-components/common_text_field.dart';
import 'package:sounds_good_app/app/pages/library-page/library_page_controller.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class BottomsheetUpdateMusic extends StatelessWidget {
  final LibraryPageController controller = Get.find<LibraryPageController>();
  BottomsheetUpdateMusic({
    super.key,
    required this.musicId,
    required this.title,
    required this.artist,
  });
  final String musicId;
  final String title;
  final String artist;

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
                      color: orangeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Update Music',
                        style: tsTitleMediumBold(context, blackColor),
                      ),
                      Text(
                        'Update the details of your music.',
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
                      fieldController: controller.titleUpdateController,
                      obscureText: false,
                      hintText: '$title',
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
                      fieldController: controller.artistUpdateController,
                      obscureText: false,
                      hintText: '$artist',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an artist';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),
              Obx(
                () => CommonButton(
                  isLoading: controller.isUpdating.value,
                  text: 'Update Music',
                  backgroundColor: blackColor,
                  textColor: whiteColor,
                  onPressed: () {
                    controller.updateUserMusic(
                      musicId,
                      controller.titleUpdateController.text,
                      controller.artistUpdateController.text,
                    );
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
