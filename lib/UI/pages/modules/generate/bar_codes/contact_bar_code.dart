import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/widgets/custom_text_field.dart';
import 'package:scanner/UI/widgets/custom_button.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class ContactBarCode extends StatelessWidget {
  ContactBarCode({Key? key}) : super(key: key);

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var _readProvider = context.read<QRProvider>();
    var _watchProvider = context.watch<QRProvider>();

    final me = MeCard.contact(
        name: _watchProvider.contactName,
        address: _watchProvider.contactAddress,
        email: _watchProvider.contactEmail,
        memo: _watchProvider.contactMemo,
        tel: _watchProvider.contactTel,
        url: _watchProvider.contactURL);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Contact Bar Code'),
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
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          hint: 'Name',
                          prefixIcon: Icons.person,
                          onChanged: (value) {
                            _readProvider.getContactName(value);
                          })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField(
                          hint: 'Email',
                          prefixIcon: Icons.email,
                          onChanged: (value) {
                            _readProvider.getContactEmail(value);
                          })),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          hint: 'Tel',
                          prefixIcon: Icons.phone,
                          onChanged: (value) {
                            _readProvider.getContactTel(value);
                          })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField(
                          hint: 'Address',
                          prefixIcon: Icons.location_city,
                          onChanged: (value) {
                            _readProvider.getContactAddress(value);
                          })),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                          hint: 'URL',
                          prefixIcon: Icons.web,
                          onChanged: (value) {
                            _readProvider.getContactURL(value);
                          })),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField(
                          hint: 'Memo',
                          prefixIcon: Icons.message,
                          onChanged: (value) {
                            _readProvider.getContactMemo(value);
                          })),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          text: 'Save As An Image',
                          color: _readProvider.contactName.isEmpty
                              ? Colors.grey
                              : kPrimaryColor,
                          onPressed: () async {
                            if (_readProvider.contactName.isNotEmpty) {
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
                        color: _readProvider.contactName.isEmpty
                            ? Colors.grey
                            : kPrimaryColor,
                        onPressed: () {
                          if (_readProvider.contactName.isNotEmpty) {
                            CodeModel codeModel = CodeModel(
                                dataType: 'Contact',
                                data: me.toString(),
                                scanedOn: DateTime.now());

                            bool isSuccess = _readProvider.addToBox(codeModel);
                            isSuccess
                                ? kSnackBar(context, 'Code saved successfully')
                                : kSnackBar(context,
                                    'Uh oh, Something wrong happened!');
                          }
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
