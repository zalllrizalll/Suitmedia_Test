import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/components/user_card.dart';
import 'package:suitmedia_test/provider/selected_user_provider.dart';
import 'package:suitmedia_test/provider/user_provider.dart';
import 'package:suitmedia_test/static/sealed/user_list_result_state.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().getUserList();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !context.read<UserProvider>().isLoading &&
          context.read<UserProvider>().resultState is UserListSuccessState) {
        context.read<UserProvider>().getUserList();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Third Screen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh:
            () => context.read<UserProvider>().getUserList(isRefresh: true),
        child: Consumer<UserProvider>(
          builder: (_, provider, child) {
            return switch (provider.resultState) {
              UserListLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              UserListSuccessState(data: var userList) =>
                userList.isEmpty
                    ? const Center(
                      child: Text(
                        'No Results Found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    )
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount: userList.length + (provider.isLoading ? 1 : 0),
                      itemBuilder: (_, index) {
                        if (index >= userList.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final user = userList[index];
                        return UserCard(
                          user: user,
                          onTap: () {
                            context
                                .read<SelectedUserProvider>()
                                .setSelectedUserName(
                                  '${user.firstName} ${user.lastName}',
                                );
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
              UserListErrorState(error: var message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        message.contains('Failed host lookup') ||
                                message.contains('SocketException')
                            ? 'No Internet connection'
                            : message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserProvider>().getUserList();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              _ => const Center(
                child: Text(
                  'No Results Found',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            };
          },
        ),
      ),
    );
  }
}
