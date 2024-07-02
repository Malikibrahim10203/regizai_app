class CatatanModel {
  String idCapture;
  String idUser;
  String namaMakanan;
  String cal;
  String tglCapture;

  CatatanModel({
    required this.idCapture,
    required this.idUser,
    required this.namaMakanan,
    required this.cal,
    required this.tglCapture,
  });

  factory CatatanModel.fromJson(Map<String, dynamic> json) => CatatanModel(
    idCapture: json["id_capture"],
    idUser: json["id_user"],
    namaMakanan: json["nama_makanan"],
    cal: json["cal"],
    tglCapture: json["tgl_capture"],
  );

  Map<String, dynamic> toJson() => {
    "id_capture": idCapture,
    "id_user": idUser,
    "nama_makanan": namaMakanan,
    "cal": cal,
    "tgl_capture": tglCapture,
  };
}
