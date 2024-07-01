import 'package:TrashBall/entity/ETypeBonus.dart';

enum EBonus {
  // BONUS DE PRÉCISION
  precision_plus_1(type: ETypeBonus.precision,
      nom: 'précision + 1',
      valeur: 1,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus1.png'
  ),
  precision_plus_2(type: ETypeBonus.precision,
      nom: 'précision + 2',
      valeur: 2,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus2.png'
  ),
  precision_plus_3(type: ETypeBonus.precision,
      nom: 'précision + 3',
      valeur: 3,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus3.png'
  ),
  precision_plus_4(type: ETypeBonus.precision,
      nom: 'précision + 4',
      valeur: 4,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus4.png'
  ),
  precision_plus_5(type: ETypeBonus.precision,
      nom: 'précision + 5',
      valeur: 5,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus5.png'
  ),
  precision_plus_6(type: ETypeBonus.precision,
      nom: 'précision + 6',
      valeur: 6,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus6.png'
  ),
  precision_plus_7(type: ETypeBonus.precision,
      nom: 'précision + 7',
      valeur: 7,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus7.png'
  ),
  precision_plus_8(type: ETypeBonus.precision,
      nom: 'précision + 8',
      valeur: 8,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus8.png'
  ),
  precision_plus_9(type: ETypeBonus.precision,
      nom: 'précision + 9',
      valeur: 9,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus9.png'
  ),
  precision_plus_10(type: ETypeBonus.precision,
      nom: 'précision + 10',
      valeur: 10,
      secondeChance: false,
      img: 'assets/sprite_precision_bonus10.png'
  ),

  // BONUS NOMBRE DE POINT PAR PANIER
  panier_vaut_2(type: ETypeBonus.nbrPointParPanier,
      nom: 'panier vaut 2',
      valeur: 2,
      secondeChance: false,
      img: 'assets/sprite_point_bonus2.png'
  ),
  panier_vaut_3(type: ETypeBonus.nbrPointParPanier,
      nom: 'panier vaut 3',
      valeur: 3,
      secondeChance: false,
      img: 'assets/sprite_point_bonus3.png'
  ),
  panier_vaut_4(type: ETypeBonus.nbrPointParPanier,
      nom: 'panier vaut 4',
      valeur: 4,
      secondeChance: false,
      img: 'assets/sprite_point_bonus4.png'
  ),

  // BONUS DE SECONDE CHANCE
  seconde_chance(type: ETypeBonus.secondeChance,
      nom: 'seconde chance',
      valeur: 0,
      secondeChance: true,
      img: 'assets/Seconde_Chance_Bonus.png'
  );

  final ETypeBonus type;
  final String nom;
  final int valeur;
  final bool secondeChance;
  final String img;

  const EBonus({required this.type,
    required this.nom,
    required this.valeur,
    required this.secondeChance,
    required this.img
  });
}
