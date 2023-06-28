import 'package:assignemnt/models/productModel.dart';
import 'package:assignemnt/product_details_screen/product_detail_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

class ProductDeatailView extends StatelessWidget {
  ProductDeatailView({required this.product, super.key});

  Product product;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var constantScreenPadding = size.width * 0.05;
    return ViewModelBuilder<ProductDetailViewMoidel>.reactive(
      viewModelBuilder: () => ProductDetailViewMoidel(),
      onViewModelReady: (viewModel) {
        viewModel.init(product);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: viewModel.product.id,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50.0)),
                        child: Image.network(
                          viewModel.product.image,
                          fit: BoxFit.contain,
                          width: double.maxFinite,
                          height: size.height * 0.5,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            //Handle the UI while image is loading
                            return const SizedBox(
                              width: double.maxFinite,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      title: const Text("Product"),
                      centerTitle: true,
                    )
                  ],
                ),
                //Detils
                Padding(
                  padding: EdgeInsets.all(constantScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$${viewModel.product.price.toString()}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            viewModel.product.category.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Spacer(),
                          RatingBarIndicator(
                            rating: viewModel.product.rating.rate,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            viewModel.product.rating.rate.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Color Option",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3.0),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.pinkAccent, width: 1)),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pinkAccent),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Description",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        viewModel.product.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.addToCart(viewModel.product);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(milliseconds: 200),
                        content: Text(
                          "Item added to cart sucessfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.pinkAccent,
                        elevation: 10, //shadow
                      ));
                    },
                    child: Container(
                      width: size.width * 0.5,
                      height: 55,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50.0))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add to cart",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
