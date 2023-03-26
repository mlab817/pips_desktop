import 'package:dartz/dartz.dart' as dart_state;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/usecase/logins_usecase.dart';
import 'package:pips/presentation/resources/sizes_manager.dart';
import 'package:skeletons/skeletons.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../app/dep_injection.dart';
import '../../../../data/network/failure.dart';
import '../../../../data/responses/logins/logins_response.dart';
import '../../../resources/strings_manager.dart';

class LoginsView extends StatefulWidget {
  const LoginsView({Key? key}) : super(key: key);

  @override
  State<LoginsView> createState() => _LoginsViewState();
}

class _LoginsViewState extends State<LoginsView> {
  final LoginsUseCase _loginsUseCase = instance<LoginsUseCase>();

  Future<dart_state.Either<Failure, LoginsResponse>> _getLogins() async {
    return await _loginsUseCase.execute(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !UniversalPlatform.isDesktopOrWeb,
        title: const Text(AppStrings.logins),
      ),
      body: FutureBuilder(
        future: _getLogins(),
        builder: (BuildContext context,
            AsyncSnapshot<dart_state.Either<Failure, LoginsResponse>>
                snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data;

              return data?.fold((failure) {
                    return Center(
                      child: Text(failure.message),
                    );
                  }, (response) {
                    final list = response.data;

                    return ListView.separated(
                      itemCount: response.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.event_note),
                          title: Text(list[index].userAgent),
                          subtitle: Text(DateFormat.yMMMd()
                              .add_jms()
                              .format(DateTime.parse(list[index].createdAt))),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Theme.of(context).dividerColor,
                        );
                      },
                    );
                  }) ??
                  Container();
            }
          }

          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(AppPadding.md),
                child: SkeletonListTile(
                  hasSubtitle: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
