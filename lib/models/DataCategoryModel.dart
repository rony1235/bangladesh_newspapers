class DataCategoryModel {
  String category;
  String icon;
  String categoryFullName;
  List<NewspaperList> newspaperList;

  DataCategoryModel({this.category, this.icon, this.newspaperList});

  DataCategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['Category'];
    categoryFullName = json['CategoryFullName'];
    icon = json['Icon'];
    if (json['NewspaperList'] != null) {
      newspaperList = new List<NewspaperList>();
      json['NewspaperList'].forEach((v) {
        newspaperList.add(new NewspaperList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Category'] = this.category;
    data['CategoryFullName'] = this.categoryFullName;
    data['Icon'] = this.icon;
    if (this.newspaperList != null) {
      data['NewspaperList'] =
          this.newspaperList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewspaperList {
  String name;
  String url;
  String icon;
  bool isFavorite;

  NewspaperList({this.name, this.url, this.icon, this.isFavorite});

  NewspaperList.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    url = json['Url'];
    icon = json['Icon'];
    isFavorite = json['IsFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Url'] = this.url;
    data['Icon'] = this.icon;
    data['IsFavorite'] = this.isFavorite;
    return data;
  }
}
