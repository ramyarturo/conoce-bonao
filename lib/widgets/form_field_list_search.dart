import 'package:flutter/material.dart';
import 'package:conoce_bonao/widgets/custom_textfield.dart';
import 'package:select_dialog/select_dialog.dart';

class FormFieldListSearch extends StatefulWidget {
  final String label;
  final String? hint;
  final String? selectedItem;
  final List<String> items;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;

  const FormFieldListSearch({
    super.key,
    required this.label,
    this.hint,
    this.selectedItem,
    required this.items,
    this.onChange,
    this.controller,
  });

  @override
  State<FormFieldListSearch> createState() => _FormFieldListSearchState();
}

class _FormFieldListSearchState extends State<FormFieldListSearch> {
  String? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      initialValue: selectedItem,
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      textInputType: TextInputType.none,
      onTap: () {
        SelectDialog.showModal<String>(
          context,
          label: widget.label,
          showSearchBox: true,
          selectedValue: widget.selectedItem,
          items: widget.items,
          emptyBuilder: (_) => const Center(child: Text("No existe la provincia")),
          searchBoxDecoration: const InputDecoration(
            hintText: "Buscar",
          ),
          onChange: (String selectedItem) {
            setState(() {
              this.selectedItem = selectedItem;
            });

            widget.controller?.text = selectedItem;
            widget.onChange?.call(selectedItem);
          },
        );
      },
    );
  }
}
