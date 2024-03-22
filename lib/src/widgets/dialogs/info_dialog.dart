import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/constants/constants.dart';
import 'package:getx_project/src/constants/themes.dart';

showInfoDialog(
    {required String title,
    required String message,
    Function()? onTap,
    bool isError = false,
    String? buttonTitle}) {
  showDialog(
    context: Get.context!,
    builder: (_) => InfoDialog(
      title: title,
      message: message,
      buttonTitle: buttonTitle,
      isError: isError,
      onTap: onTap,
    ),
  );
}

class InfoDialog extends StatelessWidget {
  InfoDialog(
      {super.key,
      required this.title,
      required this.message,
      this.buttonTitle,
      this.isError = false,
      this.onTap});

  String title;
  String message;
  String? buttonTitle;
  bool isError;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(30),
        color: ThemeColors.colorPrimaryWhite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isError,
              replacement: SvgPicture.asset(
                "${ConstantDir.icons}/info.svg",
                height: 40,
                colorFilter: const ColorFilter.mode(
                    ThemeColors.colorPrimaryBlue, BlendMode.srcIn),
              ),
              child: SvgPicture.asset(
                "${ConstantDir.icons}/close-circle-outline.svg",
                height: 40,
                colorFilter: const ColorFilter.mode(
                    ThemeColors.colorPrimaryRed, BlendMode.srcIn),
              ),
            ),
            SizedBox(height: 15),
            Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 18, color: ThemeColors.colorPrimaryGrey),
                  textAlign: TextAlign.left,
                )),
            SizedBox(height: 15),
            InkWell(
              onTap: onTap != null
                  ? () {
                      onTap!.call();
                      Get.back();
                    }
                  : () {
                      Get.back();
                    },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: ThemeColors.colorPrimaryBlue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    buttonTitle ?? 'okay'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
