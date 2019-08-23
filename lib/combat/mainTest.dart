import 'package:camera/camera.dart';
import 'package:first_flutter_app/combat/CombinationTestRoute.dart';
import 'package:first_flutter_app/combat/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'widgets/common.dart';
import 'AlertDialogTestRoute.dart';
import 'AlignTestRoute.dart';
import 'AnimatedSwitcherRoute.dart';
import 'BoxTestRoute.dart';
import 'ClipTestRoute.dart';
import 'ContainerTestRoute.dart';
import 'CustomPaintTestRoute.dart';
import 'CustomScrollViewTestRoute.dart';
import 'DecorationTestRoute.dart';
import 'DioTestRoute.dart';
import 'FileOperationTestRoute.dart';
import 'FlexLayoutTestRoute.dart';
import 'FlowLayoutTestRoute.dart';
import 'FutureAndStreamTestRoute.dart';
import 'GestureDetectorTestRoute.dart';
import 'GradientCircularProgressRoute.dart';
import 'GridViewTestRoute.dart';
import 'HeroAnimationRoute.dart';
import 'HttpClientTestRoute.dart';
import 'InheritedTestRoute.dart';
import 'LinearLayoutTestRoute.dart';
import 'ListViewTestRoute.dart';
import 'NotificationTestRoute.dart';
import 'PaddingTestRoute.dart';
import 'ProgressRoute.dart';
import 'ProviderTestRoute.dart';
import 'ScaffoldTabBarTestRoute.dart';
import 'ScaleAnimationRoute.dart';
import 'ScrollControllerTestRoute.dart';
import 'SingleChildScrollViewTestRoute.dart';
import 'StackLayoutTestRoute.dart';
import 'StaggerAnimationRoute.dart';
import 'CameraTestRoute.dart';
import 'ThemeTestRoute.dart';
import 'TransformTestRoute.dart';
import 'TurnBoxTestRoute.dart';
import 'WebSocketTestRoute.dart';
import 'WillPopScopeTestRoute.dart';

void main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 列表中的元素是生成本地化值集合的工厂
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // 应用支持的语言列表
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("zh", "CN"),
      ],
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _openPage(BuildContext context, PageInfo page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (!page.withScaffold) {
        return page.builder(context);
      }

      return PageScaffold(
        title: page.title,
        body: page.builder(context),
        padding: page.padding,
      );
    }));
  }

  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () => _openPage(context, page),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter实战"),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('基础组件'),
            children: _generateItem(context, [
              PageInfo("进度条", (ctx) => ProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('布局类组件'),
            children: _generateItem(context, [
              PageInfo("线性布局", (ctx) => LinearLayoutTest()),
              PageInfo("弹性布局", (ctx) => FlexLayoutTestRoute()),
              PageInfo("流式布局", (ctx) => FlowLayoutTestRoute()),
              PageInfo("层叠布局", (ctx) => StackLayoutTestRoute()),
              PageInfo("对齐与相对定位", (ctx) => AlignTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('容器类组件'),
            children: _generateItem(context, [
              PageInfo("填充(Padding)", (ctx) => PaddingTestRoute()),
              PageInfo("尺寸限制类容器", (ctx) => BoxTestRoute()),
              PageInfo("装饰类容器", (ctx) => DecorationTestRoute()),
              PageInfo("变换(Transform)", (ctx) => TransformTestRoute()),
              PageInfo("Container容器", (ctx) => ContainerTestRoute()),
              PageInfo("Scaffold,TabBar,NavigationBar",
                  (ctx) => ScaffoldTabBarTestRoute(),
                  withScaffold: false),
              PageInfo("裁剪(Clip)", (ctx) => ClipTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('可滚动组件'),
            children: _generateItem(context, [
              PageInfo("SingleChildScrollView",
                  (ctx) => SingleChildScrollViewTestRoute()),
              PageInfo("ListView", (ctx) => ListViewTestRoute()),
              PageInfo("GridView", (ctx) => GridViewTestRoute()),
              PageInfo("CustomScrollView", (ctx) => CustomScrollViewTestRoute(),
                  withScaffold: false),
              PageInfo("ScrollController", (ctx) => ScrollControllerTestRoute(),
                  withScaffold: true),
            ]),
          ),
          ExpansionTile(
            title: Text('功能型组件'),
            children: _generateItem(context, [
              PageInfo("返回拦截(WillpopScope)", (ctx) => WillPopScopeTestRoute()),
              PageInfo("数据共享(InheritedWidget)", (ctx) => InheritedTestRoute()),
              PageInfo("款组件状态共享(Provider)", (ctx) => ProviderTestRoute()),
              PageInfo("颜色和主题(Theme)", (ctx) => ThemeTestRoute(),
                  withScaffold: false),
              PageInfo("异步更新UI", (ctx) => FutureAndStreamTestRoute()),
              PageInfo("对话框", (ctx) => DialogRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('事件处理与通知'),
            children: _generateItem(context, [
              PageInfo('手势识别', (ctx) => GestureDetectorTestRoute()),
              PageInfo('通知(Notification)', (ctx) => NotificationTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('动画'),
            children: _generateItem(context, [
              PageInfo('动画结构', (ctx) => ScaleAnimationRoute()),
              PageInfo('Hero动画', (ctx) => HeroAnimationRoute()),
              PageInfo('交织动画', (ctx) => StaggerAnimationRoute()),
              PageInfo(
                  '通用动画(AnimatedSwitcher)', (ctx) => AnimatedSwitcherRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('自定义组件'),
            children: _generateItem(context, [
              PageInfo('组合现有组件', (ctx) => CombinationTestRoute()),
              PageInfo('组合实例TurnBox', (ctx) => TurnBoxTestRoute()),
              PageInfo('自绘组件(CustomPaint)', (ctx) => CustomPaintTestRoute()),
              PageInfo(
                  '自绘实例(圆形背景渐变进度条)', (ctx) => GradientCircularProgressRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text('文件与网络操作'),
            children: _generateItem(context, [
              PageInfo('文件操作', (ctx) => FileOperationTestRoute(),
                  withScaffold: false),
              PageInfo('HttpClient', (ctx) => HttpClientTestRoute()),
              PageInfo('Dio库', (ctx) => DioTestRoute()),
              PageInfo('WebSocket协议', (ctx) => WebSocketTestRoute(),
                  withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: Text('包和插件'),
            children: _generateItem(context, [
              PageInfo('Texture(相机)', (ctx) => CameraTestRoute(),
                  withScaffold: false),
            ]),
          ),
        ],
      ),
    );
  }
}
