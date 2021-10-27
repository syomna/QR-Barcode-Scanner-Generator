import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:scanner/core/provider/qr_provider.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, this.codeModel, this.index})
      : super(key: key);

  final int? index;
  final CodeModel? codeModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        'Are you sure you want to delete it?',
        textAlign: TextAlign.center,
      ),
      actions: [
        MaterialButton(
          onPressed: () async {
            bool isSuccess = context.read<QRProvider>().deleteBoxData(index!);
            isSuccess
                ? kSnackBar(context, 'Code deleted succesfully')
                : kSnackBar(context, 'Uh oh, Something wrong happened!');

            Navigator.of(context).pop();
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.green),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
