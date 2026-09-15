import 'package:regizai/features/journal/domain/entities/journal_log_entity.dart';

class JournalLogModel extends JournalLogEntity {
  const JournalLogModel({
    required super.idCapture,
    required super.idUser,
    required super.namaMakanan,
    required super.cal,
    required super.tglCapture,
  });

  factory JournalLogModel.fromJson(Map<String, dynamic> json) => JournalLogModel(
        idCapture: json["id_capture"] ?? "",
        idUser: json["id_user"] ?? "",
        namaMakanan: json["nama_makanan"] ?? "",
        cal: json["cal"] ?? "0",
        tglCapture: json["tgl_capture"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id_capture": idCapture,
        "id_user": idUser,
        "nama_makanan": namaMakanan,
        "cal": cal,
        "tgl_capture": tglCapture,
      };
}
