// lib/presentation/screens/event/event_detail_screen.dart

import 'package:flutter/material.dart';

import '../../../core/providers/event_provider.dart';
import '../../../core/services/encryption_service.dart';

class EventDetailScreen
    extends StatefulWidget {
  final EventModel event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailScreen>
      createState() =>
          _EventDetailScreenState();
}

class _EventDetailScreenState
    extends State<
        EventDetailScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Event Detail',

          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight:
                FontWeight.bold,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Column(
        children: [
          // SMALL TOP TABS
          Align(
            alignment:
                Alignment.centerLeft,

            child: Container(
              margin:
                  const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),

              padding:
                  const EdgeInsets.all(
                      4),

              decoration:
                  BoxDecoration(
                color:
                    const Color(
                  0xFFF3F4F6,
                ),

                borderRadius:
                    BorderRadius
                        .circular(14),
              ),

              child: Row(
                mainAxisSize:
                    MainAxisSize.min,

                children: [
                  buildTab(
                    title:
                        'Original',
                    index: 0,
                  ),

                  buildTab(
                    title:
                        'Encrypted',
                    index: 1,
                  ),

                  buildTab(
                    title:
                        'Decrypted',
                    index: 2,
                  ),
                ],
              ),
            ),
          ),

          // PAGE CONTENT
          Expanded(
            child: AnimatedSwitcher(
              duration:
                  const Duration(
                milliseconds: 300,
              ),

              child: selectedTab == 0
                  ? buildOriginalPage(
                      event)
                  : selectedTab == 1
                      ? buildEncryptedPage(
                          event)
                      : buildDecryptedPage(
                          event),
            ),
          ),
        ],
      ),
    );
  }

  // ======================
  // SMALL TABS
  // ======================

  Widget buildTab({
    required String title,
    required int index,
  }) {
    final isSelected =
        selectedTab == index;

    return GestureDetector(
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
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(
                  0xFF3B82F6)
              : Colors.transparent,

          borderRadius:
              BorderRadius.circular(
                  10),
        ),

        child: Text(
          title,

          style: TextStyle(
            fontSize: 13,

            color: isSelected
                ? Colors.white
                : const Color(
                    0xFF6B7280),

            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ======================
  // ORIGINAL PAGE
  // ======================

  Widget buildOriginalPage(
    EventModel event,
  ) {
    return buildPageContainer(
      keyName: 'original',

      title: 'Original Input',

      subtitle:
          'User input before encryption.',

      icon: Icons.edit_note,

      children: [
        buildDataCard(
          'Title',
          event.title,
        ),

        buildDataCard(
          'Description',
          event.description,
        ),

        buildDataCard(
          'Location',
          event.location,
        ),

        buildDataCard(
          'Attendees',
          event.attendees,
        ),

        buildDataCard(
          'Date',
          '${event.date.day}/${event.date.month}/${event.date.year}',
        ),

        buildDataCard(
          'Time',
          event.time,
        ),
      ],
    );
  }

  // ======================
  // ENCRYPTED PAGE
  // ======================

  Widget buildEncryptedPage(
    EventModel event,
  ) {
    return buildPageContainer(
      keyName: 'encrypted',

      title: 'AES Encrypted Data',

      subtitle:
          'Encrypted data stored in Hive database.',

      icon: Icons.lock,

      children: [
        buildDataCard(
          'Title',
          EncryptionService
              .encryptData(
            event.title,
          ),
        ),

        buildDataCard(
          'Description',
          EncryptionService
              .encryptData(
            event.description,
          ),
        ),

        buildDataCard(
          'Location',
          EncryptionService
              .encryptData(
            event.location,
          ),
        ),

        buildDataCard(
          'Attendees',
          EncryptionService
              .encryptData(
            event.attendees,
          ),
        ),

        buildDataCard(
          'Time',
          EncryptionService
              .encryptData(
            event.time,
          ),
        ),
      ],
    );
  }

  // ======================
  // DECRYPTED PAGE
  // ======================

  Widget buildDecryptedPage(
    EventModel event,
  ) {
    return buildPageContainer(
      keyName: 'decrypted',

      title: 'Decrypted Output',

      subtitle:
          'Readable data after decryption.',

      icon: Icons.lock_open,

      children: [
        buildDataCard(
          'Title',
          event.title,
        ),

        buildDataCard(
          'Description',
          event.description,
        ),

        buildDataCard(
          'Location',
          event.location,
        ),

        buildDataCard(
          'Attendees',
          event.attendees,
        ),

        buildDataCard(
          'Date',
          '${event.date.day}/${event.date.month}/${event.date.year}',
        ),

        buildDataCard(
          'Time',
          event.time,
        ),
      ],
    );
  }

  // ======================
  // PAGE CONTAINER
  // ======================

  Widget buildPageContainer({
    required String keyName,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Widget> children,
  }) {
    return SingleChildScrollView(
      key: ValueKey(keyName),

      padding:
          const EdgeInsets.all(20),

      child: Container(
        width: double.infinity,

        padding:
            const EdgeInsets.all(22),

        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
                  0.92),

          borderRadius:
              BorderRadius.circular(
                  24),

          border: Border.all(
            color:
                const Color(
              0xFFE5E7EB,
            ),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.05),

              blurRadius: 15,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,

                  decoration:
                      BoxDecoration(
                    color:
                        const Color(
                      0xFFDBEAFE,
                    ),

                    borderRadius:
                        BorderRadius
                            .circular(
                                14),
                  ),

                  child: Icon(
                    icon,

                    color:
                        const Color(
                      0xFF3B82F6,
                    ),
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
                        title,

                        style:
                            const TextStyle(
                          fontSize: 22,

                          fontWeight:
                              FontWeight
                                  .bold,

                          color: Color(
                            0xFF111827,
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 4),

                      Text(
                        subtitle,

                        style:
                            const TextStyle(
                          color: Color(
                            0xFF6B7280,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            ...children,
          ],
        ),
      ),
    );
  }

  // ======================
  // DATA CARD
  // ======================

  Widget buildDataCard(
    String label,
    String value,
  ) {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color:
            const Color(0xFFF9FAFB),

        borderRadius:
            BorderRadius.circular(
                18),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [
          Text(
            label,

            style:
                const TextStyle(
              fontSize: 13,

              color:
                  Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 8),

          SelectableText(
            value,

            style:
                const TextStyle(
              fontSize: 15,

              fontWeight:
                  FontWeight.w600,

              color:
                  Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}