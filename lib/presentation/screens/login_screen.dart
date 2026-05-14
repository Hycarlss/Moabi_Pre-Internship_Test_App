import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen
    extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen>
      createState() =>
          _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final TextEditingController
      usernameController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;

  Future<void> login() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      'username',
      usernameController.text,
    );

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: Center(
              child:
                  SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                        24),

                child: Container(
                  width:
                      double.infinity,

                  constraints:
                      const BoxConstraints(
                    maxWidth: 420,
                  ),

                  child: Column(
                    children: [
                      // LOGO
                      Container(
                        width: 72,
                        height: 72,

                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(
                                  0xFF3B82F6),
                              Color(
                                  0xFF2563EB),
                            ],
                          ),

                          borderRadius:
                              BorderRadius.circular(
                                  22),
                        ),

                        child:
                            const Icon(
                          Icons
                              .shield_outlined,

                          color:
                              Colors.white,

                          size: 36,
                        ),
                      ),

                      const SizedBox(
                          height: 20),

                      const Text(
                        'Event Manager',

                        style:
                            TextStyle(
                          fontSize: 34,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color: Color(
                              0xFF111827),
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      Text(
                        'Manage your events and schedule',

                        textAlign:
                            TextAlign.center,

                        style:
                            TextStyle(
                          fontSize: 16,

                          color: Colors
                              .grey
                              .shade600,
                        ),
                      ),

                      const SizedBox(
                          height: 36),

                      // LOGIN CARD
                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets.all(
                                24),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                                  26),

                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .black
                                  .withOpacity(
                                      0.06),

                              blurRadius:
                                  20,

                              offset:
                                  const Offset(
                                0,
                                8,
                              ),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            const Text(
                              'Welcome Back',

                              style:
                                  TextStyle(
                                fontSize:
                                    28,

                                fontWeight:
                                    FontWeight
                                        .bold,

                                color: Color(
                                    0xFF111827),
                              ),
                            ),

                            const SizedBox(
                                height:
                                    8),

                            Text(
                              'Sign in to access your events',

                              style:
                                  TextStyle(
                                fontSize:
                                    15,

                                color: Colors
                                    .grey
                                    .shade600,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    28),

                            // USERNAME
                            const Text(
                              'Username',

                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    10),

                            TextField(
                              controller:
                                  usernameController,

                              decoration:
                                  InputDecoration(
                                hintText:
                                    'Enter your username',

                                prefixIcon:
                                    const Icon(
                                  Icons
                                      .person_outline,
                                ),

                                filled:
                                    true,

                                fillColor:
                                    const Color(
                                  0xFFF9FAFB,
                                ),

                                border:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      BorderSide(
                                    color: Colors
                                        .grey
                                        .shade200,
                                  ),
                                ),

                                enabledBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      BorderSide(
                                    color: Colors
                                        .grey
                                        .shade300,
                                  ),
                                ),

                                focusedBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      const BorderSide(
                                    color:
                                        Color(
                                      0xFF3B82F6,
                                    ),

                                    width:
                                        1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                                height:
                                    20),

                            // PASSWORD
                            const Text(
                              'Password',

                              style:
                                  TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    10),

                            TextField(
                              controller:
                                  passwordController,

                              obscureText:
                                  obscurePassword,

                              decoration:
                                  InputDecoration(
                                hintText:
                                    'Enter your password',

                                prefixIcon:
                                    const Icon(
                                  Icons
                                      .lock_outline,
                                ),

                                suffixIcon:
                                    IconButton(
                                  onPressed:
                                      () {
                                    setState(
                                        () {
                                      obscurePassword =
                                          !obscurePassword;
                                    });
                                  },

                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),

                                filled:
                                    true,

                                fillColor:
                                    const Color(
                                  0xFFF9FAFB,
                                ),

                                border:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      BorderSide(
                                    color: Colors
                                        .grey
                                        .shade200,
                                  ),
                                ),

                                enabledBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      BorderSide(
                                    color: Colors
                                        .grey
                                        .shade300,
                                  ),
                                ),

                                focusedBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          16),

                                  borderSide:
                                      const BorderSide(
                                    color:
                                        Color(
                                      0xFF3B82F6,
                                    ),

                                    width:
                                        1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                                height:
                                    16),

                            Row(
                              children: [
                                Checkbox(
                                  value:
                                      rememberMe,

                                  onChanged:
                                      (
                                    value,
                                  ) {
                                    setState(
                                        () {
                                      rememberMe =
                                          value ??
                                              false;
                                    });
                                  },
                                ),

                                const Text(
                                  'Remember me',
                                ),

                                const Spacer(),

                                TextButton(
                                  onPressed:
                                      () {},

                                  child:
                                      const Text(
                                    'Forgot password?',
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height:
                                    18),

                            // LOGIN BUTTON
                            SizedBox(
                              width:
                                  double.infinity,

                              height:
                                  56,

                              child:
                                  ElevatedButton.icon(
                                onPressed:
                                    login,

                                icon:
                                    const Icon(
                                  Icons
                                      .arrow_forward,
                                ),

                                label:
                                    const Text(
                                  'Sign In',

                                  style:
                                      TextStyle(
                                    fontSize:
                                        16,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(
                                    0xFF3B82F6,
                                  ),

                                  foregroundColor:
                                      Colors.white,

                                  elevation:
                                      4,

                                  shadowColor:
                                      const Color(
                                    0xFF3B82F6,
                                  ).withOpacity(
                                          0.3),

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                            18),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                                height:
                                    24),

                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons
                                        .shield_outlined,

                                    size:
                                        16,

                                    color: Colors
                                        .green,
                                  ),

                                  const SizedBox(
                                      width:
                                          6),

                                  Text(
                                    'Secure Event Management Platform',

                                    style:
                                        TextStyle(
                                      fontSize:
                                          13,

                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 24),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [
                          Text(
                            "Don't have an account?",

                            style:
                                TextStyle(
                              color: Colors
                                  .grey
                                  .shade700,
                            ),
                          ),

                          TextButton(
                            onPressed:
                                () {},

                            child:
                                const Text(
                              'Sign up',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -140,
          right: -80,

          child: Container(
            width: 320,
            height: 320,

            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,

              color: const Color(
                0xFF3B82F6,
              ).withOpacity(0.12),
            ),
          ),
        ),

        Positioned(
          bottom: -120,
          left: -60,

          child: Container(
            width: 260,
            height: 260,

            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,

              color: const Color(
                0xFF10B981,
              ).withOpacity(0.10),
            ),
          ),
        ),
      ],
    );
  }
}