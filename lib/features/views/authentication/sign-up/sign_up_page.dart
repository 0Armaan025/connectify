import 'package:connectify/features/repositories/auth_repository.dart';
import 'package:connectify/pallete/pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSignUp = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signUpWithGoogle(BuildContext context) async {
    await AuthRepository().registerUserWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Pallete().bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                  left: 24,
                  right: 24,
                ),
                child: Text(
                  "Go ahead and set up your account",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 24,
                  right: 4,
                ),
                child: Text(
                  "Sign in-up to enjoy the best social-media experience...",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: size.height * 0.71,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: HexColor("#101214"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    // Toggle Tab
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15)
                          .copyWith(top: 20),
                      width: double.infinity,
                      height: size.height * 0.09,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: HexColor("#45464f"),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSignUp = true;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 18,
                                top: 10,
                                bottom: 10,
                              ),
                              width: size.width * 0.35,
                              height: size.height * 0.08,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSignUp
                                    ? HexColor("#60616b")
                                    : HexColor("#3d3e45"),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSignUp = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              width: size.width * 0.35,
                              height: size.height * 0.08,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: !isSignUp
                                    ? HexColor("#60616b")
                                    : HexColor("#3d3e45"),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Log In",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSignUp)
                      Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        margin: const EdgeInsets.symmetric(horizontal: 20)
                            .copyWith(top: 20),
                        decoration: BoxDecoration(
                          color: HexColor("#1E1F24"),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Icon(
                              Icons.person,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                controller: _nameController,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Your real name (not public)",
                                  hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey.shade500,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Email Field
                    Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      margin: const EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(top: 20),
                      decoration: BoxDecoration(
                        color: HexColor("#1E1F24"),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            Icons.email,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: _emailController,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Password Field
                    Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      margin: const EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(top: 20),
                      decoration: BoxDecoration(
                        color: HexColor("#1E1F24"),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Icon(
                            Icons.password,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: _passController,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: GoogleFonts.poppins(
                                  color: Colors.grey.shade500,
                                ),
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Sign Up/Log In Button
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 25)
                            .copyWith(top: 20),
                        decoration: BoxDecoration(
                          color: HexColor("#45464f"),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Text(
                          isSignUp ? "Sign Up" : "Log In",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text("or",
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        signUpWithGoogle(context);
                      },
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: size.height * 0.08,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            // color: HexColor("#45464f"),
                            border: Border.all(
                              color: HexColor("#45464f"),
                            ),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/128/300/300221.png"),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Text(
                                "Use google",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
