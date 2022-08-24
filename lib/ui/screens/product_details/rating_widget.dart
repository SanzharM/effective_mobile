import 'package:effective_mobile/core/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key? key, this.maxRating = 5.0, required this.rating}) : super(key: key);

  final double maxRating;
  final double? rating;

  static const Widget star = Icon(CupertinoIcons.star_fill, size: 32, color: AppColors.yellow);
  static const Widget emptyStar = Icon(CupertinoIcons.star, size: 32, color: AppColors.yellow);

  @override
  Widget build(BuildContext context) {
    double _rating;
    if (rating == null || (rating ?? -1) < 0) {
      _rating = 0;
    } else {
      _rating = rating!;
    }

    final stars = <Widget>[];
    final double maxWidth = 32 * (_rating - _rating.floor());

    for (int i = 0; i < _rating.ceil(); i++) {
      final bool isLastIteration = i + 1 == _rating.ceil();
      if (isLastIteration) {
        stars.add(
          SizedBox(
            width: 32,
            child: ClipPath(
              clipper: StarClipper(maxWidth, 32.0),
              clipBehavior: Clip.hardEdge,
              child: star,
            ),
          ),
        );
      } else {
        stars.add(star);
      }
    }
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        SizedBox(
          width: 32 * maxRating,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: List.filled(maxRating.ceil(), emptyStar),
          ),
        ),
        SizedBox(
          width: 32 * maxRating,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: stars,
          ),
        ),
      ],
    );
  }
}

class StarClipper extends CustomClipper<Path> {
  final double maxWidth;
  final double maxHeight;

  const StarClipper(this.maxWidth, this.maxHeight);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(maxWidth, 0.0);
    path.lineTo(maxWidth, maxHeight);
    path.lineTo(0.0, maxHeight);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
