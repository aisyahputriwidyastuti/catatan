class Catatan {
  String judul;
  String isi;
  DateTime tglInput;

  Catatan({required this.judul, required this.isi}) : tglInput = DateTime.now();
}
