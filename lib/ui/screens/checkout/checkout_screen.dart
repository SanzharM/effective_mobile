import 'package:effective_mobile/core/constants/constants.dart';
import 'package:effective_mobile/core/supporting/utils.dart';
import 'package:effective_mobile/domain/blocs/cart/cart_bloc.dart';
import 'package:effective_mobile/domain/models/cart.dart';
import 'package:effective_mobile/domain/models/cart_item.dart';
import 'package:effective_mobile/ui/screens/checkout/cart_item_widget.dart';
import 'package:effective_mobile/ui/screens/checkout/checkout_cell.dart';
import 'package:effective_mobile/ui/widgets/app_icon_button.dart';
import 'package:effective_mobile/ui/widgets/custom_appbar.dart';
import 'package:effective_mobile/ui/widgets/custom_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _bloc = CartBloc();

  Cart? _cart;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc.getCart();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          // Add Address
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add Address',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0),
              ),
              AppIconButton(
                color: AppColors.primary,
                icon: const Icon(Icons.place_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: BlocListener<CartBloc, CartState>(
        bloc: _bloc,
        listener: (context, state) {
          isLoading = state is CartLoading;
          if (state is CartLoaded) {
            _cart = state.cart;
          }
          if (state is CartErrorState) {
            debugPrint('CartErrorState: ${state.error}');
          }
          setState(() {});
        },
        child: CustomShimmer(
          isLoading: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstraints.padding,
                  vertical: AppConstraints.padding * 2,
                ),
                child: Text(
                  'My Cart',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: AppConstraints.borderRadiusTLR,
                    color: AppColors.darkGrey,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(AppConstraints.padding),
                          itemBuilder: (_, i) => CartItemWidget(
                            cartItem: isLoading ? const CartItem() : _cart?.basket?[i],
                            onIncrease: () => setState(() => _cart = _cart?.increaseQuantity(i)),
                            onDecrease: () => setState(() => _cart = _cart?.decreaseQuantity(i)),
                            onDelete: () {},
                          ),
                          separatorBuilder: (_, sep) => const SizedBox(height: 8.0),
                          itemCount: isLoading ? 2 : _cart?.basket?.length ?? 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstraints.padding),
                        child: Divider(color: AppColors.white.withOpacity(0.25)),
                      ),
                      CheckoutCell(
                        leftText: 'Total',
                        rightText: Utils.toFormattedPrice(_cart?.total),
                      ),
                      CheckoutCell(
                        leftText: 'Delivery',
                        rightText: _cart?.delivery ?? '',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppConstraints.padding),
                        child: Divider(color: AppColors.white.withOpacity(0.25)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppConstraints.padding),
                        child: CupertinoButton(
                          color: AppColors.primary,
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              'Checkout',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.apply(color: AppColors.white),
                            ),
                          ),
                          onPressed: () {
                            if (isLoading) return;
                            _bloc.purchase();
                          },
                        ),
                      ),
                      const SizedBox(height: AppConstraints.padding),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
