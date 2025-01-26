import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/constants.dart';

class CustomTextField extends ConsumerWidget {
  CustomTextField(
      {required this.controller,
      this.hint,
      this.icon,
      this.secure,
      this.visibility,
      this.textInputType,
      this.onSubmit,
      this.pressedIcon,
      this.width,
      this.enabled,
      this.maxLines,
      this.validator});

  TextEditingController controller;
  String? hint;
  IconData? icon;
  bool? secure;
  bool? visibility;
  bool? enabled;
  final String? Function(String?)? validator;
  TextInputType? textInputType = TextInputType.text;
  Function? onSubmit;
  double? width;
  Widget? pressedIcon;
  final visibilityProvider = StateProvider<bool>((ref) => false);
  bool init = false;
  int? maxLines;
  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final isVisibility = widgetRef.watch(visibilityProvider);
    if ((secure ?? false) && !init) {
      init = true;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widgetRef.read(visibilityProvider.notifier).state = secure ?? false;
      });
    }
    return Container(
      width: width ?? screenWidth,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      decoration: BoxDecoration(
          color: kGreyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          icon == null
              ? const SizedBox()
              : Icon(
                  icon,
                  color: kPrimaryColor,
                  size: 20,
                ),
          icon == null
              ? const SizedBox()
              : const SizedBox(
                  width: 10,
                ),
          Expanded(
            child: TextFormField(
              enabled: enabled,
              maxLines: maxLines,
              controller: controller,
              obscureText: isVisibility,
              validator: validator,
              keyboardType: textInputType,
              style: const TextStyle(
                color: kPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                ),
              ),
              onFieldSubmitted: (val) {
                onSubmit!();
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (visibility ?? false)
              ? InkWell(
                  onTap: () {
                    widgetRef.read(visibilityProvider.notifier).state =
                        !widgetRef.read(visibilityProvider.notifier).state;
                  },
                  child: Icon(
                    isVisibility ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                    size: 20,
                  ),
                )
              : pressedIcon ?? const SizedBox()
        ],
      ),
    );
  }
}
