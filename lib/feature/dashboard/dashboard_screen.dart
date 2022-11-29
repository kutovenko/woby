import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:woby/core/constant/app_constants.dart';
import 'package:woby/feature/collection/collections_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const CollectionsScreen())),
                    child: Text('learn'.tr())),
                ElevatedButton(onPressed: () {}, child: Text('settings'.tr())),
                const SizedBox(
                  height: 16.0,
                ),
                Text('statistics'.tr())
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
