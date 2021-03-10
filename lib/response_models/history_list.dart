class HistoryResponse {
  String status;
  String message;
  List<History> history;

  HistoryResponse({this.status, this.message, this.history});

  HistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String id;
  String uploadDate;
  String recommentationDate;
  String recommentStatus;
  List<ImageUrl> imageUrl;

  History(
      {this.id,
      this.uploadDate,
      this.recommentationDate,
      this.recommentStatus,
      this.imageUrl});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadDate = json['upload_date'];
    recommentationDate = json['recommentation_date'];
    recommentStatus = json['recomment_status'];
    if (json['image_url'] != null) {
      imageUrl = new List<ImageUrl>();
      json['image_url'].forEach((v) {
        imageUrl.add(new ImageUrl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upload_date'] = this.uploadDate;
    data['recommentation_date'] = this.recommentationDate;
    data['recomment_status'] = this.recommentStatus;
    if (this.imageUrl != null) {
      data['image_url'] = this.imageUrl.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageUrl {
  String topLeft;
  String topRight;
  String bottomLeft;
  String bottomRight;

  ImageUrl({this.topLeft, this.topRight, this.bottomLeft, this.bottomRight});

  ImageUrl.fromJson(Map<String, dynamic> json) {
    topLeft = json['topLeft'];
    topRight = json['topRight'];
    bottomLeft = json['bottomLeft'];
    bottomRight = json['bottomRight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topLeft'] = this.topLeft;
    data['topRight'] = this.topRight;
    data['bottomLeft'] = this.bottomLeft;
    data['bottomRight'] = this.bottomRight;
    return data;
  }
}
