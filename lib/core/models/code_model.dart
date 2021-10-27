import 'package:hive_flutter/hive_flutter.dart';
part 'code_model.g.dart';

@HiveType(typeId: 1)
class CodeModel extends HiveObject {
  @HiveField(0)
  String? dataType;

  @HiveField(1)
  String? data;

  @HiveField(2)
  DateTime? scanedOn;

  @HiveField(3)
  String? image;

  @HiveField(4)
  bool? isQR;

  CodeModel(
      {required this.dataType,
      required this.data,
      this.image,
      this.isQR,
      required this.scanedOn});

  CodeModel.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    data = json['data'];
    image = json['image'] ?? '';
    isQR = json['isQR'];
    scanedOn = json['scanedOn'];
  }

  toMap() {
    return {
      'dataType': dataType,
      'data': data,
      'image': image,
      'isQR' : isQR,
      'scanedOn': scanedOn
    };
  }
}
