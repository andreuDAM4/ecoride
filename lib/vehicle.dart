import 'gps_location.dart';
import 'user.dart';

abstract class Vehicle with GPSLocation {
  String id;
  int bateriaPercentatge;
  bool enUs = false;
  double preuPerMinut;

  Vehicle({
    required this.id,
    required this.bateriaPercentatge,
    required this.preuPerMinut,
    required double lat,
    required double lng,
  }) {
    actualitzarUbicacio(lat, lng);
  }

  // switch expression segons el percentatge de bateria
  String estatBateria() {
    return switch (bateriaPercentatge) {
      >= 80 => 'Alta',
      >= 20 && <= 79 => 'Mitjana',
      _ => 'Crítica (Requereix càrrega)',
    };
  }

  // cada subclasse el calcula a la seva manera
  double calcularCostReserva(int minuts);

  @override
  String toString() {
    return '$id | bateria: $bateriaPercentatge% | estat: ${estatBateria()} | en ús: $enUs';
  }
}

class Patinet extends Vehicle {
  int velocitatMaxima;

  Patinet({
    required String id,
    required int bateriaPercentatge,
    required double preuPerMinut,
    required double lat,
    required double lng,
    this.velocitatMaxima = 25,
  }) : super(
          id: id,
          bateriaPercentatge: bateriaPercentatge,
          preuPerMinut: preuPerMinut,
          lat: lat,
          lng: lng,
        );

  // l'usuari és opcional, si és VIP té un 10% de descompte
  @override
  double calcularCostReserva(int minuts, {User? usuari}) {
    double cost = minuts * preuPerMinut;
    if (usuari != null && usuari.esVIP) {
      cost = cost * 0.90;
    }
    return cost;
  }
}

class Cotxe extends Vehicle {
  int places;
  bool requereixLlicencia;
  double suplementFiltreEcologic = 2.0;

  Cotxe({
    required String id,
    required int bateriaPercentatge,
    required double preuPerMinut,
    required double lat,
    required double lng,
    required this.places,
    required this.requereixLlicencia,
  }) : super(
          id: id,
          bateriaPercentatge: bateriaPercentatge,
          preuPerMinut: preuPerMinut,
          lat: lat,
          lng: lng,
        );

  @override
  double calcularCostReserva(int minuts) {
    return (minuts * preuPerMinut) + suplementFiltreEcologic;
  }
}
