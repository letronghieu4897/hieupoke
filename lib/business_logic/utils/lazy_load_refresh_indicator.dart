import 'dart:async';

import 'package:flutter/material.dart';

class LazyLoadRefreshIndicatorCommon<T> extends StatelessWidget {
  final bool hasReachMax;
  final bool isRefreshing;
  final bool hasListError;
  final bool isLoading;
  final Function onLoadMore;
  final Function onRefresh;
  final Function(BuildContext, T) mainWidget;
  final List items;
  final Widget initWidget;

  static const _loadingWidget = SizedBox(
    height: 64,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  const LazyLoadRefreshIndicatorCommon({
    Key key,
    this.hasReachMax,
    this.isRefreshing,
    this.hasListError,
    this.onLoadMore,
    this.onRefresh,
    this.mainWidget,
    this.isLoading,
    this.items,
    this.initWidget,
  }) : super(key: key);

  ///
  /// FUNCTIONS
  ///
  Future<void> _onLoadMore(BuildContext context) async {
    if (hasReachMax || isRefreshing || hasListError) {
      return;
    }

    onLoadMore(context);
  }

  Future<void> _onRefresh(BuildContext context) async {
    final completer = Completer<void>();

    onRefresh(completer, context);

    await completer.future;
  }

  ///
  /// WIDGETS
  ///
  Widget _buildErrorTile(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SizedBox(height: 8),
        const Icon(
          Icons.error,
          size: 32,
          color: Colors.red,
        ),
        Center(
          child: FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text('Reload'),
            onPressed: () => onLoadMore(),
          ),
        )
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return LazyLoadRefreshIndicator(
      isLoading: isLoading,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 5.0),
        key: key,
        itemBuilder: (context, i) {
          if (i == items?.length) {
            if (isLoading) {
              return _loadingWidget;
            }

            return _buildErrorTile(context);
          }

          return mainWidget(context, items[i]);
        },
        separatorBuilder: (_, __) {
          return SizedBox(height: 16.0);
        },
        itemCount: items.length + (isLoading || hasListError ? 1 : 0),
      ),
      onEndOfPage: () => _onLoadMore(context),
      onRefresh: () => _onRefresh(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isRefreshing) {
      return initWidget;
    }
    return _buildList(context);
  }
}

/// The signature for a function that's called when the user has dragged a
/// [LazyLoadRefreshIndicator] far enough to demonstrate that they want the app to
/// refresh. The returned [Future] must complete when the refresh operation is
/// finished.
///
/// Used by [LazyLoadRefreshIndicator.onRefresh].
typedef RefreshCallback = Future<void> Function();

class LazyLoadRefreshIndicator extends StatefulWidget {
  /// The offset to take into account when triggering [onEndOfPage] in pixels
  final int scrollOffset;

  /// Called when the [child] reaches the end of the list
  final VoidCallback onEndOfPage;

  /// Used to determine if loading of new data has finished. You should use set this if you aren't using a FutureBuilder or StreamBuilder
  final bool isLoading;

  /// A function that's called when the user has dragged the refresh indicator
  /// far enough to demonstrate that they want the app to refresh. The returned
  /// [Future] must complete when the refresh operation is finished.
  final RefreshCallback onRefresh;

  /// The widget below this widget in the tree.
  ///
  /// The refresh indicator will be stacked on top of this child. The indicator
  /// will appear when child's Scrollable descendant is over-scrolled.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  const LazyLoadRefreshIndicator({
    Key key,
    this.scrollOffset = 100,
    @required this.onEndOfPage,
    this.isLoading = false,
    @required this.onRefresh,
    @required this.child,
  })  : assert(child != null),
        assert(onRefresh != null),
        assert(onEndOfPage != null),
        super(key: key);

  @override
  _LazyLoadRefreshIndicatorState createState() =>
      _LazyLoadRefreshIndicatorState();
}

class _LazyLoadRefreshIndicatorState extends State<LazyLoadRefreshIndicator> {
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
  }

  @override
  void didUpdateWidget(LazyLoadRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: RefreshIndicator(
        child: widget.child,
        onRefresh: widget.onRefresh,
      ),
      onNotification: _handleLoadMoreScroll,
    );
  }

  bool _handleLoadMoreScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.maxScrollExtent >= notification.metrics.pixels &&
          notification.metrics.maxScrollExtent - notification.metrics.pixels <=
              widget.scrollOffset) {
        if (!_isLoading) {
          _isLoading = true;
          widget.onEndOfPage();
        }
      }
    }
    return false;
  }
}
