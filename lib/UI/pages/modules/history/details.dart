import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/UI/widgets/custom_back_arrow.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/UI/widgets/custom_alert_dialog.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class Details extends StatelessWidget {
  Details({Key? key, required this.codeModel, required this.index})
      : super(key: key);

  final CodeModel codeModel;
  final int index;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    String withoutSymbols = codeModel.data!.replaceAll(RegExp(r';'), '  ');

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const CustomBackArrow(),
        ),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                        index: index,
                      ));
            },
            child: const CustomBackArrow(
              icon: Icons.cancel,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Screenshot(
              controller: screenshotController,
              child: codeModel.isQR == true
                  ? Center(
                      child: QrImage(
                          data: '${codeModel.data}',
                          backgroundColor: Colors.white,
                          size: 200,
                          embeddedImage: codeModel.image!.isNotEmpty
                              ? FileImage(File('${codeModel.image}'))
                              : null,
                          embeddedImageStyle:
                              QrEmbeddedImageStyle(size: const Size(29, 29))),
                    )
                  : BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: '${codeModel.data}',
                      drawText: false,
                      backgroundColor: Colors.white,
                      errorBuilder: (context, error) =>
                          Center(child: Text(error)),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Barcode Type: ${codeModel.dataType}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Data: $withoutSymbols',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            if (codeModel.data!.contains('https://') ||
                codeModel.data!.contains('http://'))
              Padding(
                padding: const EdgeInsets.only(left: 100, bottom: 20),
                child: CustomButton(
                    text: 'Open Link',
                    onPressed: () {
                      context.read<QRProvider>().launchURL('${codeModel.data}');
                    }),
              ),
            CustomButton(
                text: 'Save As An Image',
                onPressed: () {
                  context.read<QRProvider>().saveImage(screenshotController);
                }),
          ],
        ),
      ),
    );
  }
}
