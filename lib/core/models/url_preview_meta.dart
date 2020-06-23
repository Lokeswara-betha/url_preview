import 'dart:convert';

class UrlPreviewMeta {
  String url;
  String imageUrl;
  String title;
  String description;
  String favIcon;
  UrlPreviewMeta({
    this.url,
    this.imageUrl,
    this.title,
    this.description,
    this.favIcon,
  });

  UrlPreviewMeta copyWith({
    String url,
    String imageUrl,
    String title,
    String description,
    String favIcon,
  }) {
    return UrlPreviewMeta(
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      favIcon: favIcon ?? this.favIcon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'favIcon': favIcon,
    };
  }

  static UrlPreviewMeta fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UrlPreviewMeta(
      url: map['url'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      description: map['description'],
      favIcon: map['favIcon'],
    );
  }

  String toJson() => json.encode(toMap());

  static UrlPreviewMeta fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'UrlPreviewMeta(url: $url, imageUrl: $imageUrl, title: $title, description: $description, favIcon: $favIcon)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UrlPreviewMeta &&
        o.url == url &&
        o.imageUrl == imageUrl &&
        o.title == title &&
        o.description == description &&
        o.favIcon == favIcon;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        imageUrl.hashCode ^
        title.hashCode ^
        description.hashCode ^
        favIcon.hashCode;
  }
}
