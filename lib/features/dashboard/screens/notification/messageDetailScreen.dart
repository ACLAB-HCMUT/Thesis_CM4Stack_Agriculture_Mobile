import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/notification_services.dart';

class MessageDetailScreen extends StatefulWidget {
  final String title;
  final String body;
  final Map<String, dynamic> payload;

  const MessageDetailScreen({
    Key? key,
    required this.title,
    required this.body,
    required this.payload,
  }) : super(key: key);

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Mark notifications as read after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<NotificationServices>()) {
        Get.find<NotificationServices>().markAsRead();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Payload: ${widget.payload}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.body,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 24),
            if (widget.payload.isNotEmpty) ...[
              Text(
                'Additional Data:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              // Let's create specific UI for temperature or humidity alerts
              if (widget.payload['type'] == 'high_humidity' || widget.payload['type'] == 'high_temperature')
                _buildSensorAlertDetails(context)
              else
                _buildGenericPayloadDetails(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSensorAlertDetails(BuildContext context) {
    final String type = widget.payload['type'] ?? '';
    final String value = widget.payload['value'] ?? '';
    final String timestamp = widget.payload['timestamp'] ?? '';
    final String containerId = widget.payload['containerId'] ?? '';
    final String sensorId = widget.payload['sensorId'] ?? '';
    final String minThreshold = widget.payload['minThreshold'] ?? '';
    final String maxThreshold = widget.payload['maxThreshold'] ?? '';

    // Convert timestamp to readable date if possible
    String formattedTime = timestamp;
    try {
      if (timestamp.isNotEmpty) {
        final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
        formattedTime = '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
      }
    } catch (e) {
      print('Error formatting timestamp: $e');
    }

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              type.contains('temperature')
                  ? TColors.secondary2
                  : TColors.secondary2,
              TColors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: TColors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                leading: Icon(
                  type.contains('temperature') ? Icons.thermostat : Icons.water_drop,
                  color: type.contains('temperature') ? TColors.accent : TColors.primary,
                  size: 32,
                ),
                title: Text(
                  type.contains('temperature') ? 'Temperature Alert' : 'Humidity Alert',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text('Recorded value: $value'),
              ),
              Divider(),
              _buildInfoRow('Area', 'Area 1'),
              _buildInfoRow('Sensor', sensorId),
              _buildInfoRow('Time', formattedTime),
              _buildInfoRow('Min Threshold', minThreshold),
              _buildInfoRow('Max Threshold', maxThreshold),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildGenericPayloadDetails() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Text(
            widget.payload.entries
                .map((e) => '${e.key}: ${e.value}')
                .join('\n'),
          ),
        ),
      ),
    );
  }
}