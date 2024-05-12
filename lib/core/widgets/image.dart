// import 'package:flutter/material.dart';

// class CustomImage extends StatelessWidget {
//   const CustomImage({
//     super.key,
//     required this.imageUrl,
//     required this.borderRadius,
//     required this.height,
//     required this.width,
//   });
//   final String imageUrl;
//   final double height, width, borderRadius;
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: "http://via.placeholder.com/200x150",
//       imageBuilder: (context, imageProvider) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: imageProvider,
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//         ),
//       ),
//       placeholder: (context, url) => CircularProgressIndicator(),
//       errorWidget: (context, url, error) => Icon(Icons.error),
//     );
//   }
// }
