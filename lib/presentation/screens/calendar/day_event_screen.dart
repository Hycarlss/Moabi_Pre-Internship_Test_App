import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/event_provider.dart';
import '../event/event_detail_screen.dart';

class DayEventScreen extends StatelessWidget {
  final DateTime date;

  const DayEventScreen({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EventProvider>();

    final events =
        provider.getEventsForDate(date);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Text(
          '${date.day}/${date.month}/${date.year}',

          style: const TextStyle(
            color: Color(0xFF101828),
            fontWeight: FontWeight.w600,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFF101828),
        ),
      ),

      body: Stack(
        children: [
          Container(
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
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(16),

              child: events.isEmpty
                  ? Center(
                      child: Container(
                        padding:
                            const EdgeInsets
                                .all(24),

                        decoration:
                            BoxDecoration(
                          color: Colors.white
                              .withOpacity(
                                  0.9),

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      18),
                        ),

                        child: const Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 48,
                              color: Color(
                                0xFF9CA3AF,
                              ),
                            ),

                            SizedBox(
                                height: 16),

                            Text(
                              'No events for this day',

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          events.length,

                      itemBuilder:
                          (context, index) {
                        final event =
                            events[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EventDetailScreen(
                                  event:
                                      event,
                                ),
                              ),
                            );
                          },

                          child: Container(
                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 14,
                            ),

                            padding:
                                const EdgeInsets
                                    .all(18),

                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .white
                                  .withOpacity(
                                      0.9),

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          18),

                              border:
                                  Border.all(
                                color:
                                    const Color(
                                  0xFFE5E7EB,
                                ),
                              ),
                            ),

                            child: Row(
                              children: [
                                // COLOR LINE
                                Container(
                                  width: 10,
                                  height: 90,

                                  decoration:
                                      BoxDecoration(
                                    color: event
                                        .color,

                                    borderRadius:
                                        BorderRadius.circular(
                                            20),
                                  ),
                                ),

                                const SizedBox(
                                    width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [
                                      Text(
                                        event
                                            .title,

                                        style:
                                            const TextStyle(
                                          fontSize:
                                              18,

                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height:
                                              8),

                                      Text(
                                        event
                                            .description,

                                        maxLines:
                                            2,

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
                                              12),

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
                                            event
                                                .time,
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
          ),
        ],
      ),
    );
  }
}