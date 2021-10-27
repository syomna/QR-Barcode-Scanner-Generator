import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/widgets/custom_text_field.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class GenerateQRCode extends StatelessWidget {
  GenerateQRCode({Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final _readProvider = context.read<QRProvider>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Screenshot(
                controller: screenshotController,
                child: QrImage(
                  data: context.watch<QRProvider>().customMessage,
                  gapless: false,
                  size: 200,
                  embeddedImageStyle:
                      QrEmbeddedImageStyle(size: const Size(29, 29)),
                  embeddedImage: _readProvider.importedImage != null
                      ? FileImage(_readProvider.importedImage!)
                      : null,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  errorStateBuilder: (context, child) =>
                      const Text('Something wrong'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _readProvider.importedImage != null
                ? Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            text: 'Import Image',
                            onPressed: () {
                              _readProvider.importImage();
                            }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                            text: 'Delete Image',
                            color: Colors.red,
                            onPressed: () {
                              _readProvider.deleteImportedImage();
                            }),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustomButton(
                        text: 'Import Image',
                        onPressed: () {
                          _readProvider.importImage();
                        })),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hint: 'Write Custom Message!',
              prefixIcon: Icons.text_format,
              onChanged: (value) {
                _readProvider.getCustomMessage(value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                        text: 'Save As An Image',
                        color: _readProvider.customMessage.isEmpty
                            ? Colors.grey
                            : kPrimaryColor,
                        onPressed: () async {
                          if (_readProvider.customMessage.isNotEmpty) {
                            bool isSaved = await _readProvider
                                .saveImage(screenshotController);

                            isSaved
                                ? kSnackBar(context, 'Image saved to Gallery')
                                : kSnackBar(context,
                                    'Uh oh, Something wrong happened!');
                          }
                        })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: CustomButton(
                        text: 'Save Code to History',
                        color: _readProvider.customMessage.isEmpty
                            ? Colors.grey
                            : kPrimaryColor,
                        onPressed: () {
                          if (_readProvider.customMessage.isNotEmpty) {
                            CodeModel codeModel = CodeModel(
                                dataType: 'QR Code',
                                data: _readProvider.customMessage,
                                image: _readProvider.importedImage?.path ?? '',
                                isQR: true,
                                scanedOn: DateTime.now());

                            bool isSuccess = _readProvider.addToBox(codeModel);

                            isSuccess
                                ? kSnackBar(context, 'Code saved succesfully')
                                : kSnackBar(context,
                                    'Uh oh, Something wrong happened!');
                          }
                        }))
              ],
            )
          ],
        ),
      ),
    );
  }
}
