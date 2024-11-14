import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  final Health _health = Health();

  // Setting up the specific data types...
  static final types = [
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_GLUCOSE,
  ];

  // Requesting permission...
  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  // Initializing...
  Future<void> _initialize() async {
    _health.configure();

    _installHealthConnect();

    _requestPermission();
  }

  // Installing Health Connect App on the current device...
  Future<void> _installHealthConnect() async =>
      await _health.installHealthConnect();

  // Getting permission to access relevant health data...
  Future<void> _requestPermission() async {
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
  Future<int?> fetchHeartRate() async {
    await _initialize();

    int? heartRate;

    // defining the date range...
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

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
          startTime: yesterday,
          endTime: now,
        );
        debugPrint(data.toString());

        heartRate = data.first.value.toJson()['numericValue'];
        debugPrint(heartRate.toString());
      } catch (error) {
        debugPrint('Exception in retrieving heart rate: $error');
        throw Exception('Unable to fetch the heart rate. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return heartRate;
  }

  // Fetching the systolic blood pressure...
  Future<int?> fetchSystolicBP() async {
    await _initialize();

    int? systolic;

    // defining the date range...
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

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
          startTime: yesterday,
          endTime: now,
        );

        systolic = data.first.value.toJson()['numericValue'].toInt();
      } catch (error) {
        debugPrint('Exception in retrieving systolic bp: $error');
        throw Exception('Unable to fetch the systolic blood pressure. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return systolic;
  }

  // Fetching the diastolic blood pressure...
  Future<int?> fetchDiastolicBP() async {
    await _initialize();

    int? diastolic;

    // defining the date range...
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

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
          startTime: yesterday,
          endTime: now,
        );

        diastolic = data.first.value.toJson()['numericValue'].toInt();
      } catch (error) {
        debugPrint('Exception in retrieving diastolic bp: $error');
        throw Exception('Unable to fetch the diastolic blood pressure. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return diastolic;
  }

  // Fetching the blood glucose...
  Future<int?> fetchBloodGlucose() async {
    await _initialize();

    int? bloodGlucose;

    // Defining the date range...
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    bool hasPermission =
        await _health.hasPermissions([HealthDataType.BLOOD_GLUCOSE]) ?? false;

    if (!hasPermission) {
      hasPermission =
          await _health.requestAuthorization([HealthDataType.BLOOD_GLUCOSE]);
    }

    if (hasPermission) {
      try {
        // Fetching the blood glucose data...
        List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
          types: [HealthDataType.BLOOD_GLUCOSE],
          startTime: yesterday,
          endTime: now,
        );

        bloodGlucose = data.first.value.toJson()['numericValue'].toInt();
      } catch (error) {
        debugPrint('Exception in retrieving blood glucose: $error');
        throw Exception('Unable to fetch the blood glucose. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return bloodGlucose;
  }
}
