import 'package:flutter/material.dart';
import 'package:idou/common/component_index.dart';
import 'package:idou/utils/navigator_util.dart';
import 'package:idou/widgets/likebtn/like_button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {
//  WebViewController _webViewController;
//  bool _isShowFloatBtn = false;

  void _onPopSelected(String value) {
    String _title = widget.title ?? IntlUtil.getString(context, widget.titleId);
    switch (value) {
      case "browser":
        NavigatorUtil.launchInBrowser(widget.url, title: _title);
        break;
      case "collection":
        break;
      case "share":
        String _url = widget.url;
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.title ?? IntlUtil.getString(context, widget.titleId),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
//          new IconButton(icon: new Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: new WebView(
        onWebViewCreated: (WebViewController webViewController) {
//          _webViewController = webViewController;
//          _webViewController.addListener(() {
//            int _scrollY = _webViewController.scrollY.toInt();
//            if (_scrollY < 480 && _isShowFloatBtn) {
//              _isShowFloatBtn = false;
//              setState(() {});
//            } else if (_scrollY > 480 && !_isShowFloatBtn) {
//              _isShowFloatBtn = true;
//              setState(() {});
//            }
//          });
        },
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
//      floatingActionButton: _buildFloatingActionButton(),
    );
  }

//  Widget _buildFloatingActionButton() {
//    if (_webViewController == null || _webViewController.scrollY < 480) {
//      return null;
//    }
//    return new FloatingActionButton(
//        heroTag: widget.title ?? widget.titleId,
//        backgroundColor: Theme.of(context).primaryColor,
//        child: Icon(
//          Icons.keyboard_arrow_up,
//        ),
//        onPressed: () {
//          _webViewController.scrollTop();
//        });
//  }
}
