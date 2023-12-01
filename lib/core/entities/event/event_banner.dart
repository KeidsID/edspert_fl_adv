import 'package:equatable/equatable.dart';

final class EventBanner extends Equatable {
  final String id;
  final String title;
  final String description;
  final Uri? eventUrl;
  final String imageUrl;

  const EventBanner({
    required this.id,
    required this.title,
    required this.description,
    this.eventUrl,
    required this.imageUrl,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      eventUrl,
      imageUrl,
    ];
  }
}
