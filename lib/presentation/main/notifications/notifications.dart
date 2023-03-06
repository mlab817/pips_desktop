import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:pips/data/responses/notifications/notifications_response.dart';
import 'package:pips/domain/usecase/notifications_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';

import '../../../domain/models/notification.dart' as notificationModel;
import '../../../domain/usecase/base_usecase.dart';
import '../../resources/strings_manager.dart';

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
        _notifications != null
            ? Expanded(
                child: ListView.separated(
                  itemCount: _notifications?.length ?? 0,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    var notifications = _notifications ?? [];

                    return ListTile(
                      leading: Icon(
                        Icons.mark_email_unread_outlined,
                        // TODO: if mark as read should return to default
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        notifications[index].data.subject,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
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
                                icon: const Icon(Icons.mark_email_unread),
                                content:
                                    Text(notifications[index].data.message),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(AppStrings.cancel)),
                                  ElevatedButton(
                                    onPressed: () {
                                      // handle mark as read
                                    },
                                    child: const Text(AppStrings.markAsRead),
                                  ),
                                ],
                              );
                            });
                      },
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
