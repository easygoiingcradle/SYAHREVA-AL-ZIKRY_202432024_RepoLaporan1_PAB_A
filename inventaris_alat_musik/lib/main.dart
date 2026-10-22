import 'package:flutter/material.dart';
//Syahreva AL Zikry - 202432024
void main() {
  runApp(const MyApp());
}

//Syahreva Al Zikry_202432024
class AlatMusik {
  final String kodeInventaris;
  final String namaAlat;
  final String kategori;
  final String pemilikKoleksi;
  final int tahunPerolehan;
  final double skorKondisi;
  final bool siapPakai;

  const AlatMusik({
    required this.kodeInventaris,
    required this.namaAlat,
    required this.kategori,
    required this.pemilikKoleksi,
    required this.tahunPerolehan,
    required this.skorKondisi,
    required this.siapPakai,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Konstanta warna bergaya Dashboard Discord
  static const Color discordBgDark = Color(0xFF313338);
  static const Color discordCardSurface = Color(0xFF2B2D31);
  static const Color discordHeaderDark = Color(0xFF1E1F22);
  static const Color discordBlurple = Color(0xFF5865F2);
  static const Color discordGreen = Color(0xFF23A55A);
  static const Color discordYellow = Color(0xFFF0B232);
  static const Color discordTextPrimary = Color(0xFFF2F3F5);
  static const Color discordTextMuted = Color(0xFFB5BAC1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris Koleksi Alat Musik - Syahreva Al Zikry',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: discordBgDark,
        colorScheme: const ColorScheme.dark(
          primary: discordBlurple,
          secondary: discordGreen,
          surface: discordCardSurface,
          onPrimary: Colors.white,
          onSurface: discordTextPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: discordHeaderDark,
          foregroundColor: discordTextPrimary,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: discordBlurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const HalamanInventarisMusik(),
    );
  }
}


class HalamanInventarisMusik extends StatefulWidget {
  const HalamanInventarisMusik({super.key});

  @override
  State<HalamanInventarisMusik> createState() => _HalamanInventarisMusikState();
}
//Syahreva Al Zikry_202432024
class _HalamanInventarisMusikState extends State<HalamanInventarisMusik> {
  // Data inventaris koleksi alat musik (objek berisi data pribadi)
  final List<AlatMusik> _daftarKoleksi = const [
    AlatMusik(
      kodeInventaris: 'INV-MUS-001',
      namaAlat: 'Fender Stratocaster Player Series HSS',
      kategori: 'Gitar Elektrik',
      pemilikKoleksi: 'Syahreva Al Zikry (202432024)',
      tahunPerolehan: 2024,
      skorKondisi: 9.8,
      siapPakai: true,
    ), //Syahreva AL Zikry_202432024
    AlatMusik(
      kodeInventaris: 'INV-MUS-002',
      namaAlat: 'Yamaha Clavinova CLP-745 Digital Piano',
      kategori: 'Keyboard & Piano',
      pemilikKoleksi: 'Syahreva Al Zikry (202432024)',
      tahunPerolehan: 2023,
      skorKondisi: 9.5,
      siapPakai: true,
    ),
    AlatMusik(
      kodeInventaris: 'INV-MUS-003',
      namaAlat: 'Roland TD-17KVX2 V-Drums Electronic Kit',
      kategori: 'Perkusi & Drum',
      pemilikKoleksi: 'Studio Musik Kelas A - Syahreva',
      tahunPerolehan: 2022,
      skorKondisi: 8.9,
      siapPakai: false,
    ),
    AlatMusik(
      kodeInventaris: 'INV-MUS-004',
      namaAlat: 'Ibanez SR505E 5-String Soundgear Bass',
      kategori: 'Bass Elektrik',
      pemilikKoleksi: 'Syahreva Al Zikry (202432024)',
      tahunPerolehan: 2025,
      skorKondisi: 9.7,
      siapPakai: true,
    ), //Syahreva Al Zikry_202432024
  ];

  bool _hanyaSiapPakai = false;
  int _jumlahInspeksiHariIni = 3;
  String _terakhirDiperiksa = 'Fender Stratocaster Player Series HSS';

  void _ubahFilterSiapPakai() {
    setState(() {
      _hanyaSiapPakai = !_hanyaSiapPakai;
    });
  }

  void _catatInspeksiAlat(AlatMusik alat) {
    setState(() {
      _jumlahInspeksiHariIni++;
      _terakhirDiperiksa = alat.namaAlat;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MyApp.discordHeaderDark,
        content: Text(
          'Inspeksi tercatat: ${alat.namaAlat} (Kondisi ${alat.skorKondisi}/10)',
          style: const TextStyle(color: MyApp.discordTextPrimary),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double lebarLayar = MediaQuery.of(context).size.width;
    final List<AlatMusik> koleksiTampil = _hanyaSiapPakai
        ? _daftarKoleksi.where((item) => item.siapPakai).toList()
        : _daftarKoleksi;

    final int totalSiap =
        _daftarKoleksi.where((item) => item.siapPakai).length;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.headphones_rounded, color: MyApp.discordBlurple),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Discord Studio | Inventaris Alat Musik',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool layarSempit = constraints.maxWidth < 400;

            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 680,
                  child: Padding(
                    padding: EdgeInsets.all(layarSempit ? 12.0 : 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Custom Widget 1: Kartu Ringkasan Studio
                        KartuRingkasanStudio(
                          namaKurator: 'SYAHREVA AL ZIKRY',
                          nimKurator: '202432024',
                          kelasKurator: 'PAB - Kelas A',
                          totalKoleksi: _daftarKoleksi.length,
                          totalSiapPakai: totalSiap,
                          jumlahInspeksi: _jumlahInspeksiHariIni,
                          terakhirDiperiksa: _terakhirDiperiksa,
                          lebarLayar: lebarLayar,
                        ),
                        const SizedBox(height: 16),

                        // Baris Kontrol Filter
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: MyApp.discordCardSurface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF3F4147),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.tune_rounded,
                                color: MyApp.discordTextMuted,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _hanyaSiapPakai
                                      ? 'Filter Aktif: Hanya Alat Siap Pakai (${koleksiTampil.length} unit)'
                                      : 'Menampilkan Semua Koleksi (${koleksiTampil.length} unit)',
                                  style: const TextStyle(
                                    color: MyApp.discordTextPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: _ubahFilterSiapPakai,
                                icon: Icon(
                                  _hanyaSiapPakai
                                      ? Icons.filter_alt_off_rounded
                                      : Icons.filter_alt_rounded,
                                  size: 16,
                                ),
                                label: Text(
                                  _hanyaSiapPakai ? 'Semua' : 'Siap Pakai',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Daftar Kartu Koleksi Alat Musik
                        ...koleksiTampil.map(
                          (alat) => KartuKoleksiAlatMusik(
                            alat: alat,
                            onInspeksiPressed: () => _catatInspeksiAlat(alat),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//Syahreva Al Zikry
class KartuRingkasanStudio extends StatelessWidget {
  final String namaKurator;
  final String nimKurator;
  final String kelasKurator;
  final int totalKoleksi;
  final int totalSiapPakai;
  final int jumlahInspeksi;
  final String terakhirDiperiksa;
  final double lebarLayar;

  const KartuRingkasanStudio({
    super.key,
    required this.namaKurator,
    required this.nimKurator,
    required this.kelasKurator,
    required this.totalKoleksi,
    required this.totalSiapPakai,
    required this.jumlahInspeksi,
    required this.terakhirDiperiksa,
    required this.lebarLayar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5865F2), Color(0xFF3B44B1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0x731E1F22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.piano_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaKurator,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'NIM: $nimKurator | $kelasKurator',
                      style: const TextStyle(
                        color: Color(0xFFE0E3FF),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _KotakStatistikMini(
                  label: 'Total Koleksi',
                  nilai: '$totalKoleksi Unit',
                  ikon: Icons.library_music_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _KotakStatistikMini(
                  label: 'Siap Pakai',
                  nilai: '$totalSiapPakai Unit',
                  ikon: Icons.check_circle_outline_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _KotakStatistikMini(
                  label: 'Log Inspeksi',
                  nilai: '$jumlahInspeksi Kali',
                  ikon: Icons.fact_check_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Terakhir dicek: $terakhirDiperiksa (Lebar layar: ${lebarLayar.toStringAsFixed(0)} px)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFE0E3FF),
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _KotakStatistikMini extends StatelessWidget {
  final String label;
  final String nilai;
  final IconData ikon;

  const _KotakStatistikMini({
    required this.label,
    required this.nilai,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x731E1F22),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: Colors.white70, size: 16),
          const SizedBox(height: 4),
          Text(
            nilai,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFD5D9FF),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}


class KartuKoleksiAlatMusik extends StatelessWidget {
  final AlatMusik alat;
  final VoidCallback onInspeksiPressed;

  const KartuKoleksiAlatMusik({
    super.key,
    required this.alat,
    required this.onInspeksiPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color warnaStatus =
        alat.siapPakai ? MyApp.discordGreen : MyApp.discordYellow;
    final Color warnaBgStatus =
        alat.siapPakai ? const Color(0x2923A55A) : const Color(0x29F0B232);

    return Card(
      color: MyApp.discordCardSurface,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3F4147), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: MyApp.discordHeaderDark,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0x805865F2),
                    ),
                  ),
                  child: const Icon(
                    Icons.music_note_rounded,
                    color: MyApp.discordBlurple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alat.namaAlat,
                        style: const TextStyle(
                          color: MyApp.discordTextPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${alat.kodeInventaris} | ${alat.kategori} (${alat.tahunPerolehan})',
                        style: const TextStyle(
                          color: MyApp.discordTextMuted,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Pemilik: ${alat.pemilikKoleksi}',
                        style: const TextStyle(
                          color: MyApp.discordTextMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: warnaBgStatus,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: warnaStatus, width: 1),
                    ),
                    child: Text(
                      alat.siapPakai
                          ? 'Status: Ready to Play (${alat.skorKondisi}/10)'
                          : 'Status: Butuh Setup Senar/Pad (${alat.skorKondisi}/10)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: warnaStatus,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onInspeksiPressed,
                  child: const Text(
                    'Cek Alat',
                    style: TextStyle(fontSize: 12.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}