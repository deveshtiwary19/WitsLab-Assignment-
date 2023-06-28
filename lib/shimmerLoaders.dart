import 'package:assignemnt/home_screen/home_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader {
  static ListView getVerticalItemShimmerLoader(
      Size size, HomeViewModel viewModel, double constantScreenPadding) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          width: size.width * 0.5,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: index == viewModel.productList.length - 1
                ? constantScreenPadding + 10
                : 15.0,
            left: index == 0 ? constantScreenPadding + 10 : 15.0,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                )
              ]),
          child: Column(
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.maxFinite,
                  height: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.maxFinite,
                  height: 30,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
