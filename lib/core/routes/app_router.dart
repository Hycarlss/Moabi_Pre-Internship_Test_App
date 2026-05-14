// lib/core/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// LAYOUT
import '../../presentation/layouts/main_layout.dart';

/// SCREENS
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/profile_screen.dart';

/// CALENDAR
import '../../presentation/screens/calendar/manage_calendar.dart';

/// EVENTS
import '../../presentation/screens/event/event_list.dart';
import '../../presentation/screens/event/add_event.dart';

/// ROOT NAVIGATOR
final GlobalKey<NavigatorState>
    _rootNavigatorKey =
    GlobalKey<NavigatorState>();

/// ROUTER
final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  navigatorKey: _rootNavigatorKey,

  routes: [
    /// LOGIN
    GoRoute(
      path: '/login',

      builder: (context, state) =>
          const LoginScreen(),
    ),

    /// MAIN LAYOUT
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) {
        return MainLayout(
          navigationShell: navigationShell,
        );
      },

      branches: [
        /// HOME
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',

              builder: (context, state) =>
                  const HomeScreen(),
            ),
          ],
        ),

        /// CALENDAR
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calendar',

              builder: (context, state) =>
                  const ManageCalendarScreen(),
            ),
          ],
        ),

        /// EVENTS
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/events',

              builder: (context, state) =>
                  const EventListScreen(),

              routes: [
                GoRoute(
                  path: 'add',

                  parentNavigatorKey:
                      _rootNavigatorKey,

                  builder:
                      (context, state) =>
                          const AddEventScreen(),
                ),
              ],
            ),
          ],
        ),

        /// PROFILE
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',

              builder: (context, state) =>
                  const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);