import 'package:assignemnt/cart_screen/cart_screen_view.dart';
import 'package:assignemnt/home_screen/home_screen_vm.dart';
import 'package:assignemnt/product_details_screen/product_detail_view.dart';
import 'package:assignemnt/shimmerLoaders.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var constantScreenPadding = size.width * 0.05;

    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              color: Colors.pinkAccent,
              onRefresh: () async {
                viewModel.init();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: constantScreenPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu),
                          ),
                          Container(
                              padding: EdgeInsets.all(size.width * 0.008),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.width * 0.01))),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.all(constantScreenPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0)
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Search",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          //Cart Icon
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CartScreenView(),
                                  ));
                            },
                            child: Stack(
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 30,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                        color: Colors.pink,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        viewModel.currentCartListLength
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 8),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.all(constantScreenPadding),
                      child: const Text(
                        "Explore",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    //The product List  (Horizontal)
                    Container(
                      height: size.width * 0.85,
                      child: viewModel.isVieModelLoading
                          ? ShimmerLoader.getVerticalItemShimmerLoader(
                              size, viewModel, constantScreenPadding)
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.productList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDeatailView(
                                                product: viewModel
                                                    .productList[index]),
                                      )),
                                  child: Container(
                                    padding: const EdgeInsets.all(15.0),
                                    width: size.width * 0.5,
                                    margin: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      right: index ==
                                              viewModel.productList.length - 1
                                          ? constantScreenPadding + 10
                                          : 15.0,
                                      left: index == 0
                                          ? constantScreenPadding + 10
                                          : 15.0,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //The Image
                                        Expanded(
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Hero(
                                                    tag: viewModel
                                                        .productList[index].id,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                      child: Image.network(
                                                        viewModel
                                                            .productList[index]
                                                            .image,
                                                        fit: BoxFit.contain,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          //Handle the UI while image is loading
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                viewModel.likeList.isNotEmpty
                                                    ? Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                          onTap: () => viewModel
                                                              .likePressed(
                                                                  index),
                                                          child: Container(
                                                            width: 35,
                                                            height: 35,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Colors
                                                                  .pinkAccent,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Icon(
                                                              Icons.favorite,
                                                              size: 20,
                                                              color: viewModel
                                                                          .likeList[
                                                                      index]
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Text(
                                          viewModel.productList[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        //Description
                                        Text(
                                          viewModel
                                              .productList[index].description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        //Price and ADD TO CART
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${viewModel.productList[index].price.toString()}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                viewModel.addToCart(viewModel
                                                    .productList[index]);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  content: Text(
                                                    "Item added to cart sucessfully",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      Colors.pinkAccent,
                                                  elevation: 10, //shadow
                                                ));
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    SizedBox(
                      height: size.width * 0.02,
                    ),
                    //The product List  (Vertical)
                    Padding(
                      padding: EdgeInsets.all(constantScreenPadding),
                      child: const Text(
                        "Best Selling",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: viewModel.productList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDeatailView(
                                    product: viewModel.productList[index]),
                              )),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(
                                horizontal: constantScreenPadding + 10,
                                vertical: 15),
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
                            width: double.maxFinite,
                            height: size.width * 0.25,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20.0)),
                                  child: Image.network(
                                    viewModel.productList[index].image,
                                    fit: BoxFit.contain,
                                    width: size.width * 0.2,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      //Handle the UI while image is loading
                                      return SizedBox(
                                        width: size.width * 0.2,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        viewModel.productList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),

                                      //Description
                                      Text(
                                        viewModel
                                            .productList[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "\$${viewModel.productList[index].price.toString()}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 10, bottom: 2),
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
