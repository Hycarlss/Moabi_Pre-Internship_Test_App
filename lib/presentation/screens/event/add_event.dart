// lib/presentation/screens/event/add_event.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/event_provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() =>
      _AddEventScreenState();
}

class _AddEventScreenState
    extends State<AddEventScreen> {
  final TextEditingController
      titleController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  final TextEditingController
      locationController =
      TextEditingController();

  final TextEditingController
      attendeesController =
      TextEditingController();

  DateTime selectedDate =
      DateTime.now();

  TimeOfDay selectedTime =
      TimeOfDay.now();

  Color selectedColor =
      const Color(0xFF3B82F6);

  final List<Color> eventColors = [
    const Color(0xFF3B82F6),
    const Color(0xFF10B981),
    const Color(0xFFF59E0B),
    const Color(0xFFEF4444),
    const Color(0xFF8B5CF6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF0F9FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Create Event',

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

      body: Container(
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

        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              const Text(
                'Create New Event',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Fill in the event details below.',

                style: TextStyle(
                  fontSize: 14,
                  color:
                      Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                padding:
                    const EdgeInsets
                        .all(20),

                decoration:
                    BoxDecoration(
                  color: Colors.white
                      .withOpacity(
                          0.92),

                  borderRadius:
                      BorderRadius
                          .circular(24),

                  border: Border.all(
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
                              0.05),

                      blurRadius: 15,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    buildField(
                      title:
                          'Event Title',

                      hint:
                          'Enter event title',

                      controller:
                          titleController,
                    ),

                    buildField(
                      title:
                          'Description',

                      hint:
                          'Enter event description',

                      controller:
                          descriptionController,

                      maxLines: 4,
                    ),

                    buildField(
                      title: 'Location',

                      hint:
                          'Enter location',

                      controller:
                          locationController,
                    ),

                    buildField(
                      title:
                          'Attendees',

                      hint:
                          'Estimated attendees',

                      controller:
                          attendeesController,
                    ),

                    const SizedBox(
                        height: 18),

                    buildPickerCard(
                      title:
                          'Event Date',

                      value:
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',

                      icon: Icons
                          .calendar_today,

                      onTap: () async {
                        final picked =
                            await showDatePicker(
                          context:
                              context,

                          initialDate:
                              selectedDate,

                          firstDate:
                              DateTime(
                                  2024),

                          lastDate:
                              DateTime(
                                  2030),
                        );

                        if (picked !=
                            null) {
                          setState(() {
                            selectedDate =
                                picked;
                          });
                        }
                      },
                    ),

                    const SizedBox(
                        height: 16),

                    buildPickerCard(
                      title:
                          'Event Time',

                      value:
                          selectedTime
                              .format(
                                  context),

                      icon: Icons
                          .access_time,

                      onTap: () async {
                        final picked =
                            await showTimePicker(
                          context:
                              context,

                          initialTime:
                              selectedTime,
                        );

                        if (picked !=
                            null) {
                          setState(() {
                            selectedTime =
                                picked;
                          });
                        }
                      },
                    ),

                    const SizedBox(
                        height: 18),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFF9FAFB,
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    16),
                      ),

                      child:
                          DropdownButton<
                              Color>(
                        value:
                            selectedColor,

                        isExpanded:
                            true,

                        underline:
                            const SizedBox(),

                        items:
                            eventColors
                                .map(
                          (color) {
                            return DropdownMenuItem(
                              value:
                                  color,

                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        20,

                                    height:
                                        20,

                                    decoration:
                                        BoxDecoration(
                                      color:
                                          color,

                                      shape:
                                          BoxShape.circle,
                                    ),
                                  ),

                                  const SizedBox(
                                      width:
                                          12),

                                  const Text(
                                    'Event Color',
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (value) {
                          setState(() {
                            selectedColor =
                                value!;
                          });
                        },
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(
                      width:
                          double.infinity,

                      height: 58,

                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFF3B82F6,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),
                        ),

                        onPressed:
                            () async {
                          if (titleController
                              .text
                              .isEmpty) {
                            return;
                          }

                          await context
                              .read<
                                  EventProvider>()
                              .addEvent(
                                EventModel(
                                  title:
                                      titleController
                                          .text,

                                  description:
                                      descriptionController
                                          .text,

                                  location:
                                      locationController
                                          .text,

                                  attendees:
                                      attendeesController
                                          .text,

                                  date:
                                      selectedDate,

                                  time:
                                      selectedTime
                                          .format(
                                              context),

                                  color:
                                      selectedColor,
                                ),
                              );

                          await Future.delayed(
                            const Duration(
                              milliseconds:
                                  500,
                            ),
                          );

                          if (context
                              .mounted) {
                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              const SnackBar(
                                content:
                                    Text(
                                  'Event Saved Successfully',
                                ),
                              ),
                            );

                            Navigator.pop(
                                context);
                          }
                        },

                        child:
                            const Text(
                          'Save Event',

                          style:
                              TextStyle(
                            color:
                                Colors
                                    .white,

                            fontSize: 18,

                            fontWeight:
                                FontWeight
                                    .w600,
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

  Widget buildField({
    required String title,
    required String hint,
    required TextEditingController
        controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [
          Text(
            title,

            style: const TextStyle(
              fontWeight:
                  FontWeight.w600,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: controller,

            maxLines: maxLines,

            decoration:
                InputDecoration(
              hintText: hint,

              filled: true,

              fillColor:
                  const Color(
                0xFFF9FAFB,
              ),

              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius
                        .circular(
                            16),

                borderSide:
                    BorderSide.none,
              ),

              contentPadding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 18,
                vertical: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPickerCard({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),

      onTap: onTap,

      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        decoration: BoxDecoration(
          color:
              const Color(0xFFF9FAFB),

          borderRadius:
              BorderRadius.circular(
                  18),
        ),

        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color:
                    const Color(
                  0xFFDBEAFE,
                ),

                borderRadius:
                    BorderRadius
                        .circular(
                            12),
              ),

              child: Icon(
                icon,

                color:
                    const Color(
                  0xFF3B82F6,
                ),
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
                    title,

                    style:
                        const TextStyle(
                      fontSize: 13,

                      color: Color(
                        0xFF6B7280,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 2),

                  Text(
                    value,

                    style:
                        const TextStyle(
                      fontSize: 16,

                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,

              color:
                  Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}