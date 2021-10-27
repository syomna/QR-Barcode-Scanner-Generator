import 'package:flutter/material.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/UI/pages/modules/generate/generate_barcode.dart';
import 'package:scanner/UI/pages/modules/generate/generate_qrcode.dart';

class TypeBar extends StatefulWidget {
  const TypeBar({Key? key}) : super(key: key);

  @override
  State<TypeBar> createState() => _TypeBarState();
}

class _TypeBarState extends State<TypeBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _currentIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title[_currentIndex]),
          bottom: TabBar(
              labelPadding: const EdgeInsets.only(bottom: 10),
              indicatorColor: kPrimaryColor,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              tabs: const [Text('QR Code'), Text('Bar Code')]),
        ),
        body: _pages[_currentIndex],
      ),
    );
  }

  final List<String> _title = ['Generate QR Code', 'Generate Bar Code'];

  final List<Widget> _pages = [
    GenerateQRCode(),
    const GenerateBarCode(),
  ];
}
