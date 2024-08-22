import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/service/localization_service.dart';
import 'package:getx_project/src/widgets/dialogs/info_dialog.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text('app_title'.tr),
        title: Text('app_title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('app_title'.tr),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<int> numbers = [];
          try {
            log("Number: ${numbers.first}");
          } on Exception catch (error, stacktrace) {
            Sentry.captureException(error, stackTrace: stacktrace);
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
