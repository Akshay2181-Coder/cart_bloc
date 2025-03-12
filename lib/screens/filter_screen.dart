import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/blocs/cart/cart_bloc.dart';
import 'package:interview_project/blocs/cart/cart_event.dart';
import 'package:interview_project/blocs/filter/filter_bloc.dart';
import 'package:interview_project/screens/result_screen.dart';

import '../blocs/filter/filter_event.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController caratFromController = TextEditingController();
  final TextEditingController caratToController = TextEditingController();
  String? selectedLab;
  String? selectedShape;
  String? selectedColor;
  String? selectedClarity;

  void _applyFilters() {
    final filterBloc = context.read<FilterBloc>();
    BlocProvider.of<CartBloc>(context).add(ClearCart());

    filterBloc.add(
      ApplyFilters(
        caratFrom: double.tryParse(caratFromController.text),
        caratTo: double.tryParse(caratToController.text),
        lab: selectedLab,
        shape: selectedShape,
        color: selectedColor,
        clarity: selectedClarity,
      ),
    );
    print('Applied Filters - Carat From: ${caratFromController.text}, Carat To: ${caratToController.text}, Lab: $selectedLab, Shape: $selectedShape, Color: $selectedColor, Clarity: $selectedClarity');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: filterBloc,
          child: const ResultPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diamond Filter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filter Diamonds", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: caratFromController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Carat From", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: caratToController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Carat To", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedLab,
              decoration: const InputDecoration(labelText: "Lab", border: OutlineInputBorder()),
              items: ["GIA", "In-House", "HRD"].map((lab) => DropdownMenuItem(value: lab, child: Text(lab))).toList(),
              onChanged: (value) => setState(() => selectedLab = value),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedShape,
              decoration: const InputDecoration(labelText: "Shape", border: OutlineInputBorder()),
              items: ["BR", "CU", "EM", "MQ", "OV", "PR", "PS", "RAD", "HS"].map((shape) =>
                  DropdownMenuItem(value: shape, child: Text(shape))).toList(),
              onChanged: (value) => setState(() => selectedShape = value),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedColor,
              decoration: const InputDecoration(labelText: "Color", border: OutlineInputBorder()),
              items: ["D", "E", "F", "G", "H", "I" ,"J","K","M"].map((color) =>
                  DropdownMenuItem(value: color, child: Text(color))).toList(),
              onChanged: (value) => setState(() => selectedColor = value),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedClarity,
              decoration: const InputDecoration(labelText: "Clarity", border: OutlineInputBorder()),
              items: ["IF", "VVS1", "VVS2", "VS1", "VS2", "SI1"].map((clarity) =>
                  DropdownMenuItem(value: clarity, child: Text(clarity))).toList(),
              onChanged: (value) => setState(() => selectedClarity = value),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text("Search", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}