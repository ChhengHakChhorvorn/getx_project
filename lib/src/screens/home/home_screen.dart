import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/src/service/localization_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('app_title'.tr),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'app_title'.tr
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final localizationService =  LocalizationService();
          final currentLang = localizationService.getCurrentLang();
          if(currentLang == LocalizationService.langs[0]){
            localizationService.changeLocale(LocalizationService.langs[1]);
          }else{
            localizationService.changeLocale(LocalizationService.langs[0]);
          }


        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}