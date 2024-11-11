import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

/// health: ^10.2.0

class HealthService {
  final Health _health = Health();

  // Setting up the specific data types...
  static final types = [
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.BODY_MASS_INDEX,
  ];

  // Requesting permission...
  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ).toList();

  // Initializing...
  Future<List<String?>> initialize(String disease) async {
    _health.configure();

    _installHealthConnect();

    _requestPermission();

    late final List<String?> data;

    // Requesting permission...
    bool hasPermission = await _health.requestAuthorization(
      types,
      permissions: permissions,
    );

    if (hasPermission) {
      switch (disease) {
        case 'Heart':
          data = await _heartDiseaseData();

        case 'Diabetes':
          data = await _diabetesData();

        case 'Kidney':
          data = await _kidneyData();
      }
    }
    return data;
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

  Future<List<String?>> _heartDiseaseData() async {
    List<String?> data;

    final restingSystolicBloodPressure = await _fetchSystolicBP();
    final heartRate = await _fetchHeartRate();

    data = [
      restingSystolicBloodPressure,
      heartRate,
    ];

    return data;
  }

  Future<List<String?>> _diabetesData() async {
    List<String?> data;

    final glucoseLevel = await _fetchBloodGlucose();
    final diastolicBloodPressure = await _fetchDiastolicBP();
    final bmi = await _fetchBMI();

    data = [
      glucoseLevel,
      diastolicBloodPressure,
      bmi,
    ];

    return data;
  }

  Future<List<String?>> _kidneyData() async {
    List<String?> data;

    final systolicBloodPressure = await _fetchSystolicBP();
    final bloodGlucose = await _fetchBloodGlucose();

    data = [
      systolicBloodPressure,
      bloodGlucose,
    ];

    return data;
  }

  // Fetching the heart rate...
  Future<String?> _fetchHeartRate() async {
    String? heartRate;

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

        heartRate = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving heart rate: $error');
        throw Exception('Unable to fetch the heart rate. '
            'Could not find any data for the past 24 hours.');
      }
    }
    debugPrint(heartRate);
    return heartRate;
  }

  // Fetching the systolic blood pressure...
  Future<String?> _fetchSystolicBP() async {
    String? systolic;

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

        systolic = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving systolic bp: $error');
        throw Exception('Unable to fetch the systolic blood pressure. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return systolic;
  }

  // Fetching the diastolic blood pressure...
  Future<String?> _fetchDiastolicBP() async {
    String? diastolic;

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

        diastolic = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving diastolic bp: $error');
        throw Exception('Unable to fetch the diastolic blood pressure. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return diastolic;
  }

  // Fetching the blood glucose...
  Future<String?> _fetchBloodGlucose() async {
    String? bloodGlucose;

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

        bloodGlucose = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving blood glucose: $error');
        throw Exception('Unable to fetch the blood glucose. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return bloodGlucose;
  }

  // Fetching the BMI...
  Future<String?> _fetchBMI() async {
    String? bmi;

    // Defining the date range...
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    bool hasPermission =
        await _health.hasPermissions([HealthDataType.BODY_MASS_INDEX]) ?? false;

    if (!hasPermission) {
      hasPermission =
          await _health.requestAuthorization([HealthDataType.BODY_MASS_INDEX]);
    }

    if (hasPermission) {
      try {
        // Fetching the BMI data...
        List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
          types: [HealthDataType.BODY_MASS_INDEX],
          startTime: yesterday,
          endTime: now,
        );

        bmi = data.last.value.toJson()['numeric_value'].toString();
      } catch (error) {
        debugPrint('Exception in retrieving BMI: $error');
        throw Exception('Unable to fetch the BMI. '
            'Could not find any data for the past 24 hours.');
      }
    }
    return bmi;
  }
}
