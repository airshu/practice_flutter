import 'package:flutter/widgets.dart';

class HorizontalScaleTransition extends ScaleTransition {
  const HorizontalScaleTransition({
    Key? key,
    required Animation<double> scale,
    alignment = Alignment.center,
    filterQuality,
    child,
  })  : assert(scale != null),
        super(
            key: key,
            scale: scale,
            alignment: alignment,
            filterQuality: filterQuality,
            child: child);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale.value,
      alignment: alignment,
      filterQuality: filterQuality,
      child: child,
    );
  }
}
