import 'package:flutter/material.dart';

class ScaffoldTabBarTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScaffoldTabBarTestRouteState();
  }
}

class _ScaffoldTabBarTestRouteState extends State<ScaffoldTabBarTestRoute>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Name'),
        actions: <Widget>[
          // 导航右侧菜单
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList(),
        ),
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((e) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              e,
              textScaleFactor: 5,
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  void _onAdd() {}
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 38),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ClipOval(
                      child: Image.asset(
                        'images/1.png',
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    'Wendux',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add account'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Manage account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
