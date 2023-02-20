import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/responses/notifications/notifications_response.dart';
import 'package:pips/domain/usecase/notifications_usecase.dart';

import '../../../domain/models/notification.dart' as notificationModel;
import '../../../domain/usecase/base_usecase.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final NotificationsUseCase _notificationsUseCase =
      instance<NotificationsUseCase>();

  List<notificationModel.Notification>? _notifications;

  Future<void> _getNotifications() async {
    final Result<NotificationsResponse> result =
        await _notificationsUseCase.execute(null);

    if (result.success) {
      final data = result.data?.data;

      setState(() {
        _notifications = data;
      });
    }
  }

  _MySearchDelegate? _delegate;

  _NotificationsViewState() : super();

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: _MySearchDelegate(_notifications),
    );
  }

  @override
  void initState() {
    super.initState();

    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Notifications'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              tooltip: 'Search',
              onPressed: () async {
                _showSearch(context);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        _notifications != null
            ? Expanded(
                child: ListView.builder(
                  itemCount: _notifications?.length ?? 0,
                  itemBuilder: (context, index) {
                    var notifications = _notifications ?? [];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          notifications[index]
                              .data
                              .sender
                              .substring(0, 2)
                              .toUpperCase(),
                        ),
                      ),
                      title: Text(notifications[index].data.subject),
                      subtitle: Text(
                        notifications[index].data.message,
                      ),
                      trailing: Text(
                        DateFormat.yMd().add_jms().format(
                              DateTime.parse(
                                notifications[index].createdAt,
                              ),
                            ),
                      ),
                    );
                  },
                ),
              )
            : const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ],
    );
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<notificationModel.Notification> _notifications;

  _MySearchDelegate(List<notificationModel.Notification>? notifications)
      : _notifications = notifications ?? [],
        super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
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
      tooltip: 'Back',
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
