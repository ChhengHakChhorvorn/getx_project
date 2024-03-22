import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/widgets/dialogs/info_dialog.dart';

Future<void> fetchDataFromAPI(Function func,
    {bool isLoading = false, Function? onExpiredToken}) async {
  if (isLoading) {
    showLoadingDialog();
  }
  try {
    await func();
    if (isLoading) {
      Get.back(closeOverlays: true);
    }
  } on DioException catch (error) {
    log(error.response?.statusCode.toString() ?? '');
    log(error.requestOptions.data.toString());
    if (error.response?.statusCode.toString() == '401' ||
        error.response?.statusCode.toString() == '403') {
      if (onExpiredToken == null) {
        showInfoDialog(
            title: "Session Expired!",
            message: "Your session has expired, please login again.");
      } else {
        onExpiredToken!(error.response?.statusCode);
      }
    } else {
      showInfoDialog(
        isError: true,
        title: error.response?.statusCode.toString() ?? '',
        message: error.requestOptions.data.toString(),
      );
    }
  } on ErrorDescription catch (error) {
    log(error.toString());
    showInfoDialog(
      isError: true,
      title: 'Something went wrong!',
      message: error.toString(),
    );
  } on Exception catch (error) {
    log(error.toString());
    showInfoDialog(
      isError: true,
      title: 'Something went wrong!',
      message: error.toString(),
    );
  } catch (error) {
    log(error.toString());
    showInfoDialog(
      isError: true,
      title: 'Something went wrong!',
      message: error.toString(),
    );
  }
}

Future<void> showLoadingDialog() async {
  if (Get.isDialogOpen == true) {
    return;
  }
  Get.dialog(
    WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: const CircularProgressIndicator(),
    ),
    transitionDuration: const Duration(milliseconds: 150),
  );
}

Future<void> showSnackbar(String message, {bool isForce = false}) async {
  if (isForce) {
    await Get.closeCurrentSnackbar();
  }

  Get.snackbar(
    "",
    "",
    titleText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    messageText: const SizedBox(),
    margin: const EdgeInsets.all(8),
    snackStyle: SnackStyle.FLOATING,
    animationDuration: const Duration(milliseconds: 150),
    borderRadius: 4,
    backgroundColor: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
  );
}

void closeDialog() {
  Get.back(closeOverlays: true);
}
