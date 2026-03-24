import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/src/features/main/cubit/main_cubit.dart';
import 'package:threads_app/src/features/main/cubit/main_state.dart';
import 'package:threads_app/src/features/upload/widgets/upload_container.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context, builder: (context) => UploadContainer());
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(40)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            activeIndex: context.read<MainCubit>().currentIndex(state.status),
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) {
              context.read<MainCubit>().onBottomTap(index);
            },
            itemCount: state.icons.length,
            tabBuilder: (int index, bool isActive) {
              return Icon(
                state.icons[index],
                size: 24,
                color: isActive ? Colors.green : Colors.grey,
              );
            }
            //other params
            ),
      ),
    );
  }
}
