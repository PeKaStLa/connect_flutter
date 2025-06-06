import 'package:pocketbase/pocketbase.dart'; // Import PocketBase
import 'package:logger/logger.dart'; // Import the logger package

final Logger _logger = Logger(); // Initialize a logger for this file

// Constants for PocketBase field names within the 'areas' collection
class _AreaFieldKeys {
  static const String areaName = 'area_name';
  static const String centerLatitude = 'center_latitude';
  static const String centerLongitude = 'center_longitude';
  static const String radiusMeter = 'radius_meter';
  static const String minLatitude = 'min_latitude';
  static const String minLongitude = 'min_longitude';
  static const String maxLatitude = 'max_latitude';
  static const String maxLongitude = 'max_longitude';
}

// Define the Area class
class Area {
  final double centerLatitude;
  final double centerLongitude;
  final double? minLatitude;  // Make nullable
  final double? minLongitude; // Make nullable
  final double? maxLatitude;  // Make nullable
  final double? maxLongitude; // Make nullable
  final String name;
  final String id;
  final double radiusMeter;

  Area({
    required this.centerLatitude,
    required this.centerLongitude,
    this.minLatitude,   // Remove required, allow null
    this.minLongitude,  // Remove required, allow null
    this.maxLatitude,   // Remove required, allow null
    this.maxLongitude,  // Remove required, allow null
    required this.id,
    required this.name,
    required this.radiusMeter,
  });


  factory Area.fromRecord(RecordModel record) {
    final data = record.data;
    _logger.i('Creating Area from Record ID: ${record.id}, Data: $data'); // Log the received data

    return Area(
      id: record.id, 
      name: data[_AreaFieldKeys.areaName] as String? ?? 'Unnamed Area',
      centerLatitude: double.tryParse(data[_AreaFieldKeys.centerLatitude]?.toString() ?? '') ?? 0.0,
      centerLongitude: double.tryParse(data[_AreaFieldKeys.centerLongitude]?.toString() ?? '') ?? 0.0,
      radiusMeter: double.tryParse(data[_AreaFieldKeys.radiusMeter]?.toString() ?? '') ?? 1000.0,
      // Optionally map min/max if they exist in your PocketBase data
      minLatitude: double.tryParse(data[_AreaFieldKeys.minLatitude]?.toString() ?? ''),
      minLongitude: double.tryParse(data[_AreaFieldKeys.minLongitude]?.toString() ?? ''),
      maxLatitude: double.tryParse(data[_AreaFieldKeys.maxLatitude]?.toString() ?? ''),
      maxLongitude: double.tryParse(data[_AreaFieldKeys.maxLongitude]?.toString() ?? ''),
    );
  }
}
