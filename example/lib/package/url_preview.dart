library url_preview;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_preview_example/package/meta_data_service.dart';
import 'package:url_preview_example/package/url_preview_meta.dart';

class UrlPreview extends StatelessWidget {
  final Color color;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;
  final TextStyle websiteUrlStyle;
  final VoidCallback onTap;
  final bool disableTapCallback;
  final String url;

  UrlPreview(
      {@required this.url,
      this.color,
      this.titleStyle,
      this.onTap,
      this.disableTapCallback,
      this.descriptionStyle,
      this.websiteUrlStyle});

  launchUrl() {
    launch(this.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MetaDataService.getUrlMetaData(url),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        UrlPreviewMeta urlData = snapshot.data;
        return Wrap(
          children: [
            GestureDetector(
              onTap: disableTapCallback == true ? launchUrl : onTap,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color ?? Colors.grey.withAlpha(10)),
                margin:
                    EdgeInsets.only(right: 10, left: 20, top: 10, bottom: 10),
                padding: EdgeInsets.all(5),
                child: snapshot.hasData
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(5),
                              color: Colors.grey.withAlpha(50),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  urlData.imageUrl ?? urlData.favIcon,
                                ),
                              ),
                            ),
                            title: Text(
                              urlData.title,
                              style: titleStyle ?? null,
                              textDirection: TextDirection.ltr,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  urlData.description,
                                  style: descriptionStyle ?? null,
                                  softWrap: true,
                                  textDirection: TextDirection.ltr,
                                ),
                                Text(
                                  urlData.url,
                                  textDirection: TextDirection.ltr,
                                  style: websiteUrlStyle ??
                                      TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 20, top: 10),
                              child: Text(
                                this.url,
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.only(bottom: 10, left: 20, top: 10),
                        child: Text(
                          this.url,
                          style: TextStyle(color: Colors.blue),
                        )),
              ),
            ),
          ],
        );
      },
    );
  }
}
