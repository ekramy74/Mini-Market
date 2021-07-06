class ChangePass {
  bool status;
  String message;
  Data data;

  ChangePass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String email;

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }
}
