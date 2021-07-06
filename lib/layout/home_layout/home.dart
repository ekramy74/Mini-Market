import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/home_layout/cubit/cubit.dart';
import 'package:mini_market/layout/home_layout/cubit/states.dart';
import 'package:mini_market/modules/search/search.dart';
import 'package:mini_market/sharing/components/components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Mini Market'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search_rounded),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  })
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}
