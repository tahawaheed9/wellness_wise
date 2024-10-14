import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

/// health: ^10.2.0

class HealthService {
  final Health _health = Health();

  final types = [
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  ];

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  // Initializing...
  Future<List<String?>> initialize() async {
    requestPermission();

    late final List<String?> data;

    // Requesting permission...
    bool hasPermission = await _health.requestAuthorization(
      types,
      permissions: permissions,
    );

    if (hasPermission) {
      // Accessing the data...
      final String? heartRate = await fetchHeartRate();
      final String? systolic = await fetchSystolicBP();
      final String? diastolic = await fetchDiastolicBP();

      data = [
        heartRate,
        systolic,
        diastolic,
      ];
    }
    return data;
  }

  // Getting permission to access relevant health data...
  Future<void> requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      try {
        status = await Permission.activityRecognition.request();
      } catch (error) {
        debugPrint('Exception on requesting permission: $error');
        throw Exception('An error occurred while requesting permission. '
            'Please try again or contact the support.');
      }
    }
  }

  // Fetching the heart rate...
  Future<String?> fetchHeartRate() async {
    String? heartRate;

    // defining the date range...
    final now = DateTime.now();
    final midNight = DateTime(now.year, now.month, now.day);

    bool hasPermission =
        await _health.hasPermissions([HealthDataType.HEART_RATE]) ?? false;

    if (!hasPermission) {
      hasPermission =
          await _health.requestAuthorization([HealthDataType.HEART_RATE]);
    }

    if (hasPermission) {
      try {
        // Fetching the heart rate data...
        List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: midNight,
          endTime: now,
        );

        heartRate = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving heart rate: $error');
        throw Exception('Unable to fetch the heart rate. '
            'Please make sure the information is updated on the Google Fit app.');
      }
    }

    if (heartRate == null) {
      return null;
    }
    return heartRate;
  }

  // Fetching the systolic blood pressure...
  Future<String?> fetchSystolicBP() async {
    String? systolic;

    // defining the date range...
    final now = DateTime.now();
    final midNight = DateTime(now.year, now.month, now.day);

    bool hasPermission = await _health
            .hasPermissions([HealthDataType.BLOOD_PRESSURE_SYSTOLIC]) ??
        false;

    if (!hasPermission) {
      hasPermission = await _health
          .requestAuthorization([HealthDataType.BLOOD_PRESSURE_SYSTOLIC]);
    }

    if (hasPermission) {
      try {
        // Fetching the systolic blood pressure data...
        List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
          types: [HealthDataType.BLOOD_PRESSURE_SYSTOLIC],
          startTime: midNight,
          endTime: now,
        );

        systolic = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving systolic bp: $error');
        throw Exception('Unable to fetch the systolic blood pressure. '
            'Please make sure the information is updated on the Google Fit app.');
      }
    }

    if (systolic == null) {
      return null;
    }
    return systolic;
  }

  // Fetching the diastolic blood pressure...
  Future<String?> fetchDiastolicBP() async {
    String? diastolic;

    // defining the date range...
    final now = DateTime.now();
    final midNight = DateTime(now.year, now.month, now.day);

    bool hasPermission = await _health
            .hasPermissions([HealthDataType.BLOOD_PRESSURE_DIASTOLIC]) ??
        false;

    if (!hasPermission) {
      hasPermission = await _health
          .requestAuthorization([HealthDataType.BLOOD_PRESSURE_DIASTOLIC]);
    }

    if (hasPermission) {
      try {
        // Fetching the diastolic blood pressure data...
        List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
          types: [HealthDataType.BLOOD_PRESSURE_DIASTOLIC],
          startTime: midNight,
          endTime: now,
        );

        diastolic = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving diastolic bp: $error');
        throw Exception('Unable to fetch the diastolic blood pressure. '
            'Please make sure the information is updated on the Google Fit app.');
      }
    }

    if (diastolic == null) {
      return null;
    }
    return diastolic;
  }
}
