import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/data/source/remote/response/GetProfileResponse.dart';


class FilterProductItem extends StatelessWidget {
  final ProductDetail product;

  const FilterProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.5), width: 1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.1 / 1,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(11)),
              child: SizedBox(
                  width: double.infinity,
                  child: product.photos.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: product.photos[0],
                      placeholder: (context, url) => Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                      : Image.asset("assets/images/placeholder_image.png", fit: BoxFit.cover)),
            ),
          ),
          const Spacer(flex: 1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(child: Text(product.title.toUpperCase(), style: TextStyle(fontSize: 16, fontFamily: 'Inter', fontWeight: FontWeight.w500))),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Text(
                "${product.price} ${AppLocalizations.of(context)?.productPrice}",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              )),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.remove_red_eye, size: 16,),
                  SizedBox(width: 8,),
                  Text("${product.views}", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                ],
              )),
          SizedBox(height: 5),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              child: Text("${DateFormat('dd-MM-yyyy HH:mm').format(product.updatedAt)}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7F7F7F),
                      fontSize: 12
                  ))),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
