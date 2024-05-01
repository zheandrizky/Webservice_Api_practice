import 'dart:convert';

void main() {
  // Data transkrip mahasiswa dalam format JSON
  String jsonTranskrip = '''
  {
    "nama": "Siti Rahmawati",
    "nim": "987654321",
    "program_studi": "Akuntansi",
    "semester_terakhir": 8,
    "mata_kuliah": [
      {
        "kode": "AK101",
        "nama": "Dasar Akuntansi",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kode": "AK102",
        "nama": "Akuntansi Keuangan",
        "sks": 3,
        "nilai": "B+"
      },
      {
        "kode": "AK103",
        "nama": "Akuntansi Manajemen",
        "sks": 3,
        "nilai": "A-"
      },
      {
        "kode": "AK104",
        "nama": "Akuntansi Perpajakan",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kode": "AK105",
        "nama": "Audit Akuntansi",
        "sks": 3,
        "nilai": "A"
      },
      {
        "kode": "MKU106",
        "nama": "Pancasila",
        "sks": 2,
        "nilai": "A"
      }
    ]
  }
  ''';

  // Konversi JSON ke map
  Map<String, dynamic> transkrip = jsonDecode(jsonTranskrip);

  // Hitung total SKS dan total bobot nilai
  int totalSKS = 0;
  double totalBobotNilai = 0;

  for (var mataKuliah in transkrip['mata_kuliah']) {
    int sks = mataKuliah['sks'];
    totalSKS += sks;

    String nilai = mataKuliah['nilai'];
    double bobotNilai = nilaiToBobot(nilai);
    totalBobotNilai += bobotNilai * sks;
  }

  // Hitung IPK
  double ipk = totalBobotNilai / totalSKS;
  print(
      'IPK ${transkrip['nama']} (${transkrip['nim']}) pada semester ${transkrip['semester_terakhir']} adalah: ${ipk.toStringAsFixed(2)}');
}

// Fungsi untuk mengonversi nilai menjadi bobot nilai
double nilaiToBobot(String nilai) {
  switch (nilai) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    // Tambahkan case untuk nilai lainnya jika diperlukan
    default:
      return 0.0;
  }
}
