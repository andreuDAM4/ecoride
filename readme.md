# EcoRide

Pràctica PF1 del mòdul **Programació Multimèdia i Dispositius Mòbils (PMDM)**.

Motor de lògica en Dart per gestionar la flota de vehicles elèctrics (patinets i cotxes) d'una startup de mobilitat sostenible, i el càlcul de tarifes dels usuaris.

- **Autor/a:** Andreu Anglada Torres
- **Curs:** 26/27
- **Treball:** individual
- **Vídeo de demostració:** https://www.youtube.com/watch?v=MpIOsWSKypY

## Estructura del projecte

```
ecoride/
├── bin/
│   └── main.dart          programa principal
├── lib/
│   ├── gps_location.dart  mixin GPSLocation
│   ├── user.dart          classe User i excepció SaldoInvalidException
│   └── vehicle.dart       classes Vehicle, Patinet i Cotxe
└── pubspec.yaml
```

## Classes

- **User:** usuari amb atributs privats (`_id`, `_nomComplet`, `_saldo`) i públics (`correu`, `esVIP`). Té un constructor complet i un constructor nombrat `User.nou`. El mètode `recarregarSaldo` llança una excepció si la quantitat és negativa o zero.
- **GPSLocation (mixin):** afegeix `latitud`, `longitud`, `actualitzarUbicacio()` i `obtenirCoordenades()`, que retorna un Record `(double lat, double lng)`.
- **Vehicle (abstracta):** té el mixin GPSLocation, el mètode `estatBateria()` amb una Switch Expression i el mètode abstracte `calcularCostReserva()`.
- **Patinet:** calcula el cost per minuts, amb un 10% de descompte si l'usuari és VIP.
- **Cotxe:** calcula el cost per minuts més un suplement de 2,0 € de filtre ecològic.

## Funcionalitats de Dart 3 utilitzades

- Mixin
- Records i destructuració de Records
- Switch Expression
- Mètodes de col·leccions (`reduce`, `where`)
- Excepcions personalitzades amb `try-catch`

## Com executar-ho

Cal tenir instal·lat el SDK de Dart 3.0 o superior.

```
dart pub get
dart run bin/main.dart
```

## Què fa el programa

1. Crea una flota amb 3 patinets i 2 cotxes amb diferents nivells de bateria.
2. Troba el vehicle amb més bateria i filtra els vehicles disponibles (bateria superior al 20% i no en ús).
3. Simula una reserva de 15 minuts d'un patinet, actualitza la seva posició GPS i n'extreu les coordenades.
4. Intenta recarregar un saldo negatiu i gestiona l'error amb `try-catch` sense que el programa s'aturi.