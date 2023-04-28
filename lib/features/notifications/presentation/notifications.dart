import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/features/notifications/domain/usecase/notifications_usecase.dart';
import 'package:pips/features/notifications/domain/usecase/readnotification_usecase.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletons/skeletons.dart';

import '../../../common/resources/sizes_manager.dart';
import '../../../common/resources/strings_manager.dart';
import '../data/requests/notifications_request/notifications_request.dart';
import '../domain/models/notification.dart' as notification_model;

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

// TODO: enable real-time notifications
class _NotificationsViewState extends State<NotificationsView>
    with AutomaticKeepAliveClientMixin {
  final NotificationsUseCase _notificationsUseCase =
      instance<NotificationsUseCase>();
  final ReadNotificationUseCase _readNotificationUseCase =
      instance<ReadNotificationUseCase>();

  late ScrollController _scrollController;

  final List<notification_model.Notification> _notifications = [];

  bool _loading = true;
  int _currentPage = 1;
  int _lastPage = 1;
  String? _error;

  Future<void> _getNotifications() async {
    (await _notificationsUseCase
            .execute(NotificationsRequest(perPage: 25, page: _currentPage)))
        .fold((failure) {
      setState(() {
        _error = failure.message;
        _loading = false;
      });
    }, (response) {
      if (!mounted) return;

      final data = response.data;

      setState(() {
        _error = null;
        _notifications.addAll(data);
        _currentPage++;
        _lastPage = response.meta.pagination.last;
        _loading = false;
      });
    });
  }

  _MySearchDelegate? _delegate;

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _MySearchDelegate(_notifications),
    );
  }

  bool get _isLast {
    return _currentPage == _lastPage;
  }

  @override
  void initState() {
    super.initState();

    _getNotifications();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > nextPageTrigger) {
        // if loading do not proceed
        if (_loading) {
          return;
        }

        if (_isLast) {
          return;
        }

        _loading = true;

        _getNotifications();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notifications),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: AppStrings.search,
            onPressed: () async {
              _showSearch(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_notifications.isEmpty) {
      if (_loading) {
        return _buildLoader();
      }

      if (_error != null) {
        return _buildError();
      }

      return _buildEmpty();
    }

    // first time error - show big error with retry
    // succeeding loading - show loading as another list item
    // succeeding error - show error as another list item
    if (_notifications.isNotEmpty) {
      // if loading and empty, show empty loader
      return _buildList();
    }

    return Container();
  }

  Widget _buildList() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _notifications.length + 1,
      separatorBuilder: (context, index) => Divider(
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (context, index) {
        if (index == _notifications.length) {
          return _loading
              ? const Padding(
                  padding: EdgeInsets.all(AppPadding.md),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (_error != null
                  ? _buildError()
                  : const Text(
                      'End of list',
                      textAlign: TextAlign.center,
                    ));
        }

        var notifications = _notifications;

        return ListTile(
          leading: Icon(
            notifications[index].read
                ? Icons.mark_email_read
                : Icons.mark_email_unread_outlined,
            color: notifications[index].read
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            notifications[index].data.subject,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: notifications[index].read
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
          subtitle: Text(
            DateFormat.yMMMd().add_jms().format(
                  DateTime.parse(
                    notifications[index].createdAt,
                  ),
                ),
            style: const TextStyle(fontSize: FontSize.lg),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSize.md,
                    ),
                  ),
                  icon: const Icon(
                    Icons.mark_email_unread,
                    size: AppSize.s36,
                  ),
                  content: Text(notifications[index].data.message),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(AppStrings.close)),
                    if (!_notifications[index].read)
                      ElevatedButton(
                        onPressed: () async {
                          // handle mark as read
                          await _markNotificationAsRead(
                              notifications[index].id);
                        },
                        child: const Text(AppStrings.markAsRead),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildLoader() {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.md),
              child: SkeletonListTile(
                hasLeading: true,
                hasSubtitle: true,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Text('Nothing found'),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        children: [
          Text(_error!),
          ElevatedButton(
            onPressed: _getNotifications,
            child: const Text(AppStrings.tryAgain),
          ),
        ],
      ),
    );
  }

  Future<void> _markNotificationAsRead(String id) async {
    (await _readNotificationUseCase.execute(id)).fold((failure) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message)));
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }, (response) {
      int itemIndex = _notifications.indexWhere((item) => item.id == id);

      setState(() {
        _notifications[itemIndex].read = true;
      });

      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<notification_model.Notification> _notifications;

  _MySearchDelegate(List<notification_model.Notification>? notifications)
      : _notifications = notifications ?? [],
        super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: AppStrings.clear,
        icon: const Icon(Icons.clear),
        onPressed: () {
          // clear the search
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: AppStrings.back,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _notifications
        .where((notification) =>
            notification.data.subject
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            notification.data.sender
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            notification.data.message
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final notification = results[index];

        return ListTile(
          title: Text(notification.data.subject),
          subtitle: Text(notification.data.message),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isNotEmpty
        ? _notifications
            .where((notification) => notification.data.subject
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList()
        : [];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final notification = suggestions[index];
        return ListTile(
          title: Text(notification.data.subject),
          subtitle: Text(notification.data.message),
        );
      },
    );
  }
}
