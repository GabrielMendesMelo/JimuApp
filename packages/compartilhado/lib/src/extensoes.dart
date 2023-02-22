extension CapitalizeExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String capitalizeSentence() {
    final List<String> sentence = split(' ');
    String output = '';

    for (int i = 0; i < sentence.length; i++) {
      final String s = sentence[i];

      if (i < sentence.length - 1) {
        output += '${s.capitalize()} ';
      } else {
        output += s.capitalize();
      }
    }
    return output;
  }

  String toNome() {
    final List<String> sentence = split(' ');
    String output = '';

    for (int i = 0; i < sentence.length; i++) {
      String s = sentence[i];
      if (_deveCapitalizar(s)) {
        s = s.capitalize();
      } else {
        s = s.toLowerCase();
      }

      if (i < sentence.length - 1) {
        output += '$s ';
      } else {
        output += s;
      }
    }
    return output;
  }

  bool _deveCapitalizar(String s) {
    final List<String> naoDeveCapitalizar = <String>[
      'da',
      'Da',
      'DA',
      'dA',
      'do',
      'Do',
      'DO',
      'dO',
      'de',
      'De',
      'DE',
      'dE',
      'com',
      'Com',
      'COM',
      'cOm',
      'coM',
      'COm',
      'cOM',
      'ao',
      'Ao',
      'AO',
      'aO',
      'a',
      'A',
      'à',
      'À',
      'em',
      'Em',
      'EM',
      'eM',
      'e',
      'E',
    ];

    for (final String n in naoDeveCapitalizar) {
      if (s == n) {
        return false;
      }
    }

    return true;
  }
}

extension FormatarParaEnvio on String {
  String formatar() {
    final List<String> sentence = split(' ');
    String output = '';

    for (int i = 0; i < sentence.length; i++) {
      final String s = sentence[i];

      if (s.isNotEmpty) {
        if (i < sentence.length - 1) {
          output += '$s ';
        } else {
          output += s;
        }
      }
    }
    return output.trim();
  }
}

extension DataBrasileira on DateTime {
  String asDataBrasileira() {
    return '$day/$month/$year';
  }
}

extension DataHoraBrasileira on DateTime {
  String asDataHoraBrasileira() {
    return '$day/${_format(month)}/$year - ${_format(hour)}:${_format(minute)}:${_format(second)}';
  }

  String _format(int numero) {
    return numero.toString().length < 2 ? '0$numero' : numero.toString();
  }
}
