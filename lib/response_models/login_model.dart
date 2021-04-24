class LoginResponse {
  String status;
  String message;
  String isTempPassword;
  String authKey;
  String firstName;
  String lastName;
  String gender;
  int age;
  String emailId;
  String mobileNumber;
  String profileUrl;

  LoginResponse(
      {this.status,
      this.message,
      this.isTempPassword,
      this.authKey,
      this.firstName,
      this.lastName,
      this.gender,
      this.age,
      this.emailId,
      this.mobileNumber,
      this.profileUrl});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isTempPassword = json['isTempPassword'];
    authKey = json['auth-key'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    age = json['age'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['isTempPassword'] = this.isTempPassword;
    data['auth-key'] = this.authKey;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['email_id'] = this.emailId;
    data['mobile_number'] = this.mobileNumber;
    data['profile_url'] = this.profileUrl;
    return data;
  }
}
