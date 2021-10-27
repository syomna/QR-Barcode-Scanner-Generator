import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scanner/UI/pages/modules/generate/type_bar.dart';
import 'package:scanner/UI/pages/modules/history/history.dart';
import 'package:scanner/UI/pages/modules/home/home_page.dart';
import 'package:scanner/core/helper/ad_helper.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({Key? key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _currentIndex = 0;

  late BannerAd _bottomBannerAd;

  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              _isBottomBannerAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();

            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
        request: const AdRequest());

    _bottomBannerAd.load();
  }

  @override
  void initState() {
    _createBottomBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bottomBannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: [
      //   if (_isBottomBannerAdLoaded)
      //     Container(
      //       child: AdWidget(ad: _bottomBannerAd),
      //       width: _bottomBannerAd.size.width.toDouble(),
      //       height: _bottomBannerAd.size.height.toDouble(),
      //       alignment: Alignment.center,
      //     ),

      // ],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), title: Text('Sanner')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box), title: Text('Generate')),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), title: Text('History')),
          ]),
      body: _pages[_currentIndex],
    );
  }

  final List<Widget> _pages = [
    const HomePage(),
    const TypeBar(),
    const History()
  ];
}
