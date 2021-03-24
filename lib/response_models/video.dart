class VideoResponse {
  String status;
  DentalHealth dentalHealth;
  DentalHealth takePick;

  VideoResponse({this.status, this.dentalHealth, this.takePick});

  VideoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dentalHealth = json['dentalHealth'] != null
        ? new DentalHealth.fromJson(json['dentalHealth'])
        : null;
    takePick = json['takePick'] != null
        ? new DentalHealth.fromJson(json['takePick'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dentalHealth != null) {
      data['dentalHealth'] = this.dentalHealth.toJson();
    }
    if (this.takePick != null) {
      data['takePick'] = this.takePick.toJson();
    }
    return data;
  }
}

class DentalHealth {
  String url;
  String title;
  String thumbnailImage;
  String activeStatus;

  DentalHealth({this.url, this.title, this.thumbnailImage, this.activeStatus});

  DentalHealth.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    thumbnailImage = json['thumbnail_image'];
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    data['thumbnail_image'] = this.thumbnailImage;
    data['active_status'] = this.activeStatus;
    return data;
  }
}
