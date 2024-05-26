class CatatanModel {
  String idCapture;
  String idUser;
  String idMakanan;
  String tglCapture;
  String calories;
  String namaMakanan;
  String karbohidrat;
  String mineral;
  String protein;
  String lemak;
  String gula;
  String kalori;

  CatatanModel({
    required this.idCapture,
    required this.idUser,
    required this.idMakanan,
    required this.tglCapture,
    required this.calories,
    required this.namaMakanan,
    required this.karbohidrat,
    required this.mineral,
    required this.protein,
    required this.lemak,
    required this.gula,
    required this.kalori,
  });

  factory CatatanModel.fromJson(Map<String, dynamic> json) => CatatanModel(
    idCapture: json["id_capture"],
    idUser: json["id_user"],
    idMakanan: json["id_makanan"],
    tglCapture: json["tgl_capture"],
    calories: json["calories"],
    namaMakanan: json["nama_makanan"],
    karbohidrat: json["karbohidrat"],
    mineral: json["mineral"],
    protein: json["protein"],
    lemak: json["lemak"],
    gula: json["gula"],
    kalori: json["kalori"],
  );

  Map<String, dynamic> toJson() => {
    "id_capture": idCapture,
    "id_user": idUser,
    "id_makanan": idMakanan,
    "tgl_capture": tglCapture,
    "calories": calories,
    "nama_makanan": namaMakanan,
    "karbohidrat": karbohidrat,
    "mineral": mineral,
    "protein": protein,
    "lemak": lemak,
    "gula": gula,
    "kalori": kalori,
  };
}
