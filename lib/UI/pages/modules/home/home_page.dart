import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/modules/home/qr_view.dart';
import 'package:scanner/UI/pages/modules/home/result_page.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/provider/qr_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _readProvider = context.read<QRProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR & Bar Code Scanner'),
        actions: [
          IconButton(
              onPressed: () {
                _readProvider.changeMode();
              },
              icon: Icon(context.watch<QRProvider>().isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  text: 'Scan From Camera',
                  color: kPrimaryColor,
                  onPressed: () => navigateTo(context, const QRViewPage())),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                  text: 'Scan From Image',
                  color: kPrimaryColor,
                  onPressed: () async {
                    bool isScanImageSuccess =
                        await _readProvider.scanFromImage();
                    if (isScanImageSuccess) {
                      navigateTo(
                          context,
                          const ResultPage(
                            isFromImage: true,
                          ));
                    } else {
                      kSnackBar(
                          context, 'Unsupported, Please try another Image.');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
