import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import 'package:scanner/UI/constants/constants.dart';
import 'package:scanner/core/models/code_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

class QRProvider extends ChangeNotifier {

  // Generate
  String _customMessage = '';
  String get customMessage => _customMessage;
  String _barCodeCustomMessage = '';
  String get barCodeCustomMessage => _barCodeCustomMessage;
  String _wifiSSID = '';
  String get wifiSSID => _wifiSSID;
  String _wifiPassword = '';
  String get wifiPassword => _wifiPassword;
  String _contactName = '';
  String get contactName => _contactName;
  String _contactEmail = ' ';
  String get contactEmail => _contactEmail;
  String _contactTel = '';
  String get contactTel => _contactTel;
  String _contactAddress = '';
  String get contactAddress => _contactAddress;
  String _contactURL = '';
  String get contactURL => _contactURL;
  String _contactMemo = '';
  String get contactMemo => _contactMemo;

  // Import Images
  final ImagePicker _picker = ImagePicker();
  File? _importedImage;
  File? get importedImage => _importedImage;

  // Scan Image
  String? _scanImage;
  String? get scanImage => _scanImage;

  // Change Mode
  bool isDarkMode = false;

  changeMode() {
    isDarkMode = !isDarkMode;
    Box myBox = Hive.box('mode');
    myBox.put('isDarkMode', isDarkMode);
    notifyListeners();
  }

  getMode() {
    if (Hive.box('mode').isNotEmpty) {
      isDarkMode = Hive.box('mode').get('isDarkMode');
    }
  }

  getCustomMessage(String value) {
    _customMessage = value;
    notifyListeners();
  }

  getBarCodeCustomMessage(String value) {
    _barCodeCustomMessage = value;
    notifyListeners();
  }

  getWifiSSID(String value) {
    _wifiSSID = value;
    notifyListeners();
  }

  getWifiPassword(String value) {
    _wifiPassword = value;
    notifyListeners();
  }

  getContactName(String value) {
    _contactName = value;
    notifyListeners();
  }

  getContactEmail(String value) {
    _contactEmail = value;
    notifyListeners();
  }

  getContactTel(String value) {
    _contactTel = value;
    notifyListeners();
  }

  getContactAddress(String value) {
    _contactAddress = value;
    notifyListeners();
  }

  getContactURL(String value) {
    _contactURL = value;
    notifyListeners();
  }

  getContactMemo(String value) {
    _contactMemo = value;
    notifyListeners();
  }

  importImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      _importedImage = File(file.path);
      notifyListeners();
    }
  }

  deleteImportedImage() {
    _importedImage = null;
    notifyListeners();
  }

  Future<bool> scanFromImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      String? result = await Scan.parse(file.path);
      if (result != null) {
        _scanImage = result;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  // Hive

  bool addToBox(CodeModel codeModel) {
    try {
      final Box myBox = Hive.box(kHiveBox);
      myBox.put(DateTime.now().microsecond, codeModel);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  bool deleteBoxData(int index) {
    try {
      final Box myBox = Hive.box(kHiveBox);
      myBox.deleteAt(index);
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveImage(ScreenshotController controller) async {
    try {
      final directory = await getExternalStorageDirectory();
      String fileName = '${DateTime.now().microsecondsSinceEpoch}.png';
      String? save =
          await controller.captureAndSave(directory!.path, fileName: fileName);
      if (save != null) {
        bool? isSaved = await GallerySaver.saveImage(save);
        if (isSaved == true) {
          print(directory);
          print(fileName);
          print(save);
          return true;
        }
      }

      //  await controller
      //       .capture(delay: const Duration(milliseconds: 10))
      //       .then((Uint8List image) async {
      //     if (image != null) {
      //       final directory = await getApplicationDocumentsDirectory();
      //       final imagePath = await File('${directory.path}/image.png').create();
      //       await imagePath.writeAsBytes(image);

      //       /// Share Plugin
      //       await Share.shareFiles([imagePath.path]);
      //     }
      //  });
      return false;
    } catch (error) {
      print('error is $error');
      return false;
    }
  }
}
