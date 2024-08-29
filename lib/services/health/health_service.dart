import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthService {
  final Health _health = Health();

  // defining the date range...
  DateTime startTime = DateTime.now().subtract(const Duration(days: 7));
  DateTime endTime = DateTime.now();

  // Initializing...
  Future<List<double>> initialize() async {
    await requestPermission();

    late final List<double> data;

    // Defining the data types to be accessed...
    final types = [
      HealthDataType.HEART_RATE,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
    ];

    // Requesting permission...
    bool hasPermission = await _health.requestAuthorization(types);

    if (hasPermission) {
      // Accessing the Data...
      final double heartRate = await fetchHeartRate();
      final double systolic = await fetchSystolicBP();
      final double diastolic = await fetchDiastolicBP();

        data = [
          heartRate,
          systolic,
          diastolic,
        ];
    }
    return data;
  }

  // Requesting the permission for the Health Connect...
  Future<void> requestPermission() async {
    // Checking the status for the permission...
    var status = await Permission.activityRecognition.status;

    // If the permission is not granted, request...
    if (!status.isGranted) {
      status = await Permission.activityRecognition.request();
    }
  }

  // Fetching the heart rate...
  Future<double> fetchHeartRate() async {
    late final double heartRate;

    // Fetching the heart rate data...
    List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
      types: [HealthDataType.HEART_RATE],
      startTime: startTime,
      endTime: endTime,
    );

    // Getting the most latest value...
    heartRate =
        double.parse(data.last.value.toJson()['numeric_value'].toString());

    return heartRate;
  }

  // Fetching the systolic blood pressure...
  Future<double> fetchSystolicBP() async {
    late final double systolic;

    // Fetching the systolic blood pressure data...
    List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
      types: [HealthDataType.BLOOD_PRESSURE_SYSTOLIC],
      startTime: startTime,
      endTime: endTime,
    );

    systolic =
        double.parse(data.last.value.toJson()['numeric_value'].toString());

    return systolic;
  }

  // Fetching the diastolic blood pressure...
  Future<double> fetchDiastolicBP() async {
    late final double diastolic;

    // Fetching the diastolic blood pressure data...
    List<HealthDataPoint> data = await _health.getHealthDataFromTypes(
      types: [HealthDataType.BLOOD_PRESSURE_DIASTOLIC],
      startTime: startTime,
      endTime: endTime,
    );

    diastolic =
        double.parse(data.last.value.toJson()['numeric_value'].toString());

    return diastolic;
  }
}
