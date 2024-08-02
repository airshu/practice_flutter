import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: WsRefreshListWidget<String>(
        itemBuilder: (String data, index) {
          return Text('$index >>> ');
        },
        onRefresh: (page) {
          return Future.value(ListResult(list: List.generate(10, (index) => '<<< $index'), hasMore: page < 3));
        },
      ),
    ),
  ));
}

class WsRefreshListWidget<T> extends StatefulWidget {
  const WsRefreshListWidget({
    super.key,
    required this.itemBuilder,
    this.header,
    this.footer,
    this.onRefresh,
    this.onLoad,
    this.refreshOnStart,
  });

  final Widget Function(T data, int index) itemBuilder;

  final Header? header;

  final Footer? footer;

  final bool? refreshOnStart;

  @override
  State<WsRefreshListWidget<T>> createState() => _WsRefreshListWidgetState<T>();

  final Function(int page)? onRefresh;
  final Function(int page)? onLoad;
}

class _WsRefreshListWidgetState<T> extends State<WsRefreshListWidget<T>> {
  final EasyRefreshController _controller = EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);
  List list = [];
  int currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    list.clear();
    super.dispose();
  }

  void onRefresh() async {
    if (widget.onRefresh == null) {
      return;
    }
    currentPage = 0;
    ListResult result = await widget.onRefresh!.call(currentPage);
    list = result.list ?? [];

    _controller.finishRefresh(result.hasMore ? IndicatorResult.success : IndicatorResult.noMore, true);
    setState(() {});
  }

  void onLoad() async {
    if (widget.onRefresh == null) {
      return;
    }
    currentPage++;
    ListResult result = await widget.onLoad!.call(currentPage);
    list.addAll(result.list ?? []);

    _controller.finishLoad(result.hasMore ? IndicatorResult.success : IndicatorResult.noMore, true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      header: widget.header,
      footer: widget.footer,
      refreshOnStart: widget.refreshOnStart ?? false,
      onRefresh: () async {
        onRefresh();
      },
      onLoad: () {
        onLoad();
      },
      child: ListView.builder(
        itemBuilder: (context, index) {
          Widget child = widget.itemBuilder(list.elementAt(index) as dynamic, index);
          return child;
        },
        itemCount: list.length,
      ),
    );
  }
}

class ListResult<T> {
  final List<T>? list;
  final bool hasMore;

  ListResult({this.list, this.hasMore = false});
}
