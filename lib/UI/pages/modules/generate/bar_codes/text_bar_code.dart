import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/widgets/custom_text_field.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class TextBarCode extends StatelessWidget {
  TextBarCode({Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    final _readProvider = context.read<QRProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Text Bar Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: context.watch<QRProvider>().barCodeCustomMessage.isEmpty
                      ? 'Write Custom Message!'
                      : context.watch<QRProvider>().barCodeCustomMessage,
                  drawText: false,
                  backgroundColor: Colors.white,
                  errorBuilder: (context, error) => Center(child: Text(error)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hint: 'Write Custom Message!',
                  prefixIcon: Icons.text_format,
                  onChanged: (value) {
                    _readProvider.getBarCodeCustomMessage(value);
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          text: 'Save As An Image',
                          color: _readProvider.barCodeCustomMessage.isEmpty
                              ? Colors.grey
                              : kPrimaryColor,
                          onPressed: () async {
                            if (_readProvider.barCodeCustomMessage.isNotEmpty) {
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
                        color: _readProvider.barCodeCustomMessage.isEmpty
                            ? Colors.grey
                            : kPrimaryColor,
                        onPressed: () {
                          if (_readProvider.barCodeCustomMessage.isNotEmpty) {
                            CodeModel codeModel = CodeModel(
                                dataType: 'Text',
                                data: _readProvider.barCodeCustomMessage,
                                scanedOn: DateTime.now());
                            bool isSuccess = _readProvider.addToBox(codeModel);

                            isSuccess
                                ? kSnackBar(context, 'Code saved succesfully')
                                : kSnackBar(context,
                                    'Uh oh, Something wrong happened!');
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
