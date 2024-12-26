import 'package:connectify/features/views/authentication/sign-up/sign_up_page.dart';
import 'package:connectify/features/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("connectify-00d");
  Account account = Account(client);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpPage(),
        '/post': (context) => const PostPage(),
      },
    );
  }
}

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Center(
        child: postId != null
            ? Text('Viewing Post ID: $postId')
            : const Text('No Post ID Found'),
      ),
    );
  }
}
