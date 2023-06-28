import 'package:assignemnt/cart_screen/cart_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CartScreenView extends StatelessWidget {
  const CartScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ViewModelBuilder<CartScreenViewModel>.reactive(
      viewModelBuilder: () => CartScreenViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text("Cart"),
            actions: [
              viewModel.isAnyItemSelected
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          viewModel.removeSelected();
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          body: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : viewModel.cartList.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.pinkAccent,
                          ),
                          Text("OOPS!! The cart is empty"),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount: viewModel.cartList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.05,
                                      vertical: 10.0),
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      //checkbox
                                      Checkbox(
                                          activeColor: Colors.pinkAccent,
                                          value: viewModel
                                              .cartList[index].selected,
                                          onChanged: (value) {
                                            viewModel.changeSelectValue(index);
                                          }),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        child: Image.network(
                                          viewModel.cartList[index].image,
                                          fit: BoxFit.contain,
                                          width: size.width * 0.2,
                                          height: size.width * 0.2,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            //Handle the UI while image is loading
                                            return SizedBox(
                                              width: size.width * 0.2,
                                              height: size.width * 0.2,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: size.width * 0.12,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                viewModel.cartList[index].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$${(viewModel.cartList[index].price * viewModel.cartList[index].qty).toStringAsFixed(2)}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.pinkAccent,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    2.0)),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 0.5)),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            viewModel
                                                                .decreaseCartQTY(
                                                                    index);
                                                            print(
                                                                "taped decrease");
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: Colors.grey,
                                                            size: 15,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 10,
                                                          ),
                                                          child: Text(viewModel
                                                              .cartList[index]
                                                              .qty
                                                              .toString()),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            viewModel
                                                                .increaseCartQTY(
                                                                    index);
                                                            print(
                                                                "taped increase");
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.grey,
                                                            size: 15,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(size.width * 0.05),
                          width: double.infinity,
                          height: size.height * 0.3,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0),
                            ],
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              //Total
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Selected Items",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "\$${viewModel.total.toStringAsFixed(2)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.pinkAccent.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              //Shipping charge
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Shipping fee",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "\$${viewModel.shipingCharge}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.pinkAccent.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 15,
                              ),
                              //Sub total
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Subtotal",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "\$${viewModel.subTotal.toStringAsFixed(2)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.pinkAccent.withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                width: double.maxFinite,
                                height: 55,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0))),
                                child: const Center(
                                  child: Text(
                                    "Checkout",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
