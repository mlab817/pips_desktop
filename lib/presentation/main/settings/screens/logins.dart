import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pips/domain/usecase/logins_usecase.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../../app/dep_injection.dart';
import '../../../../data/responses/logins/logins_response.dart';
import '../../../../domain/usecase/base_usecase.dart';
import '../../../resources/strings_manager.dart';

class LoginsView extends StatefulWidget {
  const LoginsView({Key? key}) : super(key: key);

  @override
  State<LoginsView> createState() => _LoginsViewState();
}

class _LoginsViewState extends State<LoginsView> {
  final LoginsUseCase _loginsUseCase = instance<LoginsUseCase>();

  Future<Result<LoginsResponse>> _getLogins() async {
    return _loginsUseCase.execute(null);
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
              AsyncSnapshot<Result<LoginsResponse>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final list = snapshot.data?.data?.data ?? [];

                return ListView.separated(
                  itemCount: snapshot.data?.data?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index].userAgent),
                      subtitle: Text(DateFormat.yMMMd()
                          .add_jms()
                          .format(DateTime.parse(list[index].createdAt))),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
