import 'package:flutter/material.dart';
import '../models/alat.dart';

class PengaturPinjam extends StatefulWidget {
  final Alat alat;
  final VoidCallback onChanged;

  const PengaturPinjam({
    super.key,
    required this.alat,
    required this.onChanged,
  });

  @override
  State<PengaturPinjam> createState() =>
      _PengaturPinjamState();
}

class _PengaturPinjamState
    extends State<PengaturPinjam> {
  int jumlah = 0;
  bool sedangMemproses = false;

  void _tambah() {
    if (jumlah < widget.alat.hitungTersedia()) {
      setState(() {
        jumlah++;
      });
    }
  }

  void _kurang() {
    if (jumlah > 0) {
      setState(() {
        jumlah--;
      });
    }
  }

  Future<void> _pinjam() async {
    if (jumlah <= 0) {
      _pesan(
        'Pilih jumlah alat terlebih dahulu.',
      );
      return;
    }

    if (!widget.alat.bisaDipinjam()) {
      _pesan(
        'Alat tidak dapat dipinjam.',
      );
      return;
    }

    if (jumlah > widget.alat.hitungTersedia()) {
      _pesan(
        'Jumlah melebihi alat yang tersedia.',
      );
      return;
    }

    final int jumlahPinjam = jumlah;

    setState(() {
      sedangMemproses = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 250),
    );

    final berhasil =
        widget.alat.pinjam(jumlahPinjam);

    if (!mounted) return;

    setState(() {
      sedangMemproses = false;

      if (berhasil) {
        jumlah = 0;
      }
    });

    if (berhasil) {
      widget.onChanged();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            '$jumlahPinjam alat berhasil dipinjam.',
          ),
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              const Color(0xFF1E293B),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(14),
          ),
        ),
      );
    } else {
      _pesan(
        'Peminjaman tidak dapat dilakukan.',
      );
    }
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior:
            SnackBarBehavior.floating,
        backgroundColor:
            const Color(0xFF1E293B),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool rusak =
        widget.alat.kondisi
                .toLowerCase() ==
            'rusak';

    final bool tersedia =
        widget.alat.hitungTersedia() > 0 &&
            !rusak;

    return Row(
      children: [
        // ==========================================
        // JUMLAH
        // ==========================================

        Container(
          height: 52,

          decoration: BoxDecoration(
            color:
                const Color(0xFFF8FAFC),

            borderRadius:
                BorderRadius.circular(17),

            border: Border.all(
              color:
                  const Color(0xFFE2E8F0),
            ),
          ),

          child: Row(
            mainAxisSize:
                MainAxisSize.min,

            children: [
              SizedBox(
                width: 43,
                height: 52,

                child: IconButton(
                  onPressed:
                      jumlah > 0
                          ? _kurang
                          : null,

                  icon: const Icon(
                    Icons.remove_rounded,
                    size: 19,
                  ),

                  color:
                      const Color(0xFF64748B),
                  disabledColor:
                      const Color(0xFFCBD5E1),
                ),
              ),

              SizedBox(
                width: 31,

                child: Center(
                  child: Text(
                    '$jumlah',
                    style:
                        const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w900,
                      color:
                          Color(0xFF172033),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 43,
                height: 52,

                child: IconButton(
                  onPressed:
                      tersedia &&
                              jumlah <
                                  widget.alat
                                      .hitungTersedia()
                          ? _tambah
                          : null,

                  icon: const Icon(
                    Icons.add_rounded,
                    size: 20,
                  ),

                  color:
                      const Color(0xFF334155),

                  disabledColor:
                      const Color(0xFFCBD5E1),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 11),

        // ==========================================
        // TOMBOL PINJAM
        // ==========================================

        Expanded(
          child: SizedBox(
            height: 52,

            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF4F46E5),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(17),

                boxShadow: [
                  BoxShadow(
                    color:
                        const Color(0xFF4F46E5)
                            .withOpacity(0.22),
                    blurRadius: 14,
                    offset:
                        const Offset(0, 6),
                  ),
                ],
              ),

              child: ElevatedButton(
                onPressed:
                    tersedia &&
                            !sedangMemproses
                        ? _pinjam
                        : null,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent,
                  disabledBackgroundColor:
                      const Color(0xFFE2E8F0),
                  shadowColor:
                      Colors.transparent,
                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      17,
                    ),
                  ),
                ),

                child: sedangMemproses
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2.3,
                          color:
                              Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          const Icon(
                            Icons
                                .shopping_bag_outlined,
                            size: 21,
                            color:
                                Colors.white,
                          ),

                          const SizedBox(
                            width: 9,
                          ),

                          Text(
                            rusak
                                ? 'Tidak tersedia'
                                : 'Pinjam',

                            style:
                                const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w900,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}