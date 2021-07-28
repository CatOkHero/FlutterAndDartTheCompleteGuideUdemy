import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _imagePreview = '';

  Future<void> _getCurrentLocation() async {
    final location = await Location().getLocation();
    final locationUrl = LocationHelper.generateLocationPreviewImage(
        latitude: location.latitude, longitude: location.longitude);
    setState(() {
      _imagePreview = locationUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _imagePreview.isEmpty
              ? Text('No Location choosen')
              : Image.network(
                  _imagePreview,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
