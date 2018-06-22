import 'staff.dart';

class Company {
  final String companyName;
  final String ceoName;
  List<Staff> currentStaff;
  double currentLinesOfCode;
  double linesOfCodeProducedPerTick;
  double companyCash;

  Company({
    this.companyName = '',
    this.ceoName = '',
    this.currentStaff = const [],
    this.currentLinesOfCode = 0.0,
    this.linesOfCodeProducedPerTick = 0.0,
    this.companyCash = 0.0
  });

  Company copyWith({ 
    String companyName,
    String ceoName,
    List<Staff> currentStaff,
    double currentLinesOfCode,
    double linesOfCodeProducedPerTick,
    double companyCash
  }) {
    return new Company(
      companyName: companyName ?? this.companyName,
      ceoName: ceoName ?? this.ceoName,
      currentStaff: currentStaff ?? this.currentStaff,
      currentLinesOfCode: currentLinesOfCode ?? this.currentLinesOfCode,
      linesOfCodeProducedPerTick: linesOfCodeProducedPerTick ?? this.linesOfCodeProducedPerTick,
      companyCash: companyCash ?? this.companyCash
    );
  }

  static Company fromJson(dynamic json) {
    return new Company(
      companyName: json['companyName'],
      ceoName: json['ceoName'],
      currentStaff: json['currentStaff'],
      currentLinesOfCode: json['currentLinesOfCode'],
      linesOfCodeProducedPerTick: json['linesOfCodeProducedPerTick'],
      companyCash: json['companyCash']
    );
  }

  Map toJson() => {
    'companyName': companyName,
    'ceoName': ceoName,
    'currentStaff': currentStaff,
    'currentLinesOfCode': currentLinesOfCode,
    'linesOfCodeProducedPerTick': linesOfCodeProducedPerTick,
    'companyCash': companyCash
  };
}