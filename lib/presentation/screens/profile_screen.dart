import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/app_theme.dart';

class ProfileScreen
    extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  Future<String> getUsername() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
          'username',
        ) ??
        'User';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: FutureBuilder<
                String>(
              future: getUsername(),

              builder:
                  (context, snapshot) {
                final username =
                    snapshot.data ??
                        'User';

                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.all(
                          24),

                  child: Column(
                    children: [
                      // HEADER
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(
                          0,
                          0,
                          0,
                          0,
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Row(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.all(
                                          10),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        Colors.white,

                                    borderRadius:
                                        BorderRadius.circular(
                                            14),
                                  ),

                                  child:
                                      const Icon(
                                    Icons.person,

                                    color:
                                        AppTheme.primaryBlue,

                                    size: 22,
                                  ),
                                ),

                                const SizedBox(
                                    width:
                                        12),

                                const Text(
                                  'Profile',

                                  style:
                                      TextStyle(
                                    fontSize:
                                        22,

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    color: Color(
                                        0xFF111827),
                                  ),
                                ),

                                const Spacer(),

                                IconButton(
                                  icon:
                                      const Icon(
                                    Icons
                                        .settings_outlined,
                                  ),

                                  onPressed:
                                      () {},
                                ),
                              ],
                            ),

                            const SizedBox(
                                height:
                                    28),

                            const Text(
                              'My Profile',

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
                                    6),

                            Text(
                              'Manage your profile and account',

                              style:
                                  TextStyle(
                                fontSize:
                                    15,

                                color: Colors
                                    .grey
                                    .shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 40),

                      // PROFILE CARD
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
                                  24),

                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .black
                                  .withOpacity(
                                      0.05),

                              blurRadius:
                                  12,

                              offset:
                                  const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            Stack(
                              children: [
                                const CircleAvatar(
                                  radius:
                                      52,

                                  backgroundColor:
                                      AppTheme.primaryBlue,

                                  child:
                                      Icon(
                                    Icons
                                        .person,

                                    size:
                                        52,

                                    color:
                                        Colors.white,
                                  ),
                                ),

                                Positioned(
                                  bottom:
                                      0,

                                  right:
                                      0,

                                  child:
                                      Container(
                                    decoration:
                                        BoxDecoration(
                                      color:
                                          Colors.white,

                                      shape:
                                          BoxShape.circle,

                                      border:
                                          Border.all(
                                        color:
                                            Colors.white,

                                        width:
                                            2,
                                      ),
                                    ),

                                    child:
                                        IconButton(
                                      icon:
                                          const Icon(
                                        Icons
                                            .edit,

                                        size:
                                            18,
                                      ),

                                      onPressed:
                                          () {},

                                      constraints:
                                          const BoxConstraints(),

                                      padding:
                                          const EdgeInsets.all(
                                              8),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height:
                                    20),

                            Text(
                              username,

                              style:
                                  theme
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height:
                                    6),

                            Text(
                              'Event Manager User',

                              style:
                                  theme
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                color:
                                    AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      // STATS
                      Container(
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                                  20),

                          boxShadow: [
                            BoxShadow(
                              color: Colors
                                  .black
                                  .withOpacity(
                                      0.05),

                              blurRadius:
                                  10,

                              offset:
                                  const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            _buildStatTile(
                              context,

                              'Events Organized',

                              '12',

                              Icons
                                  .event_available_outlined,
                            ),

                            const Divider(
                                height:
                                    1),

                            _buildStatTile(
                              context,

                              'Events Attended',

                              '48',

                              Icons
                                  .event_note_outlined,
                            ),

                            const Divider(
                                height:
                                    1),

                            _buildStatTile(
                              context,

                              'Followers',

                              '245',

                              Icons
                                  .people_outline,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      // LOGOUT
                      SizedBox(
                        width:
                            double.infinity,

                        child:
                            ElevatedButton.icon(
                          onPressed:
                              () async {
                            final prefs =
                                await SharedPreferences
                                    .getInstance();

                            await prefs
                                .remove(
                              'username',
                            );

                            if (context
                                .mounted) {
                              context.go(
                                  '/login');
                            }
                          },

                          icon:
                              const Icon(
                            Icons.logout,
                          ),

                          label:
                              const Text(
                            'Logout',

                            style:
                                TextStyle(
                              fontSize:
                                  16,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red,

                            foregroundColor:
                                Colors.white,

                            padding:
                                const EdgeInsets.symmetric(
                              vertical:
                                  16,
                            ),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(
    BuildContext context,
    String title,
    String count,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        padding:
            const EdgeInsets.all(8),

        decoration: BoxDecoration(
          color:
              AppTheme.backgroundLight,

          borderRadius:
              BorderRadius.circular(
                  10),
        ),

        child: Icon(
          icon,
          color:
              AppTheme.primaryBlue,
        ),
      ),

      title: Text(
        title,
        style:
            theme.textTheme.bodyLarge,
      ),

      trailing: Text(
        count,

        style: theme
            .textTheme.titleMedium
            ?.copyWith(
          color:
              AppTheme.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: const Color(0xFFF0F9FF),

      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,

            child: Container(
              width: 300,
              height: 300,

              decoration:
                  BoxDecoration(
                color: const Color(
                  0xFF3B82F6,
                ).withOpacity(0.1),

                shape:
                    BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            left: -80,

            child: Container(
              width: 260,
              height: 260,

              decoration:
                  BoxDecoration(
                color: const Color(
                  0xFF10B981,
                ).withOpacity(0.1),

                shape:
                    BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}