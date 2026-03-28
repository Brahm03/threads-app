import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/src/features/home/cubit/cubit/home_cubit.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEnd = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      print('Scroll boshlandi ${scrollController.position.pixels}');
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isEnd = true;
        BlocProvider.of<HomeCubit>(context).getImages(2);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == HomeStatus.loaded) {
            return SafeArea(
              child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: isEnd ? state.images.length + 1 : state.images.length,
                  itemBuilder: (context, index) {
                    if (index == state.images.length) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(40),
                          child: Image.network(
                            state.images[index].data()['image'],
                            height: 500,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }),
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
