class PredictionModel {
  String status;
  String message;
  List<ResponseImages> responseImages;

  PredictionModel({this.status, this.message, this.responseImages});

  PredictionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['responseImages'] != null) {
      responseImages = new List<ResponseImages>();
      json['responseImages'].forEach((v) {
        responseImages.add(new ResponseImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.responseImages != null) {
      data['responseImages'] =
          this.responseImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseImages {
  String isDetected;
  String responseImage;

  ResponseImages({this.isDetected, this.responseImage});

  ResponseImages.fromJson(Map<String, dynamic> json) {
    isDetected = json['isDetected'];
    responseImage = json['responseImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDetected'] = this.isDetected;
    data['responseImage'] = this.responseImage;
    return data;
  }
}
