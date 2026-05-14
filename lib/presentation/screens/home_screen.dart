// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/providers/event_provider.dart';

import '../screens/event/add_event.dart';
import '../screens/event/event_detail_screen.dart';
import '../screens/event/event_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  String username = 'User';

  @override
  void initState() {
    super.initState();

    _startClock();

    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs =
        await SharedPreferences
            .getInstance();

    setState(() {
      username =
          prefs.getString(
                'username',
              ) ??
              'User';
    });
  }

  void _startClock() async {
    while (mounted) {
      await Future.delayed(
        const Duration(seconds: 1),
      );

      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<EventProvider>();

    final events = provider.events;

    final today = DateTime.now();

    final todayEvents =
        events.where((event) {
      return event.date.year ==
              today.year &&
          event.date.month ==
              today.month &&
          event.date.day ==
              today.day;
    }).toList();

    final upcomingEvents =
        events.where((event) {
      return event.date.isAfter(
        DateTime.now(),
      );
    }).toList();

    upcomingEvents.sort(
      (a, b) =>
          a.date.compareTo(b.date),
    );

    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundGradient(),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                24,
                16,
                100,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  _buildHeaderSection(),

                  const SizedBox(height: 24),

                  _buildStatRow(
                    total:
                        events.length.toString(),

                    today:
                        todayEvents.length
                            .toString(),

                    upcoming:
                        upcomingEvents.length
                            .toString(),
                  ),

                  const SizedBox(height: 24),

                  // TODAY SECTION
                  _buildSectionHeader(
                    context,
                    "Today's Schedule",
                    "${todayEvents.length} events",
                    true,
                  ),

                  todayEvents.isEmpty
                      ? _buildEmptyCard(
                          context,
                          "No events today",
                          true,
                        )
                      : Column(
                          children: [
                            ...todayEvents
                                .take(2)
                                .map(
                              (event) {
                                return _buildEventCard(
                                  context,
                                  event,
                                );
                              },
                            ),

                            if (todayEvents
                                    .length >
                                2)
                              Align(
                                alignment:
                                    Alignment
                                        .centerRight,

                                child:
                                    TextButton(
                                  onPressed:
                                      () {
                                    showModalBottomSheet(
                                      context:
                                          context,

                                      backgroundColor:
                                          Colors
                                              .transparent,

                                      isScrollControlled:
                                          true,

                                      builder:
                                          (_) {
                                        return Container(
                                          height:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.7,

                                          padding:
                                              const EdgeInsets.all(
                                                  20),

                                          decoration:
                                              const BoxDecoration(
                                            color:
                                                Colors.white,

                                            borderRadius:
                                                BorderRadius.vertical(
                                              top: Radius.circular(
                                                  28),
                                            ),
                                          ),

                                          child:
                                              Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              const Text(
                                                "Today's Events",

                                                style:
                                                    TextStyle(
                                                  fontSize:
                                                      22,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),

                                              const SizedBox(
                                                  height:
                                                      20),

                                              Expanded(
                                                child:
                                                    ListView.builder(
                                                  itemCount:
                                                      todayEvents.length,

                                                  itemBuilder:
                                                      (context, index) {
                                                    final event =
                                                        todayEvents[index];

                                                    return _buildEventCard(
                                                      context,
                                                      event,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },

                                  child:
                                      const Text(
                                    'See More',
                                  ),
                                ),
                              ),
                          ],
                        ),

                  const SizedBox(height: 24),

                  // UPCOMING SECTION
                  _buildSectionHeader(
                    context,
                    "Coming Up",
                    "${upcomingEvents.length} upcoming",
                    false,
                  ),

                  upcomingEvents.isEmpty
                      ? _buildEmptyCard(
                          context,
                          "No upcoming events",
                          false,
                        )
                      : Column(
                          children: [
                            ...upcomingEvents
                                .take(2)
                                .map(
                              (event) {
                                return _buildEventCard(
                                  context,
                                  event,
                                );
                              },
                            ),

                            if (upcomingEvents
                                    .length >
                                2)
                              Align(
                                alignment:
                                    Alignment
                                        .centerRight,

                                child:
                                    TextButton(
                                  onPressed:
                                      () {
                                    Navigator.push(
                                      context,

                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const EventListScreen(
                                          initialTab:
                                              'upcoming',
                                        ),
                                      ),
                                    );
                                  },

                                  child:
                                      const Text(
                                    'See More',
                                  ),
                                ),
                              ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      color: const Color(0xFFF0F9FF),

      child: Stack(
        children: [
          _circle(
            -80,
            140,
            400,
            const Color(
              0xFF3B82F6,
            ).withOpacity(0.1),
          ),
          _circle(
            100,
            270,
            380,
            const Color(
              0xFF10B981,
            ).withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _circle(
    double x,
    double y,
    double size,
    Color color,
  ) {
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    final now = DateTime.now();

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final formattedDate =
        '${now.day} ${months[now.month - 1]} ${now.year}';

    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            Color(0xFF3B82F6),
            Color(0xFF2563EB),
          ],
        ),
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, $username',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            formattedTime,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight:
                  FontWeight.w300,
            ),
          ),
          Text(
            formattedDate,
            style: const TextStyle(
              color:
                  Color(0xFFDBEAFE),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required String total,
    required String today,
    required String upcoming,
  }) {
    return Row(
      children: [
        _stat(
          'Total',
          total,
          const Color(
            0xFF3B82F6,
          ),
        ),
        const SizedBox(width: 10),
        _stat(
          'Today',
          today,
          const Color(
            0xFF10B981,
          ),
        ),
        const SizedBox(width: 10),
        _stat(
          'Upcoming',
          upcoming,
          const Color(
            0xFFF59E0B,
          ),
        ),
      ],
    );
  }

  Widget _stat(
    String title,
    String val,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  12),
          border: Border.all(
            color:
                const Color(
              0xFFE5E7EB,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.calendar_today,
              size: 16,
              color: color,
            ),
            const SizedBox(height: 6),
            Text(
              val,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String sub,
    bool add,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
      children: [
        Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              sub,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        if (add)
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const AddEventScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_box,
              color: Color(
                0xFF3B82F6,
              ),
              size: 30,
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyCard(
    BuildContext context,
    String msg,
    bool showBtn,
  ) {
    return Container(
      width: double.infinity,
      margin:
          const EdgeInsets.only(
        top: 12,
      ),
      padding:
          const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
                16),
        border: Border.all(
          color:
              const Color(
            0xFFE5E7EB,
          ),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_note,
            size: 40,
            color:
                Colors.grey.shade200,
          ),
          const SizedBox(height: 8),
          Text(
            msg,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          if (showBtn) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AddEventScreen(),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF3B82F6,
                ),
              ),
              child: const Text(
                'Create Event',
                style: TextStyle(
                  color:
                      Colors.white,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    EventModel event,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                EventDetailScreen(
              event: event,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin:
            const EdgeInsets.only(
          top: 12,
        ),
        padding:
            const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
                  18),
          border: Border.all(
            color:
                const Color(
              0xFFE5E7EB,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 70,
              decoration: BoxDecoration(
                color: event.color,
                borderRadius:
                    BorderRadius.circular(
                        20),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    event.title,
                    style:
                        const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  const SizedBox(
                      height: 6),
                  Text(
                    event.description,
                    maxLines: 2,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      color:
                          Colors.grey,
                    ),
                  ),
                  const SizedBox(
                      height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons
                            .calendar_today,
                        size: 14,
                        color:
                            Colors.grey,
                      ),
                      const SizedBox(
                          width: 4),
                      Text(
                        '${event.date.day}/${event.date.month}/${event.date.year}',
                      ),
                      const SizedBox(
                          width: 12),
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color:
                            Colors.grey,
                      ),
                      const SizedBox(
                          width: 4),
                      Text(event.time),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}