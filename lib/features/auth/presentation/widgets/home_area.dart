import 'package:flutter/material.dart';
import 'package:marco/core/constants/app_text_styles.dart';

class HomeAreaDropdown extends StatefulWidget {
  final Function(String) onAreaSelected;

  const HomeAreaDropdown({super.key, required this.onAreaSelected});

  @override
  State<HomeAreaDropdown> createState() => _HomeAreaDropdownState();
}

class _HomeAreaDropdownState extends State<HomeAreaDropdown> {
  String? _selectedArea;

  final List<String> thessalonikiAreas = [
    'Agios Ioannis',
    'Ampelokipoi',
    'Ano Poli',
    'Ano Toumpa',
    'Plateia Dimokratias',
    'Dendropotamos',
    'Evosmos',
    'Eleftherio-Kordelio',
    'Efkarpia',
    'Ilioupoli',
    'Kalamaria',
    'Kifisia',
    'Menemeni',
    'Meteora',
    'Nea Aretsou',
    'Nea Elvetia',
    'Nea Krini',
    'Neapoli',
    'Ntepo',
    'Xirokrini',
    'Panorama',
    'Peraia',
    'Pylea',
    'Faliro',
    'Foinikas',
    'Charilaou',
    'Oreokastro',
  ]..sort();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            initialValue: _selectedArea,
            hint: const Text('Select an area', style: AppTextStyles.bodyHint),
            borderRadius: BorderRadius.circular(20),
            dropdownColor: Colors.white,
            onChanged: (String? newValue) {
              setState(() {
                _selectedArea = newValue;
              });
              if (newValue != null) {
                widget.onAreaSelected(newValue);
              }
            },
            items: thessalonikiAreas.map<DropdownMenuItem<String>>((
              String value,
            ) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: AppTextStyles.body),
              );
            }).toList(),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.location_on, size: 18),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 16.0,
              ),
            ),
            isExpanded: true,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Only neighborhood - exact address not stored',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
