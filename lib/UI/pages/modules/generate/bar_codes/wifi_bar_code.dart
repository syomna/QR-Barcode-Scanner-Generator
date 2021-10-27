import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/widgets/custom_text_field.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class WifiBarCode extends StatelessWidget {
  WifiBarCode({Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final me = MeCard.wifi(
      ssid: context.watch<QRProvider>().wifiSSID,
      password: context.watch<QRProvider>().wifiPassword,
    );

    final _readProvider = context.read<QRProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Wifi Bar Code'),
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
                  data: me.toString(),
                  drawText: false,
                  backgroundColor: Colors.white,
                  errorBuilder: (context, error) => Center(child: Text(error)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  hint: 'ssid'.toUpperCase(),
                  prefixIcon: Icons.signal_cellular_alt,
                  onChanged: (value) {
                    _readProvider.getWifiSSID(value);
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  hint: 'Password',
                  prefixIcon: Icons.lock,
                  onChanged: (value) {
                    _readProvider.getWifiPassword(value);
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          text: 'Save As An Image',
                          color: _readProvider.wifiSSID.isEmpty
                              ? Colors.grey
                              : kPrimaryColor,
                          onPressed: () async {
                            if (_readProvider.wifiSSID.isNotEmpty) {
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
                        color: _readProvider.wifiSSID.isEmpty
                            ? Colors.grey
                            : kPrimaryColor,
                        onPressed: () {
                          if (_readProvider.wifiSSID.isNotEmpty) {
                            CodeModel codeModel = CodeModel(
                                dataType: 'Wifi',
                                data: me.toString(),
                                scanedOn: DateTime.now());

                            bool isSuccess = _readProvider.addToBox(codeModel);
                            isSuccess
                                ? kSnackBar(context, 'Code saved successfully')
                                : kSnackBar(context,
                                    'Uh oh, Something wrong happened!');
                          }
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
