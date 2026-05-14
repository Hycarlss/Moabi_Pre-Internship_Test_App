// lib/core/providers/event_provider.dart

import 'package:flutter/material.dart';

import '../services/encryption_service.dart';
import '../services/local_storage_service.dart';

class EventModel {
  final String title;
  final String description;
  final String location;
  final String attendees;
  final DateTime date;
  final String time;
  final Color color;

  EventModel({
    required this.title,
    required this.description,
    required this.location,
    required this.attendees,
    required this.date,
    required this.time,
    required this.color,
  });
}

class EventProvider
    extends ChangeNotifier {
  final List<EventModel> _events =
      [];

  List<EventModel> get events =>
      _events;

  // ADD EVENT
  Future<void> addEvent(
    EventModel event,
  ) async {
    _events.add(event);

    await saveEvents();

    notifyListeners();
  }

  // DELETE EVENT
  Future<void> deleteEvent(
    EventModel event,
  ) async {
    _events.remove(event);

    await saveEvents();

    notifyListeners();
  }

  // SAVE EVENTS
  Future<void> saveEvents() async {
    final box =
        LocalStorageService.getBox();

    final List<Map<String, dynamic>>
        encryptedEvents = _events.map(
      (event) {
        return {
          'title':
              EncryptionService
                  .encryptData(
            event.title,
          ),

          'description':
              EncryptionService
                  .encryptData(
            event.description,
          ),

          'location':
              EncryptionService
                  .encryptData(
            event.location,
          ),

          'attendees':
              EncryptionService
                  .encryptData(
            event.attendees,
          ),

          'date':
              event.date
                  .toIso8601String(),

          'time':
              EncryptionService
                  .encryptData(
            event.time,
          ),

          'color':
              event.color.value,
        };
      },
    ).toList();

    await box.put(
      'events',
      encryptedEvents,
    );

    await box.flush();
  }

  // LOAD EVENTS
  Future<void> loadEvents() async {
    final box =
        LocalStorageService.getBox();

    final data = box.get('events');

    if (data == null) return;

    _events.clear();

    try {
      final List<dynamic> events =
          List<dynamic>.from(data);

      for (var item in events) {
        final map =
            Map<String, dynamic>.from(
          item,
        );

        _events.add(
          EventModel(
            title:
                EncryptionService
                    .decryptData(
              map['title'],
            ),

            description:
                EncryptionService
                    .decryptData(
              map['description'],
            ),

            location:
                EncryptionService
                    .decryptData(
              map['location'],
            ),

            attendees:
                EncryptionService
                    .decryptData(
              map['attendees'],
            ),

            date: DateTime.parse(
              map['date'],
            ),

            time:
                EncryptionService
                    .decryptData(
              map['time'],
            ),

            color: Color(
              map['color'],
            ),
          ),
        );
      }
    } catch (e) {
      await box.delete('events');

      _events.clear();
    }

    notifyListeners();
  }

  // GET EVENTS BY DATE
  List<EventModel>
      getEventsForDate(
    DateTime date,
  ) {
    return _events.where((event) {
      return event.date.year ==
              date.year &&
          event.date.month ==
              date.month &&
          event.date.day ==
              date.day;
    }).toList();
  }
}