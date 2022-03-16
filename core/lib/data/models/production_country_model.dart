import 'package:equatable/equatable.dart';

class ProductionCountryModel extends Equatable {
  const ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  final String? iso31661;
  final String? name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) => ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
    };

  @override
  List<Object?> get props => [iso31661, name];
}