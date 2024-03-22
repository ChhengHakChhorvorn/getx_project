import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/constants/constants.dart';
import 'package:getx_project/src/constants/themes.dart';

showConfirmDialog(
    {required String title,
    required String message,
    required Function() onConfirm,
    String? buttonTitle}) async {
  final result = await showDialog(
    context: Get.context!,
    builder: (_) => ConfirmDialog(
      title: title,
      message: message,
      buttonTitle: buttonTitle,
      onConfirm: onConfirm,
    ),
  );

  return result;
}

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog(
      {super.key,
      required this.title,
      required this.message,
      this.buttonTitle,
      required this.onConfirm});

  String title;
  String message;
  String? buttonTitle;
  Function() onConfirm;

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
            SvgPicture.asset(
              "${ConstantDir.icons}/warning-triangle-outline.svg",
              height: 40,
              colorFilter: const ColorFilter.mode(
                  ThemeColors.colorPrimaryYellow, BlendMode.srcIn),
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
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ThemeColors.colorPrimaryGrey),
                          color: ThemeColors.colorPrimaryWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          buttonTitle ?? 'no'.tr,
                          style: TextStyle(
                              color: ThemeColors.colorPrimaryBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      onConfirm.call();
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: ThemeColors.colorPrimaryBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          buttonTitle ?? 'yes'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
