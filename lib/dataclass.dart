class itemCatatan {
  final String itemJudul;
  final String itemIsi;

  itemCatatan({required this.itemJudul, required this.itemIsi});

  Map<String, dynamic> toJson() {
    return {
      "judulCat": itemJudul,
      "isiCat": itemIsi,
    };
  }

  factory itemCatatan.fromJson(Map<String, dynamic> json) {
    return itemCatatan(itemJudul: json['judulCat'], itemIsi: json['isiCat']);
  }
}

class itemChats {
  final String username;
  final String text;
  final String waktu;

  itemChats({required this.username, required this.text, required this.waktu});

  Map<String, dynamic> toJson() {
    return {"username": username, "text": text, "waktu": waktu};
  }

  factory itemChats.fromJson(Map<String, dynamic> json) {
    return itemChats(username: json['username'], text: json['text'], waktu: json['waktu']);
  }
}
