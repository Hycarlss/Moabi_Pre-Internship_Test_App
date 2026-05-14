// lib/presentation/screens/event/event_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/event_provider.dart';

import 'event_detail_screen.dart';
import 'add_event.dart';

class EventListScreen
    extends StatefulWidget {
  final String? initialTab;

  const EventListScreen({
    super.key,
    this.initialTab,
  });

  @override
  State<EventListScreen>
      createState() =>
          _EventListScreenState();
}

class _EventListScreenState
    extends State<
        EventListScreen> {
  int selectedTab = 0;

  // SELECTION MODE
  Set<int> selectedIndexes = {};
  bool selectionMode = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialTab ==
        'upcoming') {
      selectedTab = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<EventProvider>();

    final events = provider.events;

    final now = DateTime.now();

    final upcomingEvents =
        events.where((event) {
      return event.date.isAfter(now);
    }).toList();

    final pastEvents =
        events.where((event) {
      return event.date.isBefore(now);
    }).toList();

    // SORT
    events.sort(
      (a, b) =>
          b.date.compareTo(a.date),
    );

    upcomingEvents.sort(
      (a, b) =>
          b.date.compareTo(a.date),
    );

    pastEvents.sort(
      (a, b) =>
          b.date.compareTo(a.date),
    );

    List<EventModel> displayedEvents =
        [];

    if (selectedTab == 0) {
      displayedEvents = events;
    } else if (selectedTab == 1) {
      displayedEvents =
          upcomingEvents;
    } else {
      displayedEvents =
          pastEvents;
    }

    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      body: Stack(
        children: [
          _buildBackground(),

          SafeArea(
            child: Column(
              children: [
                // HEADER
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    20,
                    12,
                    20,
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
                              Icons.list_alt,

                              color: Color(
                                  0xFF3B82F6),

                              size: 22,
                            ),
                          ),

                          const SizedBox(
                              width: 12),

                          const Text(
                            'Event List',

                            style:
                                TextStyle(
                              fontSize: 22,

                              fontWeight:
                                  FontWeight
                                      .bold,

                              color: Color(
                                  0xFF111827),
                            ),
                          ),

                          const Spacer(),

                          // DELETE BUTTON
                          if (selectionMode)
                            GestureDetector(
                              onTap:
                                  () async {
                                final selectedEvents =
                                    selectedIndexes
                                        .map(
                                          (
                                            index,
                                          ) =>
                                              displayedEvents[
                                                  index],
                                        )
                                        .toList();

                                for (final event
                                    in selectedEvents) {
                                  await provider
                                      .deleteEvent(
                                    event,
                                  );
                                }

                                setState(() {
                                  selectedIndexes
                                      .clear();

                                  selectionMode =
                                      false;
                                });

                                if (context
                                    .mounted) {
                                  ScaffoldMessenger.of(
                                          context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text(
                                        'Selected events deleted',
                                      ),
                                    ),
                                  );
                                }
                              },

                              child:
                                  Container(
                                padding:
                                    const EdgeInsets.all(
                                        10),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      Colors.red,

                                  borderRadius:
                                      BorderRadius.circular(
                                          14),
                                ),

                                child:
                                    const Icon(
                                  Icons.delete,

                                  color: Colors
                                      .white,

                                  size: 22,
                                ),
                              ),
                            ),

                          if (selectionMode)
                            const SizedBox(
                                width:
                                    10),

                          // CHECKLIST BUTTON
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectionMode =
                                    !selectionMode;

                                selectedIndexes
                                    .clear();
                              });
                            },

                            child:
                                Container(
                              padding:
                                  const EdgeInsets.all(
                                      10),

                              decoration:
                                  BoxDecoration(
                                color: selectionMode
                                    ? Colors
                                        .orange
                                    : Colors
                                        .white,

                                borderRadius:
                                    BorderRadius.circular(
                                        14),
                              ),

                              child:
                                  Icon(
                                Icons
                                    .checklist,

                                color: selectionMode
                                    ? Colors
                                        .white
                                    : const Color(
                                        0xFF3B82F6),

                                size: 22,
                              ),
                            ),
                          ),

                          const SizedBox(
                              width: 10),

                          // ADD BUTTON
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          const AddEventScreen(),
                                ),
                              );
                            },

                            child:
                                Container(
                              padding:
                                  const EdgeInsets.all(
                                      10),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFF3B82F6,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                        14),
                              ),

                              child:
                                  const Icon(
                                Icons.add,

                                color:
                                    Colors
                                        .white,

                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 28),

                      const Text(
                        'Events',

                        style: TextStyle(
                          fontSize: 28,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color: Color(
                              0xFF111827),
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      Text(
                        'Manage your events and schedule',

                        style:
                            TextStyle(
                          fontSize: 15,

                          color: Colors
                              .grey
                              .shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 24),

                // TABS
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),

                  child: Row(
                    children: [
                      buildTab(
                        title: 'All',
                        index: 0,
                      ),

                      const SizedBox(
                          width: 10),

                      buildTab(
                        title:
                            'Upcoming',
                        index: 1,
                      ),

                      const SizedBox(
                          width: 10),

                      buildTab(
                        title: 'Past',
                        index: 2,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 20),

                // EVENT LIST
                Expanded(
                  child:
                      displayedEvents
                              .isEmpty
                          ? const Center(
                              child: Text(
                                'No Events Found',
                              ),
                            )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.all(
                                      20),

                              itemCount:
                                  displayedEvents
                                      .length,

                              itemBuilder:
                                  (context,
                                      index) {
                                final event =
                                    displayedEvents[
                                        index];

                                final isPast =
                                    event
                                        .date
                                        .isBefore(
                                  now,
                                );

                                return GestureDetector(
                                  onTap:
                                      () {
                                    if (!selectionMode) {
                                      Navigator.push(
                                        context,

                                        MaterialPageRoute(
                                          builder:
                                              (_) =>
                                                  EventDetailScreen(
                                            event:
                                                event,
                                          ),
                                        ),
                                      );
                                    }
                                  },

                                  child:
                                      Container(
                                    margin:
                                        const EdgeInsets.only(
                                      bottom:
                                          16,
                                    ),

                                    padding:
                                        const EdgeInsets.all(
                                            18),

                                    decoration:
                                        BoxDecoration(
                                      color:
                                          Colors.white,

                                      borderRadius:
                                          BorderRadius.circular(
                                              22),

                                      border:
                                          Border.all(
                                        color:
                                            const Color(
                                          0xFFE5E7EB,
                                        ),
                                      ),

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors
                                              .black
                                              .withOpacity(
                                                  0.03),

                                          blurRadius:
                                              10,
                                        ),
                                      ],
                                    ),

                                    child:
                                        Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        // CHECKBOX
                                        if (selectionMode)
                                          Checkbox(
                                            value:
                                                selectedIndexes
                                                    .contains(
                                              index,
                                            ),

                                            onChanged:
                                                (
                                              value,
                                            ) {
                                              setState(
                                                  () {
                                                if (value ==
                                                    true) {
                                                  selectedIndexes
                                                      .add(
                                                    index,
                                                  );
                                                } else {
                                                  selectedIndexes
                                                      .remove(
                                                    index,
                                                  );
                                                }
                                              });
                                            },
                                          ),

                                        // LEFT BAR
                                        Container(
                                          width:
                                              6,

                                          height:
                                              90,

                                          decoration:
                                              BoxDecoration(
                                            color: isPast
                                                ? Colors.grey
                                                : event.color,

                                            borderRadius:
                                                BorderRadius.circular(
                                                    20),
                                          ),
                                        ),

                                        const SizedBox(
                                            width:
                                                14),

                                        Expanded(
                                          child:
                                              Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        Text(
                                                      event.title,

                                                      style:
                                                          TextStyle(
                                                        fontSize:
                                                            18,

                                                        fontWeight:
                                                            FontWeight.bold,

                                                        color: isPast
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xFF111827),
                                                      ),
                                                    ),
                                                  ),

                                                  if (isPast)
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                        horizontal:
                                                            10,

                                                        vertical:
                                                            4,
                                                      ),

                                                      decoration:
                                                          BoxDecoration(
                                                        color:
                                                            Colors.grey.shade200,

                                                        borderRadius:
                                                            BorderRadius.circular(20),
                                                      ),

                                                      child:
                                                          const Text(
                                                        'Past',

                                                        style:
                                                            TextStyle(
                                                          fontSize:
                                                              11,

                                                          color:
                                                              Colors.grey,

                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),

                                              const SizedBox(
                                                  height:
                                                      8),

                                              Text(
                                                event.description,

                                                maxLines:
                                                    2,

                                                overflow:
                                                    TextOverflow.ellipsis,

                                                style:
                                                    TextStyle(
                                                  color: isPast
                                                      ? Colors.grey
                                                      : Colors.black54,
                                                ),
                                              ),

                                              const SizedBox(
                                                  height:
                                                      14),

                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_today,

                                                    size:
                                                        14,

                                                    color: isPast
                                                        ? Colors.grey
                                                        : Colors.black54,
                                                  ),

                                                  const SizedBox(
                                                      width:
                                                          4),

                                                  Text(
                                                    '${event.date.day}/${event.date.month}/${event.date.year}',
                                                  ),

                                                  const SizedBox(
                                                      width:
                                                          12),

                                                  Icon(
                                                    Icons.access_time,

                                                    size:
                                                        14,

                                                    color: isPast
                                                        ? Colors.grey
                                                        : Colors.black54,
                                                  ),

                                                  const SizedBox(
                                                      width:
                                                          4),

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
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab({
    required String title,
    required int index,
  }) {
    final isSelected =
        selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },

        child: AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 250,
          ),

          padding:
              const EdgeInsets.symmetric(
            vertical: 12,
          ),

          decoration: BoxDecoration(
            color: isSelected
                ? const Color(
                    0xFF3B82F6)
                : Colors.white,

            borderRadius:
                BorderRadius.circular(
                    14),

            border: Border.all(
              color: isSelected
                  ? const Color(
                      0xFF3B82F6)
                  : const Color(
                      0xFFE5E7EB),
            ),
          ),

          child: Text(
            title,

            textAlign:
                TextAlign.center,

            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : const Color(
                      0xFF6B7280),

              fontWeight:
                  FontWeight.w600,
            ),
          ),
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