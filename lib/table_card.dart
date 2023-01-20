import 'package:cafe_app/constants.dart';
import 'package:cafe_app/constraints/constraints.dart';
import 'package:cafe_app/controllers/home_controller.dart';
import 'package:cafe_app/screens/details/details_screen.dart';
import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/screens/home/components/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'components/icon_btn_with_counter.dart';
import 'home.dart';
import 'cartscreen.dart';

import 'screens/home/components/cart_details_view.dart';
import 'screens/home/components/cart_short_view.dart';
import 'screens/home/components/header.dart';


class TableCard extends StatefulWidget {
  const TableCard({super.key});

  @override
  State<TableCard> createState() => _TableCardState();
}

class _TableCardState extends State<TableCard> with TickerProviderStateMixin{

  final controller = HomeController();
  late TabController _tabController;

  
  
  @override
  void initState(){
    _tabController = TabController(length: 7, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection(){
    if(_tabController.indexIsChanging){
      setState(() {
        
      });
    }
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconBtnWithCounter(
            svgSrc: "Assets/Images/cart.svg",
            press:() {},
           ),
           IconBtnWithCounter(
            svgSrc: "Assets/Images/bell.svg",
            numOfItems: 3,
            press:() {},
           ),
        ],
      ),
     
     
      body: 
      
      SafeArea(
        bottom: false,
        child: Container(
          color: Colors.black,
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: [                         
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                             top: controller.homeState == HomeState.normal
                              ? 85
                              : -(constraints.maxHeight -
                                  100 * 2 -
                                  85),
                          left: 0,
                          right: 0,
                          height: constraints.maxHeight -
                              85 -
                              100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: const BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(20 * 1.5),
                                bottomRight:
                                    Radius.circular(20 * 1.5),
                              ),
                            ),
                            child: GridView.builder(
                              itemCount: demo_products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: demo_products[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: DetailsScreen(
                                          product: demo_products[index],
                                          onProductAdd: () {
                                            controller.addProductToCart(
                                                demo_products[index]);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Card Panel
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: controller.homeState == HomeState.normal
                              ? 100
                              : (constraints.maxHeight - 100),
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.grey[800],
                              alignment: Alignment.topLeft,
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                child: controller.homeState == HomeState.normal
                                    ? CardShortView(controller: controller)
                                    : CartDetailsView(controller: controller),
                              ),
                            ),
                          ),
                        ),
                        // Header
                        // AnimatedPositioned(
                        //   duration: Duration(milliseconds: 500),
                        //   top: controller.homeState == HomeState.normal
                        //       ? 0
                        //       : -85,
                        //   right: 0,
                        //   left: 0,
                        //   height: 85,
                        //   child: HomeHeader(),
                        // ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
    );
     
    
  }
}
