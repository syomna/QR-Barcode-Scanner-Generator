import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/modules/history/details.dart';
import 'package:scanner/UI/widgets/custom_alert_dialog.dart';
import 'package:scanner/core/models/code_model.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(kHiveBox).listenable(),
        builder: (context, Box box, widget) => box.isEmpty
            ? const Center(
                child: Text(
                  'Oh, your history is Empty!\nTry to save some bar codes!',
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  CodeModel codeModel = box.getAt(index) as CodeModel;

                  return ListTile(
                    onTap: () => navigateTo(
                        context,
                        Details(
                          codeModel: codeModel,
                          index: index,
                        )),
                    title: Text('Bar Code Type: ${codeModel.dataType}'),
                    subtitle: Text(
                        '${DateFormat.jm().format(codeModel.scanedOn!)} | ${DateFormat.yMd().format(codeModel.scanedOn!)}'),
                    leading: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                    index: index,
                                  ));
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        )),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: box.length),
      ),
    );
  }
}
