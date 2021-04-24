class HistoryDetailsResponse {
  String status;
  List<ImageDetails> imageDetails;

  HistoryDetailsResponse({this.status, this.imageDetails});

  HistoryDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['image_details'] != null) {
      imageDetails = new List<ImageDetails>();
      json['image_details'].forEach((v) {
        imageDetails.add(new ImageDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.imageDetails != null) {
      data['image_details'] = this.imageDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageDetails {
  String imagePosition;
  String url;
  String cavity;
  String brokenFiling;
  String label;
  String comments;
  String createdAt;
  String responseImage;

  ImageDetails(
      {this.imagePosition,
      this.url,
      this.cavity,
      this.brokenFiling,
      this.label,
      this.comments,
      this.createdAt,
      this.responseImage});

  ImageDetails.fromJson(Map<String, dynamic> json) {
    imagePosition = json['image_position'];
    url = json['url'];
    cavity = json['cavity'];
    brokenFiling = json['broken_filing'];
    label = json['label'];
    comments = json['comments'];
    createdAt = json['created_at'];
    responseImage = json['responseImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_position'] = this.imagePosition;
    data['url'] = this.url;
    data['cavity'] = this.cavity;
    data['broken_filing'] = this.brokenFiling;
    data['label'] = this.label;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['responseImage'] = this.responseImage;
    return data;
  }
}
