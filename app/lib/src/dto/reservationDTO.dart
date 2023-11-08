/**
 * Objeto de Transporte de Dados para as reservas.
 */
class ReservationDTO {
  late String name;
  late double lat;
  late double lon;

  ReservationDTO(this.name, this.lat, this.lon);

  factory ReservationDTO.fromJson(dynamic json) {
    return ReservationDTO(
      json['name'].toString(),
      double.parse(json['lat'].toString()),
      double.parse(json['lon'].toString()),
    );
  }

  String getName() {
    return this.name;
  }

  double getLat() {
    return this.lat;
  }

  double getLon() {
    return this.lon;
  }
}
