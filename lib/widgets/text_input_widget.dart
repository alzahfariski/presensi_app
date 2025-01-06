import 'package:flutter/material.dart';
import 'package:presensi_app/utils/constants/color.dart';

class TextInputWidget extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;

  const TextInputWidget({
    super.key,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            width: 1,
            color: AColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            width: 1,
            color: AColors.primary,
          ),
        ),
        label: Text(
          labelText,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.grey,
              ),
        ),
      ),
    );
  }
}
