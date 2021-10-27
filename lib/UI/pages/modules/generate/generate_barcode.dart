import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/modules/generate/bar_codes/contact_bar_code.dart';
import 'package:scanner/UI/pages/modules/generate/bar_codes/text_bar_code.dart';
import 'package:scanner/UI/pages/modules/generate/bar_codes/wifi_bar_code.dart';

class GenerateBarCode extends StatelessWidget {
  const GenerateBarCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Generate Text Bar Code'),
              leading: const Icon(Icons.text_format),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => navigateTo(context, TextBarCode()),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text('Generate Wifi Bar Code'),
              leading: const Icon(Icons.wifi),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => navigateTo(context, WifiBarCode()),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text('Generate Contact Bar Code'),
              leading: const Icon(Icons.contact_phone),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => navigateTo(context, ContactBarCode()),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
