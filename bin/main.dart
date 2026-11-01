import 'package:ecoride/user.dart';
import 'package:ecoride/vehicle.dart';

void main() {
  // crear els vehicles
  Patinet patinet1 = Patinet(
      id: 'PAT-001',
      bateriaPercentatge: 92,
      preuPerMinut: 0.25,
      lat: 39.7210,
      lng: 2.9114);
  Patinet patinet2 = Patinet(
      id: 'PAT-002',
      bateriaPercentatge: 55,
      preuPerMinut: 0.25,
      lat: 39.7225,
      lng: 2.9130);
  Patinet patinet3 = Patinet(
      id: 'PAT-003',
      bateriaPercentatge: 12,
      preuPerMinut: 0.25,
      lat: 39.7198,
      lng: 2.9101);
  Cotxe cotxe1 = Cotxe(
      id: 'COT-001',
      bateriaPercentatge: 78,
      preuPerMinut: 0.60,
      lat: 39.7240,
      lng: 2.9150,
      places: 4,
      requereixLlicencia: true);
  Cotxe cotxe2 = Cotxe(
      id: 'COT-002',
      bateriaPercentatge: 35,
      preuPerMinut: 0.60,
      lat: 39.7185,
      lng: 2.9088,
      places: 2,
      requereixLlicencia: true);

  // aquest cotxe ja està en ús
  cotxe2.enUs = true;

  List<Vehicle> flota = [patinet1, patinet2, patinet3, cotxe1, cotxe2];

  print('FLOTA INICIAL');
  flota.forEach(print);

  // vehicle amb més bateria
  Vehicle vehicleMesBateria = flota.reduce((actual, seguent) {
    if (actual.bateriaPercentatge >= seguent.bateriaPercentatge) {
      return actual;
    } else {
      return seguent;
    }
  });
  print('\nVEHICLE AMB MÉS BATERIA');
  print(vehicleMesBateria);

  // vehicles amb més del 20% de bateria i que no estan en ús
  List<Vehicle> vehiclesDisponibles = flota
      .where((vehicle) => vehicle.bateriaPercentatge > 20 && !vehicle.enUs)
      .toList();

  print('\nVEHICLES DISPONIBLES');
  vehiclesDisponibles.forEach(print);

  // crear usuaris
  User usuariNormal =
      User.nou(id: 'U-001', nom: 'Joan Serra', correu: 'joan@ecoride.com');
  User usuariVIP =
      User.nou(id: 'U-002', nom: 'Laura Garcia', correu: 'laura@ecoride.com');
  usuariVIP.esVIP = true;

  // reserva del patinet durant 15 minuts
  patinet1.enUs = true;
  double costNormal = patinet1.calcularCostReserva(15, usuari: usuariNormal);
  double costVIP = patinet1.calcularCostReserva(15, usuari: usuariVIP);
  print('\nRESERVA DE ${patinet1.id} (15 minuts)');
  print('SIMULACIO cost usuari normal: ${costNormal.toStringAsFixed(2)} €');
  print('SIMULACIO cost usuari VIP: ${costVIP.toStringAsFixed(2)} €');

  // actualitzar la posició i treure les coordenades del record
  patinet1.actualitzarUbicacio(39.7300, 2.9200);
  var (lat, lng) = patinet1.obtenirCoordenades();
  print('Nova posició: latitud $lat, longitud $lng');

  // recàrrega de saldo amb control d'errors
  print('\nRECÀRREGA DE SALDO');
  try {
    usuariNormal.recarregarSaldo(-10.0);
  } on SaldoInvalidException catch (error) {
    print('Error controlat: ${error.missatge}');
  }

  print('\nel programa ha acabat correctament');
}
