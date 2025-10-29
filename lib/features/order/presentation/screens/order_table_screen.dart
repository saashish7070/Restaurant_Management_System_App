import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rms/features/order/domain/entities/order_entity';
import 'package:rms/features/order/presentation/bloc/order_bloc.dart';
import 'package:rms/shared/widgets/appbar.dart';
class OrderTableScreen extends StatefulWidget {
  final String tableNumber;
  const OrderTableScreen({super.key, required this.tableNumber});

  @override
  State<OrderTableScreen> createState() => _OrderTableScreenState();
}

class _OrderTableScreenState extends State<OrderTableScreen> {
  static const Color brandOrange = Color(0xFFF7621B);

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(LoadMenuItems(widget.tableNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        brandOrange: brandOrange,
        name: "Table ${widget.tableNumber}"
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is OrderLoading || state is OrderInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<OrderBloc>().add(LoadMenuItems(widget.tableNumber)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is! OrderLoaded) {
            return const Center(child: Text('Failed to load menu'));
          }

          final menuItems = state.menuItems;
          final cartMap = state.cartItems;

          if (menuItems.isEmpty) {
            return const Center(child: Text('No menu items available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final qty = cartMap[item.id]?.quantity ?? 0;
                
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // // Image Section
                      // Expanded(
                      //   flex: 3,
                      //   child: ClipRRect(
                      //     borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      //     child: Container(
                      //       color: Colors.grey[100],
                      //       child: item.imageUrl.isNotEmpty 
                      //           ? Image.network(
                      //               item.imageUrl,
                      //               fit: BoxFit.cover,
                      //               errorBuilder: (context, error, stackTrace) => 
                      //                 _buildPlaceholderImage(),
                      //             )
                      //           : _buildPlaceholderImage(),
                      //     ),
                      //   ),
                      // ),
                      
                      // Name Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Price Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\$${item.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      // Quantity Controls
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: qty == 0 ? null : () {
                                context.read<OrderBloc>().add(RemoveItemFromCart(item.id));
                              },
                              icon: Icon(
                                Icons.remove_circle_outline,
                                color: qty == 0 ? Colors.grey : Colors.redAccent,
                              ),
                              iconSize: 28,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$qty',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: brandOrange,
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                context.read<OrderBloc>().add(
                                  AddItemToCart(
                                    OrderItem(
                                      id: '', // Will be set in BLOC
                                      menuItemId: item.id,
                                      name: item.name,
                                      quantity: 1,
                                      price: double.tryParse(item.price) ?? 0.0,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_circle_outline),
                              iconSize: 28,
                              color: Colors.green,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  // Widget _buildPlaceholderImage() {
  //   return const Center(
  //     child: Icon(Icons.fastfood, size: 40, color: Colors.grey),
  //   );
  // }

  Widget _buildBottomNavBar(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final isSeated = state is OrderLoaded ? state.isSeated : false;
        final cartItems = state is OrderLoaded ? state.cartItems : {};

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Seat Status Toggle
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: brandOrange),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.read<OrderBloc>().add(UpdateTableSeatedStatus(false));
                            },
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: !isSeated ? brandOrange : Colors.transparent,
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                              ),
                              child: Text(
                                'Empty',
                                style: TextStyle(
                                  color: !isSeated ? Colors.white : brandOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.read<OrderBloc>().add(UpdateTableSeatedStatus(true));
                            },
                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(25)),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSeated ? brandOrange : Colors.transparent,
                                borderRadius: const BorderRadius.horizontal(right: Radius.circular(25)),
                              ),
                              child: Text(
                                'Seated',
                                style: TextStyle(
                                  color: isSeated ? Colors.white : brandOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Place Order Button
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: cartItems.isEmpty
                          ? null
                          : () {
                              _showOrderSummary(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cartItems.isEmpty ? Colors.grey : brandOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 20),
                      label: const Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold, 
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showOrderSummary(BuildContext context) {
    final state = context.read<OrderBloc>().state;
    if (state is! OrderLoaded) return;

    final cartItems = state.cartItems.values.toList();
    final total = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Text(
                'Order Summary - Table ${widget.tableNumber}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              if (cartItems.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('No items in cart'),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('\$${item.price} x ${item.quantity}'),
                        trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
              
              if (cartItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<OrderBloc>().add(PlaceOrder());
                    context.go('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}