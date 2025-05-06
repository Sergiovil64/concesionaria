import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedSticker extends HookConsumerWidget {
  final String texto;
  const AnimatedSticker({super.key, this.texto = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      controller.repeat(reverse: true);
      return null;
    }, [controller]);

    final scaleAnim = useAnimation(
      Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      ),
    );

    return ScaleTransition(
      scale: AlwaysStoppedAnimation(scaleAnim),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
