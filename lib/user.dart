// excepció personalitzada
class SaldoInvalidException implements Exception {
  String missatge;

  SaldoInvalidException(this.missatge);
}

class User {
  // atributs privats
  final String _id;
  final String _nomComplet;
  double _saldo;

  // atributs públics
  String correu;
  bool esVIP;

  // constructor complet
  User({
    required String id,
    required String nomComplet,
    required double saldo,
    required this.correu,
    this.esVIP = false,
  })  : _id = id,
        _nomComplet = nomComplet,
        _saldo = saldo;

  // constructor nombrat amb saldo inicial a 0
  User.nou({
    required String id,
    required String nom,
    required String correu,
  }) : this(id: id, nomComplet: nom, saldo: 0.0, correu: correu);

  // getters
  double get saldo => _saldo;
  String get id => _id;
  String get nomComplet => _nomComplet;

  // no deixa recarregar quantitats negatives o zero
  void recarregarSaldo(double quantitat) {
    if (quantitat <= 0) {
      throw SaldoInvalidException(
          'la quantitat ha de ser positiva (valor rebut: $quantitat)');
    }
    _saldo = _saldo + quantitat;
  }
}
