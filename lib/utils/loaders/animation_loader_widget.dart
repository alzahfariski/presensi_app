import 'package:flutter/material.dart';

class AAnimationLoaderWidget extends StatelessWidget {
  const AAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(animation,
              width: MediaQuery.of(context).size.width * 0.8),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 30,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}