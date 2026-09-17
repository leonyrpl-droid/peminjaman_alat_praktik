import 'package:flutter/material.dart';
import '../models/alat.dart';
import '../widgets/alat_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // =====================================================
  // CONTROLLER PENCARIAN
  // Dibuat di initState sesuai struktur tugas
  // =====================================================

  late TextEditingController _controller;

  // =====================================================
  // DATA ALAT
  // =====================================================

  final List<Alat> daftarAlat = [
    Alat(
      namaAlat: 'Obeng Set',
      kodeAlat: 'ALT-014',
      kondisi: 'Baik',
      jumlahTotal: 12,
      jumlahDipinjam: 5,
    ),
    Alat(
      namaAlat: 'Multimeter Digital',
      kodeAlat: 'ALT-021',
      kondisi: 'Baik',
      jumlahTotal: 8,
      jumlahDipinjam: 2,
    ),
    Alat(
      namaAlat: 'Bor Tangan',
      kodeAlat: 'ALT-032',
      kondisi: 'Perlu Perbaikan',
      jumlahTotal: 6,
      jumlahDipinjam: 2,
    ),
    Alat(
      namaAlat: 'Tang Kombinasi',
      kodeAlat: 'ALT-007',
      kondisi: 'Baik',
      jumlahTotal: 15,
      jumlahDipinjam: 4,
    ),
    Alat(
      namaAlat: 'Solder Listrik',
      kodeAlat: 'ALT-018',
      kondisi: 'Perlu Perbaikan',
      jumlahTotal: 10,
      jumlahDipinjam: 3,
    ),
    Alat(
      namaAlat: 'Gerinda Tangan',
      kodeAlat: 'ALT-027',
      kondisi: 'Rusak',
      jumlahTotal: 5,
      jumlahDipinjam: 0,
    ),
    Alat(
      namaAlat: 'Kunci Inggris',
      kodeAlat: 'ALT-011',
      kondisi: 'Baik',
      jumlahTotal: 9,
      jumlahDipinjam: 1,
    ),
    Alat(
      namaAlat: 'Tespen Digital',
      kodeAlat: 'ALT-024',
      kondisi: 'Baik',
      jumlahTotal: 14,
      jumlahDipinjam: 6,
    ),
    Alat(
      namaAlat: 'Jangka Sorong',
      kodeAlat: 'ALT-040',
      kondisi: 'Baik',
      jumlahTotal: 7,
      jumlahDipinjam: 3,
    ),
    Alat(
      namaAlat: 'Kunci T',
      kodeAlat: 'ALT-045',
      kondisi: 'Perlu Perbaikan',
      jumlahTotal: 11,
      jumlahDipinjam: 2,
    ),
  ];

  // =====================================================
  // F2 - SARING KATEGORI / KONDISI
  // =====================================================

  String kategoriDipilih = 'Semua';

  final List<String> kategori = [
    'Semua',
    'Baik',
    'Perlu Perbaikan',
    'Rusak',
  ];

  // =====================================================
  // INIT STATE
  // =====================================================

  @override
  void initState() {
    super.initState();

    // Controller dibuat di initState
    _controller = TextEditingController();

    // Ketika isi pencarian berubah,
    // tampilan akan diperbarui
    _controller.addListener(() {
      setState(() {});
    });
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // =====================================================
  // DATA HASIL PENCARIAN + FILTER
  // =====================================================

  List<Alat> get alatTersaring {
    final kata =
        _controller.text.trim().toLowerCase();

    return daftarAlat.where((alat) {
      // Pencarian nama atau kode
      final cocokPencarian =
          kata.isEmpty ||
          alat.namaAlat
              .toLowerCase()
              .contains(kata) ||
          alat.kodeAlat
              .toLowerCase()
              .contains(kata);

      // F2 - filter kondisi
      final cocokKategori =
          kategoriDipilih == 'Semua' ||
          alat.kondisi.toLowerCase() ==
              kategoriDipilih.toLowerCase();

      return cocokPencarian &&
          cocokKategori;
    }).toList();
  }

  // =====================================================
  // PILIH KATEGORI
  // =====================================================

  void _pilihKategori(String kategoriBaru) {
    setState(() {
      kategoriDipilih = kategoriBaru;
    });
  }

  // =====================================================
  // IKON KATEGORI
  // =====================================================

  IconData _ikonKategori(String item) {
    switch (item) {
      case 'Baik':
        return Icons.check_circle_rounded;

      case 'Perlu Perbaikan':
        return Icons.build_circle_rounded;

      case 'Rusak':
        return Icons.cancel_rounded;

      default:
        return Icons.apps_rounded;
    }
  }

  // =====================================================
  // WARNA KATEGORI
  // =====================================================

  Color _warnaKategori(String item) {
    switch (item) {
      case 'Baik':
        return const Color(0xFF16A34A);

      case 'Perlu Perbaikan':
        return const Color(0xFFF59E0B);

      case 'Rusak':
        return const Color(0xFFDC2626);

      default:
        return const Color(0xFF4F46E5);
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title: const Text(
          'Inventaris Alat Praktik',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: false,
      ),

      // =================================================
      // BODY: COLUMN
      // =================================================

      body: Column(
        children: [

          // =================================================
          // TEXTFIELD
          // Controller dibuat di initState
          // =================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              16,
              18,
              10,
            ),
            child: TextField(
              controller: _controller,

              decoration: InputDecoration(
                hintText:
                    'Cari nama atau kode alat...',

                prefixIcon: const Icon(
                  Icons.search_rounded,
                ),

                suffixIcon:
                    _controller.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _controller.clear();
                            },
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          )
                        : null,

                filled: true,
                fillColor: Colors.white,

                contentPadding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),

                enabledBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2E8F0),
                  ),
                ),

                focusedBorder:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFF4F46E5),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // =================================================
          // F2 - SARING KATEGORI
          // =================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Row(
              children: [

                const Icon(
                  Icons.filter_list_rounded,
                  color: Color(0xFF4F46E5),
                  size: 22,
                ),

                const SizedBox(width: 8),

                const Text(
                  'Saring Kategori',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF172033),
                  ),
                ),

                const Spacer(),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${alatTersaring.length} alat',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // =================================================
          // PILIHAN KATEGORI F2
          // =================================================

          SizedBox(
            height: 44,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              scrollDirection: Axis.horizontal,

              itemCount: kategori.length,

              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),

              itemBuilder: (context, index) {
                final item = kategori[index];

                final aktif =
                    kategoriDipilih == item;

                final warna =
                    _warnaKategori(item);

                return FilterChip(
                  selected: aktif,

                  onSelected: (_) {
                    _pilihKategori(item);
                  },

                  avatar: Icon(
                    _ikonKategori(item),
                    size: 17,
                    color: aktif
                        ? warna
                        : const Color(
                            0xFF64748B,
                          ),
                  ),

                  label: Text(item),

                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: aktif
                        ? warna
                        : const Color(
                            0xFF475569,
                          ),
                  ),

                  backgroundColor:
                      const Color(0xFFF8FAFC),

                  selectedColor:
                      warna.withOpacity(0.10),

                  checkmarkColor: warna,

                  side: BorderSide(
                    color: aktif
                        ? warna
                        : const Color(
                            0xFFDDE4EF,
                          ),
                    width: aktif ? 1.5 : 1,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // =================================================
          // EXPANDED
          //     └── LAYOUTBUILDER
          //           └── GRIDVIEW.BUILDER
          // =================================================

          Expanded(
            child: LayoutBuilder(
              builder:
                  (context, constraints) {

                // Menentukan jumlah kolom
                final jumlahKolom =
                    constraints.maxWidth < 600
                        ? 1
                        : constraints.maxWidth < 900
                            ? 2
                            : 3;

                // =========================================
                // JIKA DATA KOSONG
                // =========================================

                if (alatTersaring.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [

                        Container(
                          width: 75,
                          height: 75,
                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFFEEF2FF,
                            ),
                            borderRadius:
                                BorderRadius.circular(
                              22,
                            ),
                          ),
                          child: const Icon(
                            Icons
                                .inventory_2_outlined,
                            size: 38,
                            color:
                                Color(0xFF6366F1),
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        const Text(
                          'Alat tidak ditemukan',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.w800,
                            color:
                                Color(0xFF475569),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        const Text(
                          'Coba kata kunci atau kategori lain',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // =========================================
                // GRIDVIEW.BUILDER
                // =========================================

                return GridView.builder(
                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    6,
                    18,
                    25,
                  ),

                  itemCount:
                      alatTersaring.length,

                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        jumlahKolom,

                    crossAxisSpacing: 16,

                    mainAxisSpacing: 16,

                    // Tinggi kartu
                    mainAxisExtent: 365,
                  ),

                  itemBuilder:
                      (context, index) {

                    // Ambil data dari daftar
                    final alat =
                        alatTersaring[index];

                    // ===================================
                    // NAMA KARTU = AlatCard
                    // StatelessWidget
                    // ===================================

                    return AlatCard(
                      alat: alat,

                      nama: alat.namaAlat,

                      // Ketika peminjaman berubah,
                      // HomePage diperbarui
                      onChanged: () {
                        setState(() {});
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}