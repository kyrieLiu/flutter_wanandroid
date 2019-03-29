import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid_demo/http/common_service.dart';
import 'package:wanandroid_demo/model/banner_model.dart';
import 'package:wanandroid_demo/public_ui/webview_page.dart';

///  Created by liuyin on 2019/3/20 15:18
/// Description:
class BannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BannerWidgetState();
  }
}

class BannerWidgetState extends State<BannerWidget> {
  List<BannerData> _bannerList = new List();

  @override
  void initState() {
    _bannerList.add(null);
    getBannerData();
  }

  Future<Null> getBannerData() async {
    CommonService().getBanner((BannerModel _bannerModel) {
      if (_bannerModel.data.length > 0) {
        setState(() {
          _bannerList = _bannerModel.data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        if (_bannerList[index] == null ||
            _bannerList[index].imagePath == null) {
          return Container(
            color: Colors.grey[100],
          );
        } else {
          return buildItemImageWidget(context, index);
        }
      },
      itemCount: _bannerList.length,
      autoplay: true,
      pagination: new SwiperPagination(),
    );
  }

  Widget buildItemImageWidget(BuildContext context, int index) {
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(
              title: _bannerList[index].title, url: _bannerList[index].url);
        }));
      },
      child: Container(
        child: new Image.network(
          _bannerList[index].imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
