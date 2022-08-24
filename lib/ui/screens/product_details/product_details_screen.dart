import 'package:effective_mobile/core/api/endpoints.dart';
import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/domain/blocs/product_detail/product_detail_bloc.dart';
import 'package:effective_mobile/domain/models/product_detail.dart';
import 'package:effective_mobile/ui/screens/app_router.dart';
import 'package:effective_mobile/ui/widgets/app_icon_button.dart';
import 'package:effective_mobile/ui/widgets/custom_appbar.dart';
import 'package:effective_mobile/ui/widgets/custom_shimmer.dart';
import 'package:effective_mobile/ui/widgets/image_slider.dart';
import 'package:effective_mobile/ui/widgets/titled_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'capacities_widget.dart';
import 'colors_widget.dart';
import 'detail_card.dart';
import 'rating_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with SingleTickerProviderStateMixin {
  final _bloc = ProductDetailBloc();

  late TabController _tabController;

  bool isLoading = false;
  ProductDetail? _product;

  int? _selectedColor;
  int? _selectedCapacity;

  @override
  void initState() {
    super.initState();
    _bloc.getProduct();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _bloc.close();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: 'Product details',
        actions: [
          AppIconButton(
            icon: const Icon(CupertinoIcons.bag, color: AppColors.white),
            color: AppColors.primary,
            onPressed: () => AppRouter.toCheckout(context),
          ),
        ],
      ),
      body: BlocListener<ProductDetailBloc, ProductDetailState>(
        bloc: _bloc,
        listener: (_, state) async {
          isLoading = state is ProductLoadingState;

          if (state is ProductLoaded) {
            _product = state.product;
            if (state.product.colors?.isNotEmpty ?? false) _selectedColor = 0;
            if (state.product.capacity?.isNotEmpty ?? false) _selectedCapacity = 0;
          }
          if (state is ProductErrorState) {
            debugPrint('Error state: ${state.error}');
          }
          setState(() {});
        },
        child: CustomShimmer(
          isLoading: isLoading,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: AppConstraints.padding),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ImageSlider(
                    imageUrls: _product?.images ?? [''],
                    itemCount: _product?.images?.length ?? 1,
                    errorWidget: (_, url, error) => const SizedBox(),
                  ),
                ),
              ),
              SliverFillRemaining(
                fillOverscroll: true,
                hasScrollBody: false,
                child: DetailCard(
                  headerTitle: _product?.title,
                  headerActions: [
                    AppIconButton(
                      icon: Icon(
                        _product?.isFavorites ?? false ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        if (_product?.id != null) {
                          // _bloc.setIsFavorites(id: _product!.id!, value: !(_product!.isFavorites));
                        }
                      },
                    ),
                  ],
                  children: [
                    RatingWidget(rating: _product?.rating),
                    const SizedBox(height: 12.0),
                    TabBar(
                      padding: EdgeInsets.zero,
                      controller: _tabController,
                      indicatorColor: AppColors.primary,
                      tabs: ['Shop', 'Details', 'Features']
                          .map((e) => Tab(
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Text(e, textAlign: TextAlign.center),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      height: 64,
                      child: TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: TitledIcon(asset: AppIcons.cpu, value: _product?.cpu ?? '')),
                              Expanded(child: TitledIcon(asset: AppIcons.camera, value: _product?.camera ?? '')),
                              Expanded(child: TitledIcon(asset: AppIcons.ssd, value: _product?.ssd ?? '')),
                              Expanded(child: TitledIcon(asset: AppIcons.sd, value: _product?.sd ?? '')),
                            ],
                          ),
                          const Text('Details'),
                          const Text('Features'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppConstraints.padding),
                      child: Text(
                        'Select color and capacity',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      height: 32,
                      margin: const EdgeInsets.only(bottom: AppConstraints.padding),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ProductColorsWidget(
                            colors: isLoading ? [AppColors.black, AppColors.black] : _product?.colors,
                            onColorPressed: (i) => setState(() => _selectedColor = i),
                            selectedColor: _selectedColor,
                            itemCount: isLoading ? 2 : null,
                          ),
                          const SizedBox(width: AppConstraints.padding),
                          ProductCapacitiesWidget(
                            capacity: _product?.capacity,
                            onCapacityPressed: (i) => setState(() => _selectedCapacity = i),
                            selectedCapacity: _selectedCapacity,
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      color: AppColors.primary,
                      padding: const EdgeInsets.all(AppConstraints.padding),
                      onPressed: () {
                        AppRouter.toCheckout(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Add to cart',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.apply(color: AppColors.white),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\$${_product?.price ?? ''}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium?.apply(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
