import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/layout/layout_page.dart';
import 'package:scanner/UI/widgets/custom_back_arrow.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/provider/qr_provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key, this.isFromImage = false , this.result}) : super(key: key);

  final bool isFromImage;
  final Barcode? result;
  @override
  Widget build(BuildContext context) {
    final String? scanImage = context.read<QRProvider>().scanImage;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => navigateAndRemove(context, const LayoutPage()),
          child: const CustomBackArrow(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isFromImage
                ? Text(
                    'Data: $scanImage',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : Text(
                    'Barcode Type: ${describeEnum(result!.format)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
            const SizedBox(
              height: 10,
            ),
            isFromImage
                ? const SizedBox()
                : Text(
                    'Data: ${result?.code}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
            const SizedBox(
              height: 20,
            ),
            _openLink(context, scanImage, result)
          ],
        ),
      ),
    );
  }

  Widget _openLink(BuildContext context, String? scanImage, Barcode? result) {
    if (scanImage != null && scanImage.contains('https://') ||
        scanImage != null && scanImage.contains('http://')) {
      return Padding(
        padding: const EdgeInsets.only(left: 100),
        child: CustomButton(
            text: 'Open Link',
            onPressed: () {
              context.read<QRProvider>().launchURL(scanImage);
            }),
      );
    } else {
      if (result != null && result.code.contains('https://') ||
          result != null && result.code.contains('http://')) {
        return Padding(
          padding: const EdgeInsets.only(left: 100),
          child: CustomButton(
              text: 'Open Link',
              onPressed: () {
                context.read<QRProvider>().launchURL(result.code);
              }),
        );
      }

      return const SizedBox();
    }
  }
}
