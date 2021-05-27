class Article {
  String source;
  String author;
  String logo;
  String Date;
  String title;
  String description;
  String url;
  String urlToImage;

  Article({
    this.source,
    this.author,
    this.logo,
    this.Date,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
  });

  Article.fromJson(Map map) {
    source = map['source'];
    author = map['author'];
    logo = map['logo'];
    Date = map['Date'];
    title = map['title'];
    description = map['description'];
    url = map['url'];
    urlToImage = map['urlToImage'];
  }
}
