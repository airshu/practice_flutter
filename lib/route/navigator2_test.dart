import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// navigator 2.0 实例
///
///     Page — 一个不可更改的对象，用于设置Navigator的历史堆栈。
///     Router — 配置要由Navigator显示的页面列表。通常此页面列表根据平台或应用的状态变化而变化。
///     RouteInformationParser，它从RouteInformationProvider中获取RouteInformation，并将其解析为用户定义的数据类型。
///     RouterDelegate — 定义了Router如何学习应用状态变化以及如何响应这些变化的应用特定行为。它的工作是监听RouteInformationParser和应用状态，并利用当前的Pages列表构建Navigator。
///     BackButtonDispatcher — 向Router报告返回按钮按下的情况。
///
/// TransitionDelegate 控制转场效果
main() {
  runApp(Navigator2BooksApp());
}

class Navigator2BooksApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Navigator2BooksAppState();
}

class _Navigator2BooksAppState extends State<Navigator2BooksApp> {
  final BookRouterDelegate _routerDelegate = BookRouterDelegate();
  final BookRouteInformationParser _routeInformationParser = BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Books App',
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}

class BookRouterDelegate extends RouterDelegate<BookRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  late final GlobalKey<NavigatorState> navigatorKey;

  Book? _selectedBook;
  bool show404 = false;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  BookRoutePath get currentConfiguration {
    if (show404) {
      return BookRoutePath.unknown();
    }
    return _selectedBook == null ? BookRoutePath.home() : BookRoutePath.details(books.indexOf(_selectedBook!));
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    print('BookRouterDelegate --- build');
    return Navigator(
      key: navigatorKey,
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        MaterialPage(
          key: ValueKey('BooksListPage'),
          child: BooksListScreen(
            books: books,
            onTapped: _handleBookTapped,
          ),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        else if (_selectedBook != null)
          BookDetailsPage(book: _selectedBook!)
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _selectedBook = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<bool> popRoute() async {
    print('BookRouterDelegate popRoute');
    return true;
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(BookRoutePath path) async {
    print('BookRouterDelegate setNewRoutePath--->path=$path');
    if (path.isUnknown) {
      _selectedBook = null;
      show404 = true;
      return;
    }
    if (path.isDetailsPage) {
      if (path.id < 0 || path.id > books.length - 1) {
        show404 = true;
        return;
      }
      _selectedBook = books[path.id];
    } else {
      _selectedBook = null;
    }
    show404 = false;
  }

  void _handleBookTapped(Book book) {
    print('------book=$book');
    _selectedBook = book;
    notifyListeners();
  }
}

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
  @override
  Future<BookRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return BookRoutePath.home();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') {
        return BookRoutePath.unknown();
      }
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) {
        return BookRoutePath.unknown();
      }
      return BookRoutePath.details(id);
    }
    return BookRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/book/${path.id}');
    }
    return null;
  }
}

class NoAnimationTransitionDelegate extends TransitionDelegate<void> {
  /// 负责将各种路由标记为推送、弹出、添加、完成或删除
  ///
  ///     markForPush - 显示路由时有动画过渡。
  ///     markForAdd - 显示路由时没有动画过渡。
  ///     markForPop - 删除路由时有动画过渡，并用result完成它。在此上下文中，"完成 "意味着result对象被传递给AppRouterDelegate的onPopPage回调。
  ///     markForComplete - 删除路由时没有动画过渡，并用result来完成它。
  ///     markForRemove - 删除路由时没有动画过渡，且没有完成。
  @override
  Iterable<RouteTransitionRecord> resolve(
      {required List<RouteTransitionRecord> newPageRouteHistory,
      required Map<RouteTransitionRecord?, RouteTransitionRecord> locationToExitingPageRoute,
      required Map<RouteTransitionRecord?, List<RouteTransitionRecord>> pageRouteToPagelessRoutes}) {
    final results = <RouteTransitionRecord>[];
    for (final pageRoute in newPageRouteHistory) {
      if (pageRoute.isWaitingForEnteringDecision) {
        pageRoute.markForAdd();
      }
      results.add(pageRoute);
    }

    for (final exitingPageRoute in locationToExitingPageRoute.values) {
      if (exitingPageRoute.isWaitingForExitingDecision) {
        exitingPageRoute.markForRemove();
        final pagelessRoutes = pageRouteToPagelessRoutes[exitingPageRoute];
        if (pagelessRoutes != null) {
          for (final pagelessRoute in pagelessRoutes) {
            pagelessRoute.markForRemove();
          }
        }
      }
      results.add(exitingPageRoute);
    }
    return results;
  }
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class BookRoutePath {
  final int id;
  final bool isUnknown;

  BookRoutePath.home()
      : id = 0,
        isUnknown = false;

  BookRoutePath.details(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = 0,
        isUnknown = true;

  bool get isHomePage => id == 0;

  bool get isDetailsPage => id != 0;

  @override
  String toString() {
    return '[BookRoutePath: id=$id, isUnknown=$isUnknown]';
  }
}

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  BooksListScreen({
    required this.books,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            )
        ],
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class BookDetailsPage extends Page {
  final Book book;

  BookDetailsPage({
    required this.book,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(book: book);
      },
    );
  }
}

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'),
            ),
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
