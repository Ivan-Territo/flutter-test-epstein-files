class Room {
  final int id;
  final String nomeStanza;
  final String tipologia;
  final double prezzoNotte;
  final int postiLetto;
  final List<String> servizi;
  final bool disponibile;
  final String urlImmagine;

  Room({
    required this.id,
    required this.nomeStanza,
    required this.tipologia,
    required this.prezzoNotte,
    required this.postiLetto,
    required this.servizi,
    required this.disponibile,
    required this.urlImmagine,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      nomeStanza: json['nome_stanza'],
      tipologia: json['tipologia'],
      prezzoNotte: json['prezzo_notte'],
      postiLetto: json['posti_letto'],
      servizi: List<String>.from(json['servizi']),
      disponibile: json['disponibile'],
      urlImmagine: json['url_immagine'],
    );
  }
}
