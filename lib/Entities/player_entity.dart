// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlayerEntity {
  final String id;
  final String name;
  final int points;
  final bool selected;

  PlayerEntity({
    required this.id,
    required this.name,
    required this.points,
    required this.selected,
  });

  PlayerEntity copyWith({
    String? id,
    String? name,
    int? points,
    bool? selected,
  }) {
    return PlayerEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      selected: selected ?? this.selected,
    );
  }

  @override
  String toString() {
    return 'PlayerEntity(id: $id, name: $name, points: $points, selected: $selected)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'points': points,
      'selected': selected,
    };
  }

  factory PlayerEntity.fromMap(Map<String, dynamic> map) {
    return PlayerEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      points: map['points'] as int,
      selected: map['selected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerEntity.fromJson(String source) => PlayerEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant PlayerEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.points == points && other.selected == selected;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ points.hashCode ^ selected.hashCode;
  }
}
