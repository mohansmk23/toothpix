class LoginResponse {
  String status;
  String message;
  String authKey;
  String firstName;
  String lastName;
  String gender;
  int age;
  String emailId;
  String mobileNumber;

  LoginResponse(
      {this.status,
      this.message,
      this.authKey,
      this.firstName,
      this.lastName,
      this.gender,
      this.age,
      this.emailId,
      this.mobileNumber});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    authKey = json['auth-key'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    age = json['age'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['auth-key'] = this.authKey;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['email_id'] = this.emailId;
    data['mobile_number'] = this.mobileNumber;
    return data;
  }
}
