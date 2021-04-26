class UploadImageResponse {
  String status;
  String message;
  ImageResponse imageResponse;
  var enquiryId;

  UploadImageResponse(
      {this.status, this.message, this.imageResponse, this.enquiryId});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    imageResponse = json['imageResponse'] != null
        ? new ImageResponse.fromJson(json['imageResponse'])
        : null;
    enquiryId = json['enquiryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.imageResponse != null) {
      data['imageResponse'] = this.imageResponse.toJson();
    }
    data['enquiryId'] = this.enquiryId;
    return data;
  }
}

class ImageResponse {
  TopLeft topLeft;
  TopLeft topRight;
  TopLeft bottomLeft;
  TopLeft bottomRight;

  ImageResponse(
      {this.topLeft, this.topRight, this.bottomLeft, this.bottomRight});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    topLeft = json['Top_Left'] != null
        ? new TopLeft.fromJson(json['Top_Left'])
        : null;
    topRight = json['Top_Right'] != null
        ? new TopLeft.fromJson(json['Top_Right'])
        : null;
    bottomLeft = json['Bottom_Left'] != null
        ? new TopLeft.fromJson(json['Bottom_Left'])
        : null;
    bottomRight = json['Bottom_Right'] != null
        ? new TopLeft.fromJson(json['Bottom_Right'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topLeft != null) {
      data['Top_Left'] = this.topLeft.toJson();
    }
    if (this.topRight != null) {
      data['Top_Right'] = this.topRight.toJson();
    }
    if (this.bottomLeft != null) {
      data['Bottom_Left'] = this.bottomLeft.toJson();
    }
    if (this.bottomRight != null) {
      data['Bottom_Right'] = this.bottomRight.toJson();
    }
    return data;
  }
}

class TopLeft {
  String imageType;
  String orginalImageUrl;
  String responseImage;
  String isDetected;

  TopLeft(
      {this.imageType,
      this.orginalImageUrl,
      this.responseImage,
      this.isDetected});

  TopLeft.fromJson(Map<String, dynamic> json) {
    imageType = json['imageType'];
    orginalImageUrl = json['orginalImageUrl'];
    responseImage = json['responseImage'];
    isDetected = json['isDetected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageType'] = this.imageType;
    data['orginalImageUrl'] = this.orginalImageUrl;
    data['responseImage'] = this.responseImage;
    data['isDetected'] = this.isDetected;
    return data;
  }
}
