// lib/presentation/screens/calendar/manage_calendar.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/event_provider.dart';
import '../event/event_detail_screen.dart';
import 'day_event_screen.dart';

class ManageCalendarScreen
    extends StatefulWidget {
  const ManageCalendarScreen({
    super.key,
  });

  @override
  State<ManageCalendarScreen>
      createState() =>
          _ManageCalendarScreenState();
}

class _ManageCalendarScreenState
    extends State<
        ManageCalendarScreen> {
  final List<String> weekDays = [
    'S',
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  _buildHeader(),

                  const SizedBox(height: 24),

                  const Text(
                    'Calendar',

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Manage your events and schedule',

                    style: TextStyle(
                      color:
                          Color(0xFF6B7280),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildCalendarCard(),

                  const SizedBox(height: 20),

                  _buildTodayEventBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Color(0xFFF0F9FF),
            Color(0xFFE0F2FE),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding:
              const EdgeInsets.all(8),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: const Icon(
            Icons.calendar_month,
            color: Color(0xFF3B82F6),
          ),
        ),

        const SizedBox(width: 12),

        const Text(
          'Event Calendar',

          style: TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return Consumer<EventProvider>(
      builder: (context, provider, child) {
        return Container(
          padding:
              const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
                    0.9),

            borderRadius:
                BorderRadius.circular(20),

            border: Border.all(
              color:
                  const Color(0xFFE5E7EB),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.04),

                blurRadius: 10,
              ),
            ],
          ),

          child: Column(
            children: [
              const Text(
                'May 2026',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceAround,

                children: weekDays.map((d) {
                  return Text(
                    d,

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 14),

              GridView.builder(
                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),

                itemCount: 35,

                itemBuilder:
                    (context, index) {
                  int day = index - 3;

                  bool isOtherMonth =
                      day <= 0 ||
                          day > 31;

                  if (isOtherMonth) {
                    return Container();
                  }

                  final date = DateTime(
                    2026,
                    5,
                    day,
                  );

                  final events = provider
                      .getEventsForDate(
                    date,
                  );

                  final isToday =
                      date.day ==
                              DateTime.now()
                                  .day &&
                          date.month ==
                              DateTime.now()
                                  .month &&
                          date.year ==
                              DateTime.now()
                                  .year;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DayEventScreen(
                            date: date,
                          ),
                        ),
                      );
                    },

                    child: Container(
                      decoration:
                          BoxDecoration(
                        color: isToday
                            ? const Color(
                                0xFF3B82F6)
                            : Colors
                                .transparent,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    10),
                      ),

                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '$day',

                              style:
                                  TextStyle(
                                color: isToday
                                    ? Colors
                                        .white
                                    : Colors
                                        .black,
                              ),
                            ),
                          ),

                          if (events
                              .isNotEmpty)
                            Positioned(
                              bottom: 6,
                              right: 6,

                              child:
                                  Container(
                                width: 8,
                                height: 8,

                                decoration:
                                    BoxDecoration(
                                  color: events
                                      .first
                                      .color,

                                  shape: BoxShape
                                      .circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTodayEventBox() {
    return Consumer<EventProvider>(
      builder: (context, provider, child) {
        final today = DateTime.now();

        final todayEvents = provider
            .getEventsForDate(today);

        return Container(
          width: double.infinity,

          padding:
              const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
                    0.9),

            borderRadius:
                BorderRadius.circular(18),

            border: Border.all(
              color:
                  const Color(0xFFE5E7EB),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.04),

                blurRadius: 10,
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const Row(
                children: [
                  Icon(
                    Icons.today,
                    color: Color(0xFF3B82F6),
                  ),

                  SizedBox(width: 8),

                  Text(
                    'Today',

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF111827),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              if (todayEvents.isEmpty)
                const Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(
                      vertical: 20,
                    ),

                    child: Text(
                      'No events today',

                      style: TextStyle(
                        color:
                            Color(0xFF6B7280),
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  children:
                      todayEvents.map((event) {
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
                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),

                        padding:
                            const EdgeInsets.all(
                                14),

                        decoration:
                            BoxDecoration(
                          color: event.color
                              .withOpacity(
                                  0.1),

                          borderRadius:
                              BorderRadius.circular(
                                  14),
                        ),

                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 70,

                              decoration:
                                  BoxDecoration(
                                color:
                                    event.color,

                                borderRadius:
                                    BorderRadius.circular(
                                        20),
                              ),
                            ),

                            const SizedBox(
                                width: 14),

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
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                      fontSize:
                                          16,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  Text(
                                    event
                                        .description,

                                    maxLines: 2,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(
                                      color:
                                          Color(
                                        0xFF6B7280,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          10),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .access_time,
                                        size:
                                            16,

                                        color:
                                            Color(
                                          0xFF6B7280,
                                        ),
                                      ),

                                      const SizedBox(
                                          width:
                                              8),

                                      Text(
                                        event.time,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}