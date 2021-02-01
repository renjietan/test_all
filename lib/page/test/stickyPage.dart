import 'package:flutter/material.dart';
import 'package:flutter_appclient/config/baseConfig.dart';
import 'package:flutter_appclient/mobileUI/list/listItem.dart';
import 'package:flutter_appclient/mobileUI/sticky/stickyHeader.dart';

class StickyPage extends StatefulWidget {
  StickyPage({Key key}) : super(key: key);

  @override
  _StickyPageState createState() => _StickyPageState();
}

class _StickyPageState extends State<StickyPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _tabs = [
    Tab(
      text: "进行中",
    ),
    Tab(
      text: "完成",
    ),
    Tab(
      text: "已完成",
    ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: null,
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage(
                  "assets/images/banner1.jpg",
                ),
                fit: BoxFit.cover,
              ),
              title: Text("简单吸顶"),
              centerTitle: true,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeader(
              minHeight: 45,
              maxHeight: 45,
              child: Container(
                color: BaseConfig.theme,
                child: TabBar(
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: _tabs,
                  controller: _tabController,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((content, index) {
              return ListItem(
                title: "111",
                callback: () {
                  print(index);
                },
              );
            }, childCount: 5),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((content, index) {
              return Container(
                height: 120,
                color: Colors.primaries[index % Colors.primaries.length],
              );
            }, childCount: 5),
          ),
        ],
      ),
    );
  }
}
