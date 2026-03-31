import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/src/features/home/cubit/cubit/home_cubit.dart';
import 'package:toastification/toastification.dart';
// * usb debugging switch
// * wifi debugging
// * adb -> install
// * port -> adb tcpip

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEnd = false;
  ScrollController scrollController = ScrollController();
  bool showArrow = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isEnd = true;
        setState(() {});
      } else if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent / 2)) {
        showArrow = true;
        setState(() {});
      } else if (scrollController.position.pixels <
          (scrollController.position.maxScrollExtent / 2)) {
        showArrow = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
          visible: showArrow,
          child: IconButton.filled(
              onPressed: () {
                scrollController.animateTo(0.0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
              icon: Icon(Icons.arrow_upward))),
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
                  itemCount:
                      isEnd ? state.images.length + 1 : state.images.length,
                  itemBuilder: (context, index) {
                    if (index == state.images.length) {
                      return Center(
                        child: OutlinedButton(
                            onPressed: () async {
                              await context.read<HomeCubit>().getImages(2, () {
                                HapticFeedback.vibrate();
                                toastification.show(
                                    type: ToastificationType.warning,
                                    title: Text('No more left !'));
                              });
                              await HapticFeedback.vibrate();
                            },
                            child: Text('Load more')),
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
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.image),
                              );
                            },
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
