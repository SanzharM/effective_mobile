import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/domain/blocs/main_screen/main_screen_bloc.dart';
import 'package:effective_mobile/domain/models/best_seller.dart';
import 'package:effective_mobile/domain/models/hot_sale.dart';
import 'package:effective_mobile/domain/models/item_category.dart';
import 'package:effective_mobile/ui/screens/main_screen/category_builder.dart';
import 'package:effective_mobile/ui/widgets/custom_dropdown.dart';
import 'package:effective_mobile/ui/widgets/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'best_sellers_widget.dart';
import 'hot_sales_widget.dart';
import 'location_widget.dart';
import 'search_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _bloc = MainScreenBloc();

  List<ItemCategory> categories = [];
  bool isCategoriesLoading = false;

  List<BestSeller> bestSellers = [];
  List<HotSale> hotSales = [];
  bool isMainDataLoading = false;

  int? _selectedIndex;

  Placemark? _placemark;

  @override
  void initState() {
    super.initState();
    _bloc.getCategroies();
    _bloc.getData();
    _bloc.getLocation();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).hasFocus ? () => FocusScope.of(context).unfocus() : null,
      child: Scaffold(
        body: BlocListener<MainScreenBloc, MainScreenState>(
          bloc: _bloc,
          listener: (_, state) {
            if (state is CategoriesLoading) {
              isCategoriesLoading = true;
            }
            if (state is CategoriesLoaded) {
              isCategoriesLoading = false;
              categories = state.categories;
              _selectedIndex = 0;
            }
            if (state is MainScreenLoading) {
              isMainDataLoading = true;
            }
            if (state is MainScreenDataLoaded) {
              isMainDataLoading = false;
              bestSellers = state.bestSellers;
              hotSales = state.hotSales;
            }

            if (state is CurrentLocationLoaded) {
              _placemark = state.placemark;
            }
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: AppBar().preferredSize.height),
                LocationWidget(
                  address: _placemark?.locality,
                  onFilterPressed: _filterSheet,
                ),
                const Padding(
                  padding: EdgeInsets.all(AppConstraints.padding),
                  child: SectionTitle(
                    title: 'Select Product',
                    moreText: 'view all',
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: CategoryBuilder(
                    selectedIndex: _selectedIndex,
                    categories: categories,
                    isLoading: isCategoriesLoading,
                    onCategoryPressed: (i) => setState(() => _selectedIndex = i),
                  ),
                ),
                const SizedBox(height: AppConstraints.padding),
                const SearchBar(),
                const SizedBox(height: AppConstraints.padding),
                HotSalesWidget(
                  items: hotSales,
                  isLoading: isMainDataLoading,
                ),
                const SizedBox(height: AppConstraints.padding),
                BestSellersBuilder(
                  bestSellers: bestSellers,
                  isLoading: isMainDataLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _filterSheet() async {
    const brands = ['Samsung', 'iPhone', 'Huawei', 'Oppo', 'LG'];
    String brand = brands.first;

    const prices = ['\$300 - \$500', '\$500 - \$800', '\$800 - \$1200'];
    String price = prices.first;

    const sizes = ['3.5 to 4.5 inches', '4.5 to 5.5 inches', '5.5 to 6.5 inches'];
    String size = sizes.first;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(borderRadius: AppConstraints.borderRadiusTLR),
      builder: (_) => StatefulBuilder(
        builder: (context, newSetState) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstraints.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      color: AppColors.darkGrey,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Icon(CupertinoIcons.xmark),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Filter options',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Flexible(
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
                      color: AppColors.primary,
                      child: const Text('Done'),
                      onPressed: () {
                        // Handle Query Params
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstraints.padding),
              CustomDropdown<String>(
                title: 'Brand',
                currentValue: brand,
                values: brands,
                onChanged: (String? val) {
                  newSetState(() => brand = val ?? brand);
                  debugPrint(val);
                },
              ),
              const SizedBox(height: AppConstraints.padding),
              CustomDropdown<String>(
                title: 'Price',
                currentValue: price,
                values: prices,
                onChanged: (String? val) {
                  newSetState(() => price = val ?? price);
                  debugPrint(val);
                },
              ),
              const SizedBox(height: AppConstraints.padding),
              CustomDropdown<String>(
                title: 'Size',
                currentValue: size,
                values: sizes,
                onChanged: (String? val) {
                  newSetState(() => size = val ?? size);
                  debugPrint(val);
                },
              ),
              const SizedBox(height: AppConstraints.padding),
            ],
          ),
        ),
      ),
    );
  }
}
