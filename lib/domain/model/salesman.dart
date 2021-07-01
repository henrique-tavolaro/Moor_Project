class Salesman {

  final String id;
  final String name;
  final String subsidiary;

  const Salesman({
    required this.id,
    required this.name,
    required this.subsidiary,
  });

  Salesman copyWith({
    required String id,
    required String name,
    required String subsidiary,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (subsidiary == null || identical(subsidiary, this.subsidiary))) {
      return this;
    }

    return new Salesman(
      id: id,
      name: name,
      subsidiary: subsidiary
    );
  }

  @override
  String toString() {
    return 'Salesman{id: $id, name: $name, subsidiary: $subsidiary}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Salesman &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          subsidiary == other.subsidiary);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ subsidiary.hashCode;

  factory Salesman.fromMap(Map<String, dynamic> map) {
    return new Salesman(
      id: map['id'] as String,
      name: map['name'] as String,
      subsidiary: map['subsidiary'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'subsidiary': this.subsidiary,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}