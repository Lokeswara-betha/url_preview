library url_preview;

import 'package:flutter/material.dart';
import 'package:url_preview/core/meta_data_service.dart';
import 'package:url_preview/core/models/url_preview_meta.dart';

/// A Calculator.
class UrlPreview extends StatelessWidget {
  final String url;
  const UrlPreview({Key key, @required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MetaDataService.getUrlMetaData(url),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          UrlPreviewMeta urlData = snapshot.data;
          return Container(
            child: Center(
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.network(
                        urlData.imageUrl,
                        height: 100,
                        width: 100,
                      ),
                      title: Text(
                        urlData.title,
                        textDirection: TextDirection.ltr,
                      ),
                      subtitle: Text(
                        urlData.description,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Container(
                        child: Text(
                      urlData.url,
                      textDirection: TextDirection.ltr,
                    )),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
