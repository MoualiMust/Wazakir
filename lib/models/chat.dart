class Chat {
  String id;
  String nom;
  String message;
  String date;

  Chat({this.id, this.nom, this.message, this.date});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'nom': nom,
      'message': message,
      'date': date,
    };
  }

  Chat.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        nom = firestoreMap['nom'],
        message = firestoreMap['message'],
        date = firestoreMap['date'];
}
