import 'package:flutter/material.dart';
import '../models/alat.dart';
import 'pengaturan_pinjam.dart';

class AlatCard extends StatelessWidget {
  final Alat alat;
  final String nama;
  final VoidCallback onChanged;

  const AlatCard({
    super.key,
    required this.alat,
    required this.nama,
    required this.onChanged,
  });

  // ============================================================
  // WARNA STATUS
  // ============================================================

  Color get warnaStatus {
    switch (alat.kondisi.toLowerCase()) {
      case 'baik':
        return const Color(0xFF16A34A);

      case 'perlu perbaikan':
        return const Color(0xFFF59E0B);

      case 'rusak':
        return const Color(0xFFDC2626);

      default:
        return const Color(0xFF6366F1);
    }
  }

  Color get warnaMuda {
    switch (alat.kondisi.toLowerCase()) {
      case 'baik':
        return const Color(0xFFE9FFF3);

      case 'perlu perbaikan':
        return const Color(0xFFFFF7E6);

      case 'rusak':
        return const Color(0xFFFFEEEE);

      default:
        return const Color(0xFFF1F3FF);
    }
  }

  IconData get ikonStatus {
    switch (alat.kondisi.toLowerCase()) {
      case 'baik':
        return Icons.check_circle_rounded;

      case 'perlu perbaikan':
        return Icons.build_circle_rounded;

      case 'rusak':
        return Icons.cancel_rounded;

      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tersedia = alat.hitungTersedia();

    final rusak =
        alat.kondisi.toLowerCase() == 'rusak';

    return TweenAnimationBuilder<double>(
      duration:
          const Duration(milliseconds: 400),

      curve:
          Curves.easeOutCubic,

      tween: Tween<double>(
        begin: 0.97,
        end: 1.0,
      ),

      builder: (
        context,
        scale,
        child,
      ) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(28),

          border: Border.all(
            color: const Color(0xFFDCE3FF),
            width: 1.2,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  const Color(0xFF6366F1)
                      .withOpacity(0.09),
              blurRadius: 25,
              offset:
                  const Offset(0, 12),
            ),
          ],
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(10),

          child: Container(
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(
                begin:
                    Alignment.topLeft,
                end:
                    Alignment.bottomRight,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFBFCFF),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(23),

              border: Border.all(
                color:
                    const Color(0xFFE8ECFF),
                width: 1,
              ),
            ),

            child: Stack(
              children: [

                // ==================================================
                // DEKORASI SUDUT KANAN ATAS
                // ==================================================

                Positioned(
                  right: -35,
                  top: -35,

                  child: Container(
                    width: 115,
                    height: 115,

                    decoration:
                        BoxDecoration(
                      shape:
                          BoxShape.circle,

                      color:
                          const Color(
                        0xFFEEF1FF,
                      ),
                    ),
                  ),
                ),

                // ==================================================
                // DEKORASI SUDUT KIRI BAWAH
                // ==================================================

                Positioned(
                  left: -32,
                  bottom: -40,

                  child: Container(
                    width: 100,
                    height: 100,

                    decoration:
                        BoxDecoration(
                      shape:
                          BoxShape.circle,

                      color:
                          const Color(
                        0xFFF3F5FF,
                      ),
                    ),
                  ),
                ),

                // ==================================================
                // ISI KARTU
                // ==================================================

                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    18,
                    17,
                    18,
                    17,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // ==================================================
                      // HEADER ALAT
                      // ==================================================

                      Row(
                        children: [

                          // ICON ALAT
                          Container(
                            width: 66,
                            height: 66,

                            decoration:
                                BoxDecoration(
                              gradient:
                                  LinearGradient(
                                begin:
                                    Alignment.topLeft,
                                end:
                                    Alignment.bottomRight,

                                colors: [
                                  warnaMuda,
                                  Colors.white,
                                ],
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                21,
                              ),

                              border:
                                  Border.all(
                                color:
                                    warnaStatus
                                        .withOpacity(
                                  0.12,
                                ),
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color:
                                      warnaStatus
                                          .withOpacity(
                                    0.08,
                                  ),
                                  blurRadius:
                                      12,
                                  offset:
                                      const Offset(
                                    0,
                                    5,
                                  ),
                                ),
                              ],
                            ),

                            child: Icon(
                              Icons
                                  .handyman_rounded,
                              color:
                                  warnaStatus,
                              size: 32,
                            ),
                          ),

                          const SizedBox(
                            width: 14,
                          ),

                          // NAMA DAN KODE
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                  nama,

                                  maxLines: 1,

                                  overflow:
                                      TextOverflow
                                          .ellipsis,

                                  style:
                                      const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.w900,
                                    color:
                                        Color(
                                      0xFF172033,
                                    ),
                                    letterSpacing:
                                        -0.5,
                                  ),
                                ),

                                const SizedBox(
                                  height: 7,
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xFFF0F2FF,
                                    ),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      9,
                                    ),
                                  ),

                                  child: Row(
                                    mainAxisSize:
                                        MainAxisSize
                                            .min,

                                    children: [

                                      const Icon(
                                        Icons
                                            .qr_code_2_rounded,
                                        size: 14,
                                        color:
                                            Color(
                                          0xFF6366F1,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 5,
                                      ),

                                      Text(
                                        alat.kodeAlat,

                                        style:
                                            const TextStyle(
                                          color:
                                              Color(
                                            0xFF6366F1,
                                          ),
                                          fontSize:
                                              11,
                                          fontWeight:
                                              FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          // INDIKATOR STATUS
                          Container(
                            width: 14,
                            height: 14,

                            decoration:
                                BoxDecoration(
                              color:
                                  warnaStatus,
                              shape:
                                  BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                  color:
                                      warnaStatus
                                          .withOpacity(
                                    0.28,
                                  ),
                                  blurRadius:
                                      11,
                                  spreadRadius:
                                      2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 17,
                      ),

                      // ==================================================
                      // BADGE KONDISI
                      // ==================================================

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 13,
                          vertical: 9,
                        ),

                        decoration:
                            BoxDecoration(
                          color:
                              warnaMuda,

                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),

                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            Icon(
                              ikonStatus,
                              size: 17,
                              color:
                                  warnaStatus,
                            ),

                            const SizedBox(
                              width: 7,
                            ),

                            Text(
                              alat.kondisi,

                              style:
                                  TextStyle(
                                color:
                                    warnaStatus,
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // ==================================================
                      // STATISTIK
                      // ==================================================

                      Row(
                        children: [

                          _StatBox(
                            icon:
                                Icons
                                    .inventory_2_rounded,
                            value:
                                alat.jumlahTotal,
                            label:
                                'Total',
                            color:
                                const Color(
                              0xFF6366F1,
                            ),
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          _StatBox(
                            icon:
                                Icons
                                    .person_rounded,
                            value:
                                alat.jumlahDipinjam,
                            label:
                                'Dipinjam',
                            color:
                                const Color(
                              0xFFF59E0B,
                            ),
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          _StatBox(
                            icon:
                                Icons
                                    .check_circle_rounded,
                            value:
                                tersedia,
                            label:
                                'Tersedia',
                            color:
                                const Color(
                              0xFF10B981,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // ==================================================
                      // PEMINJAMAN
                      // ==================================================

                      if (rusak)
                        _RusakPanel()

                      else
                        SizedBox(
                          height: 54,

                          child:
                              PengaturPinjam(
                            key:
                                ValueKey(
                              '${alat.kodeAlat}-${alat.jumlahDipinjam}',
                            ),

                            alat:
                                alat,

                            onChanged:
                                onChanged,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// ================================================================
// STATISTIK BOX
// ================================================================

class _StatBox extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color color;

  const _StatBox({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(
      BuildContext context) {
    return Expanded(
      child: Container(
        height: 92,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 7,
        ),

        decoration:
            BoxDecoration(
          color:
              const Color(0xFFF8FAFF),

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color:
                const Color(0xFFE3E8F2),
          ),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          mainAxisSize:
              MainAxisSize.min,

          children: [

            // ICON
            Container(
              width: 30,
              height: 30,

              decoration:
                  BoxDecoration(
                color:
                    color.withOpacity(
                  0.10,
                ),

                shape:
                    BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 16,
                color: color,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            // ANGKA
            Text(
              '$value',

              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w900,
                color:
                    Color(0xFF172033),
                height: 1,
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            // GARIS
            Container(
              width: 42,
              height: 4,

              decoration:
                  BoxDecoration(
                color: color,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
            ),

            const SizedBox(
              height: 4,
            ),

            // LABEL
            Text(
              label,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style:
                  const TextStyle(
                fontSize: 9,
                fontWeight:
                    FontWeight.w700,
                color:
                    Color(0xFF64748B),
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ================================================================
// PANEL ALAT RUSAK
// ================================================================

class _RusakPanel extends StatelessWidget {
  const _RusakPanel();

  @override
  Widget build(
      BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,

      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFFFFF3F4),
            Color(0xFFFFE8EA),
          ],
        ),

        borderRadius:
            BorderRadius.circular(17),

        border: Border.all(
          color:
              const Color(0xFFFDA4AF),
          width: 1,
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Container(
            width: 30,
            height: 30,

            decoration:
                const BoxDecoration(
              color:
                  Color(0xFFFFDADD),
              shape:
                  BoxShape.circle,
            ),

            child: const Icon(
              Icons.block_rounded,
              size: 17,
              color:
                  Color(0xFFDC2626),
            ),
          ),

          const SizedBox(
            width: 9,
          ),

          const Text(
            'Tidak dapat dipinjam',

            style: TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w900,
              color:
                  Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }
}