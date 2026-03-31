import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/src/features/reels/cubit/cubit/reel_cubit.dart';
import 'package:threads_app/src/features/reels/widgets/custom_video_widget.dart';
import 'package:toastification/toastification.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<ReelCubit, ReelState>(
        listener: (context, state) {
          if (state.status == ReelStatus.error) {
            toastification.show(
                type: ToastificationType.error, title: Text(state.errorText));
          }
        },
        builder: (context, state) {
          if (state.status == ReelStatus.loading) {
            return Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            );
          } else if (state.status == ReelStatus.loaded) {
            return Stack(
              children: [
                PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.videos.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          CustomVideoWidget(
                              link: state.videos[index].data()['url']),
                          Positioned(
                              bottom: MediaQuery.sizeOf(context).height * 0.5,
                              right: 20,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        context.read<ReelCubit>().onLike(
                                            state.videos[index].id,
                                            state.videos[index]
                                                .data()['likes']);
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 40,
                                        color: state.videos[index]
                                                    .data()['likes'] <
                                                0
                                            ? Colors.black
                                            : Colors.red,
                                      )),
                                  Text(
                                    '${state.videos[index].data()['likes']}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      );
                    }),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
