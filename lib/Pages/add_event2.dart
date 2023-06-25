import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_reserve/Controllers/add_event_controller.dart';

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<
      AddEventController>(); // make sure to have EventController initialized

  Map<String, dynamic> event = {};

  // Add controllers for your fields
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _venueController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  // Add more controllers for other fields
  // ...

  @override
  void initState() {
    super.initState();
    if (controller.args['event'] != null) {
      _cityController.text = controller.args['event']['locations'][0]["city"];
      _streetController.text =
          controller.args['event']['locations'][0]["street"];
      _venueController.text = controller.args['event']['locations'][0]["venue"];
      _latitudeController.text =
          '${controller.args['event']['locations'][0]["latitude"]}';
      _longitudeController.text =
          '${controller.args['event']['locations'][0]["longitude"]}';

      // Assign values to other fields here
      // ...
    }
  }

  @override
  void dispose() {
    // Dispose your text controllers
    _cityController.dispose();
    _streetController.dispose();
    _venueController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();

    // Dispose your other text controllers
    // ...

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Form'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // Location Section
              _buildSectionTitle('Location Information'),
              _buildTextField(_cityController, 'City', isNumber: false),
              _buildTextField(_streetController, 'Street', isNumber: false),
              _buildTextField(_venueController, 'Venue', isNumber: false),
              _buildTextField(_latitudeController, 'Latitude', isNumber: true),
              _buildTextField(_longitudeController, 'Longitude',
                  isNumber: true),

              // Seat Information Section
              _buildSectionTitle('Seat Information'),
              // You should add text fields for VIP seats, VIP price, etc. here

              // Event Pictures Section
              _buildSectionTitle('Event Pictures'),
              // You should add image picker here

              // Submit button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(controller.args['event'] != null
                      ? 'Edit Event'
                      : 'Add Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      event['city'] = _cityController.text;
      event['street'] = _streetController.text;
      event['venue'] = _venueController.text;
      event['latitude'] = _latitudeController.text;
      event['longitude'] = _longitudeController.text;

      // Assign other field values to the 'event' map
      // ...

      debugPrint(jsonEncode(event));

      // TODO: Call your API to save the event here
    }
  }
}
