import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:connectify/common/utils/utils.dart';
import 'package:connectify/constants/appwrite_constants.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Client client =
      Client().setEndpoint(APPWRITE_URL).setProject(APPWRITE_PROJECT_ID);

  Future<void> loginuser(String email, String password) async {
    Account account = Account(client);
    await account.createEmailPasswordSession(email: email, password: password);
    final user = await account.get();
  }

  Future<void> registerUser(String name, String email, String password) async {
    Account account = Account(client);
    await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
  }

  Future<void> registerUserWithGoogle(BuildContext context) async {
    Account account = Account(client);
    account.createOAuth2Session(provider: OAuthProvider.google).then((_) {
      final user = Account(client);
      showSnackBar(context, "Success, user is $user");
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString() + stackTrace.toString());
    });
  }

  Future<User> getUser() async {
    Account account = Account(client);
    final user = await account.get();
    return user;
  }
}
