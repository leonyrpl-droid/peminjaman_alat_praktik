class Alat {
  final String namaAlat;
  final String kodeAlat;
  final String kondisi;
  final int jumlahTotal;

  int jumlahDipinjam;

  Alat({
    required this.namaAlat,
    required this.kodeAlat,
    required this.kondisi,
    required this.jumlahTotal,
    required this.jumlahDipinjam,
  });

  int hitungTersedia() {
    return jumlahTotal - jumlahDipinjam;
  }

  bool bisaDipinjam() {
    if (kondisi.toLowerCase() == 'rusak') {
      return false;
    }

    if (hitungTersedia() <= 0) {
      return false;
    }

    return true;
  }

  bool pinjam(int jumlah) {
    if (jumlah <= 0) {
      return false;
    }

    if (kondisi.toLowerCase() == 'rusak') {
      return false;
    }

    if (jumlah > hitungTersedia()) {
      return false;
    }

    jumlahDipinjam += jumlah;
    return true;
  }

  void kembalikan(int jumlah) {
    if (jumlah <= 0) {
      return;
    }

    jumlahDipinjam -= jumlah;

    if (jumlahDipinjam < 0) {
      jumlahDipinjam = 0;
    }
  }
}