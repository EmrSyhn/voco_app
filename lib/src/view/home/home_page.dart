import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voco_app/core/model/users/users_model.dart';
import 'package:voco_app/src/proivder/all_prod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProd = ref.watch(homeProvivder);
    final authProd = ref.watch(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              authProd.logout();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                // Reached the end of the list, load more data
                homeProd.usersListReq();
              }
              return false;
            },
            child: FutureBuilder(
              future: homeProd.usersListReq(),
              builder: (BuildContext context, AsyncSnapshot snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (snapShot.hasError) {
                  return Center(child: Text(snapShot.error.toString()));
                } else {
                  return ListenableBuilder(
                      listenable: homeProd,
                      builder: (context, _) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: homeProd.userList.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = homeProd.userList.data[index];
                            return GestureDetector(
                              onTap: () {
                                userDetail(context, data);
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data.avatar)),
                                    Text("${data.firstName} ${data.lastName}"),
                                    Text(data.email),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> userDetail(BuildContext context, Datum data) {
    return showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${data.firstName} ${data.lastName}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(data.avatar)),
              Text("Ad: ${data.firstName}"),
              Text("Soyad: ${data.lastName}"),
              Text("Email: ${data.email}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Kapat"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
