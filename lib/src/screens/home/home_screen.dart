import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/widgets/dialogs/info_dialog.dart';

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
        title: Text('ឈ្មោះកម្មវិធី'.tr),
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
        onPressed: () {
          showInfoDialog(
              isError: true,
              title: "Testing",
              message: "Testing Message",
              onTap: () {
                print("Confirm");
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
