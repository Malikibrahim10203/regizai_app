import 'package:equatable/equatable.dart';

class JournalLogEntity extends Equatable {
  final String idCapture;
  final String idUser;
  final String namaMakanan;
  final String cal;
  final String tglCapture;

  const JournalLogEntity({
    required this.idCapture,
    required this.idUser,
    required this.namaMakanan,
    required this.cal,
    required this.tglCapture,
  });

  @override
  List<Object?> get props => [idCapture, idUser, namaMakanan, cal, tglCapture];
}
