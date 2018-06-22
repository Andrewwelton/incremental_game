class Staff {
  final String name;
  double linesOfCodeProduced;
  double cost;

  Staff({
    this.name = '',
    this.linesOfCodeProduced = 0.0,
    this.cost = 0.0
  });

  Staff copyWith({
    String name,
    double linesOfCodeProduced,
    double cost,
  }) {
    return new Staff(
      name: name ?? this.name,
      linesOfCodeProduced: linesOfCodeProduced ?? this.linesOfCodeProduced,
      cost: cost ?? this.cost
    );
  }

  static Staff fromJson(dynamic json) {
    return new Staff(
      name: json['name'],
      linesOfCodeProduced: json['linesOfCodeProduced'],
      cost: json['cost']
    );
  }

  Map toJson() => {
    'name': name,
    'linesOfCodeProduced': linesOfCodeProduced,
    'cost': cost
  };

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is Staff &&
      this.name == other.name;
  
  @override
    int get hashCode => super.hashCode;
}