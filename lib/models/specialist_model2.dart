class Specialist2 {
  int? id;
  int? account_id;
  String? expertise;
  String? info_favorite_plants;
  String? contactEmail;
  String? areasOfFocus;



  Specialist2({
    required this.id,
    required this.account_id,
    required this.expertise,
    required this.info_favorite_plants,
    required this.contactEmail,
    required this.areasOfFocus,

  });

  Specialist2.fromJson(Map<String, dynamic> json){
    id = json['id'];
    account_id = json['name'];
    expertise = json['description'];
    info_favorite_plants = json['info_favorite_plants'];
    contactEmail = json['contactEmail'];
    areasOfFocus = json['areasOfFocus'];
  }
}