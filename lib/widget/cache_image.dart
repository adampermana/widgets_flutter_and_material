import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const String brokenImage =
    'https://static.thenounproject.com/png/3237447-200.png';

class CachedImage extends StatelessWidget {
  final String source;
  final Widget Function(BuildContext context, String error, dynamic stackrace)?
      errorBuilder;
  final BoxFit fit;
  final double? width;
  final double? height;
  const CachedImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.errorBuilder,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (source.toLowerCase().startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: source,
        fit: fit,
        width: width,
        height: height,
        memCacheHeight: height?.toInt(),
        memCacheWidth: width?.toInt(),
        progressIndicatorBuilder: (context, url, progress) =>
            _progressIndicator(progress),
        errorWidget: errorBuilder ?? (context, e, s) => _errorImage(),
      );
    } else if (source.toLowerCase().startsWith('assets')) {
      return Image.asset(
        source,
        fit: fit,
        width: width,
        height: height,
        cacheHeight: height?.toInt(),
        cacheWidth: width?.toInt(),
        errorBuilder: (context, e, s) =>
            errorBuilder?.call(context, e.toString(), s) ?? _errorImage(),
      );
    } else {
      return Image.file(
        File(source),
        fit: fit,
        width: width,
        height: height,
        cacheHeight: height?.toInt(),
        cacheWidth: width?.toInt(),
        errorBuilder: (context, e, s) =>
            errorBuilder?.call(context, e.toString(), s) ?? _errorImage(),
      );
    }
  }

  Widget _errorImage() {
    return Container(
      color: Colors.grey.shade100,
      child: const FractionallySizedBox(
        heightFactor: 0.6,
        widthFactor: 0.6,
        child: FittedBox(
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _progressIndicator(DownloadProgress progress) {
    return Center(
      child: SizedBox.square(
        dimension: 32.0,
        child: CircularProgressIndicator(
          value: progress.progress,
        ),
      ),
    );
  }
}
