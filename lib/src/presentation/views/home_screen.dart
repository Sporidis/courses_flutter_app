import 'package:courses_app/src/presentation/cubit/auth_cubit.dart';
import 'package:courses_app/src/presentation/widgets/add_user_dialog.dart';
import 'package:courses_app/src/presentation/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        } else if (state is UserCreated) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('User created successfully'),
          ));
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Getting Users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              leading: Image.network(user.avatar),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt.substring(10)),
                            );
                          },
                        ))
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) =>
                      AddUserDialog(nameController: nameController));
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User'),
          ),
        );
      },
    );
  }
}
