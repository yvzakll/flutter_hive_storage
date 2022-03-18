import 'package:hive_flutter/adapters.dart';
part 'ogrenci.g.dart';

@HiveType(typeId: 1)
class Ogrenci {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String isim;
  @HiveField(2)
  final GozRenk gozRengi;

  Ogrenci(this.id, this.isim, this.gozRengi);

  @override
  String toString() {
    // TODO: implement toString
    return "$id - $isim - $gozRengi";
  }
}

@HiveType(typeId: 2)
enum GozRenk {
  @HiveField(0)
  SIYAH,
  @HiveField(1)
  MAVI,
  @HiveField(2)
  YESIL
}
