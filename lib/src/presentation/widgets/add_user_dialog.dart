import 'package:courses_app/src/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({required this.nameController, super.key});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final name = nameController.text.trim();
                          context.read<AuthCubit>().createUser(
                                createdAt: DateTime.now().toString(),
                                name: name,
                                avatar: 'https://i.pravatar.cc/150?u=$name',
                              );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Create User'))
                  ],
                ))));
  }
}
