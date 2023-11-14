class Chat{
  final int id;
  final int farmerId;
  final int specialistId;
  final bool isChatStarted;


   Chat({
    required this.id,
    required this.farmerId,
    required this.specialistId,
    required this.isChatStarted
  });

  

  Chat.fromJson(Map<String, dynamic> json)
  :
      id = json['id'],
      farmerId= json['farmerId'],
      specialistId= json['specialistId'],
      isChatStarted = json['isChatStarted'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farmerId': farmerId,
      'specialistId': specialistId,
      'isChatStarted': isChatStarted
    };
  }

}