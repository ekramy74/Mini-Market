class ChangecartModel {
  bool status;
  String message;

  ChangecartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
