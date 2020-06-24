import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_preview/core/models/url_preview_meta.dart';

class MetaDataService {
  static Future<UrlPreviewMeta> getUrlMetaData(url) async {
    if (await isPreviewAvaliable(url)) {
      final client = Client();
      final response = await client.get(url);
      final document = parse(response.body);

      String description, title, image, favIcon;

      var elements = document.getElementsByTagName('meta');
      final linkElements = document.getElementsByTagName('link');

      elements.forEach((tmp) {
        if (tmp.attributes['property'] == 'og:title') {
          title = tmp.attributes['content'];
        }
        if (title == null || title.isEmpty) {
          title = document.getElementsByTagName('title')[0].text;
        }

        if (tmp.attributes['property'] == 'og:description') {
          description = tmp.attributes['content'];
        }
        if (description == null || description.isEmpty) {
          if (tmp.attributes['name'] == 'description') {
            description = tmp.attributes['content'];
          }
        }

        if (tmp.attributes['property'] == 'og:image') {
          image = tmp.attributes['content'];
        }
      });

      linkElements.forEach((tmp) {
        if (tmp.attributes['rel']?.contains('icon') == true) {
          favIcon = tmp.attributes['href'];
        }
      });

      return UrlPreviewMeta.fromMap({
        'url': url,
        'imageUrl': _validateImageUrl(imageUrl: image, url: url),
        'title': title,
        'description': description,
        'favIcon': favIcon,
      });
    }
    return null;
  }

  static String _validateImageUrl({String imageUrl, String url}) {
    if (imageUrl == null) {
      return null;
    } else {
      if (_validateUrl(imageUrl)) {
        return imageUrl;
      } else {
        return url + imageUrl;
      }
    }
  }

  static String _getValidUrl(String url) {
    if (_validateUrl(url)) {
      return url;
    } else {
      return 'http://$url';
    }
  }

  static bool _validateUrl(url) {
    if (url?.startsWith('http://') == true ||
        url?.startsWith('https://') == true) {
      return true;
    }
    return false;
  }

  static Future<bool> isPreviewAvaliable(url) async {
    url = _getValidUrl(url);
    return await canLaunch(url);
  }
}
