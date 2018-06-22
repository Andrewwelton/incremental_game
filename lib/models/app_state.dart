import 'package:meta/meta.dart';

import 'company.dart';

@immutable
class AppState {
  final int count;
  final Company company;
  
  AppState({
    this.count = 0,
    this.company
  });

  AppState copyWith({ int count, Company company }) {
    return new AppState(
      count: count ?? this.count,
      company: company ?? this.company
    );
  }

  static AppState fromJson(dynamic json) {
    print(json.toString());
    return new AppState(
      count: json['count'],
      company: Company.fromJson(json['company'])
    );
  }

  Map toJson() => {
    'count': count,
    'company': company
  };
}
