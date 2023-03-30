import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../AppConst/app_colors.dart';
import '../Provider/user_provider.dart';
import '../const_widgets/const_dialogs.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, value, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("User List")),
          body: Container(
            child: value.userData.users == null
                ? const SizedBox()
                : ListView.builder(
                    itemCount: value.userData.users?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showSnackBar(
                                value.userData.users?[index].firstName);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  value.userData.users?[index].firstName ?? "",
                                  style:
                                      const TextStyle(color: AppColors.black)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
