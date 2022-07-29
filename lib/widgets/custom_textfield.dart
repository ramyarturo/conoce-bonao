import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:conoce_bonao/constants/theme.dart';
import 'package:conoce_bonao/utils/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String Function(String text)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.textInputType,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: textTheme.labelMedium!.copyWith(
              color: greenColor,
            ),
          ),
        const SizedBox(height: 8),
        ObxValue<RxBool>((value) {
          final isPassword = textInputType == TextInputType.visiblePassword;
          return TextFormField(
            controller: controller ?? TextEditingController(text: initialValue),
            keyboardType: textInputType,
            obscureText: value.value && textInputType == TextInputType.visiblePassword,
            enableInteractiveSelection: textInputType != TextInputType.none,
            readOnly: textInputType == TextInputType.none,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: maxLength,
            onTap: onTap,
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Campo requerido";
              }
              if (textInputType == TextInputType.emailAddress && !value.isEmail) {
                return "Correo no válido";
              }
              return validator?.call(value);
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              counterText: "",
              errorMaxLines: 3,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(value.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => value.toggle(),
                    )
                  : null,
              contentPadding: const EdgeInsets.all(defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }, true.obs),
      ],
    );
  }
}
