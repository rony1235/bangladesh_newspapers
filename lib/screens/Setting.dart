import 'package:bangladesh_newspapers/services/api.dart';
import 'package:bangladesh_newspapers/services/article_bloc.dart';
import 'package:bangladesh_newspapers/services/article_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:bangladesh_newspapers/utilities/constant.dart';
import 'package:flutter/services.dart';

import 'FlipPanel.dart';
import 'article_page.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //TabController tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Api api = new Api();
    ArticleBloc bloc = ArticleBloc(api: api);

    bloc.getArticles();

    return ArticleBlocProvider(
      bloc: bloc,
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate height of the page before applying the SafeArea since it removes
    // the padding from the MediaQuery and can not calculate it inside the page.
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        130;

    return SafeArea(
      // This Scaffold is used to display the FlipPane SnackBar. Later,
      // each article page will have its own Scaffold
      child: Scaffold(
        body: FlipPanel(
          itemStream: ArticleBlocProvider.of(context).articles,
          itemBuilder: (context, article, flipBack, height) =>
              ArticlePage(article, flipBack, height),
          getItemsCallback: ArticleBlocProvider.of(context).getArticles,
          height: height,
        ),
      ),
    );
  }
}
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     Api api = new Api();
//     ArticleBloc bloc = ArticleBloc(api: api);
//
//     bloc.getArticles();
//     double height = MediaQuery.of(context).size.height -
//         MediaQuery.of(context).padding.top -
//         MediaQuery.of(context).padding.bottom;
//     return Scaffold(
//       body: FlipPanel(
//         itemStream: ArticleBlocProvider.of(context).articles,
//         itemBuilder: (context, article, flipBack, height) =>
//             ArticlePage(article, flipBack, height),
//         getItemsCallback: ArticleBlocProvider.of(context).getArticles,
//         height: height,
//       ),
//       //     Center(
//       //   child: Icon(
//       //     Icons.settings,
//       //     size: 80,
//       //   ),
//       // ),
//       backgroundColor: kPrimaryColor,
//     );
//   }
// }
