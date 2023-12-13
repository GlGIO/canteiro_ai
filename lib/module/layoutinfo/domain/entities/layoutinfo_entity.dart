class LayoutInfoEntity {
  final int id;
  final String title;
  final String local;
  final String description;
  final String date;
  final String typeEdf;
  final String typeCant;
  final String stage;
  final double largura;
  final double profundidade;
  final double inicioACX;
  final double fimACX;
  final double inicioACY;
  final double fimACY;

  LayoutInfoEntity({
    required this.id,
    required this.title,
    required this.local,
    required this.description,
    required this.date,
    required this.typeEdf,
    required this.typeCant,
    required this.stage,
    required this.largura,
    required this.profundidade,
    required this.inicioACX,
    required this.fimACX,
    required this.inicioACY,
    required this.fimACY,
  });
}

enum TipoEdificacao { residencial, comercial, multifamilar }

enum TipoCanteiro { amplo, estreito, restrito }

enum EtapaObra { fundacao, estrutura, alvenaria, acabamento }
