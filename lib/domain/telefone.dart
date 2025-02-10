class Telefone {
  String? state;
  List<String>? cities;

  Telefone({this.state, this.cities});

  Telefone.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['cities'] = this.cities;
    return data;
  }
}