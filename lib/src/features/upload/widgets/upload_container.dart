import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threads_app/main.dart';
import 'package:threads_app/src/features/upload/cubit/upload_cubit.dart';
import 'package:threads_app/src/features/upload/cubit/upload_state.dart';
import 'package:toastification/toastification.dart';

class UploadContainer extends StatelessWidget {
  const UploadContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listener: (context, state) {
        if (state.status == UploadStatus.loaded) {
          Navigator.pop(context);
          toastification.show(
              type: ToastificationType.success,
              title: Text('Uploaded to AppWrite'));
        } else if (state.status == UploadStatus.error) {
          toastification.show(
              type: ToastificationType.error, title: Text(state.errorText));
        }
      },
      builder: (context, state) => Container(
        width: double.infinity,
        height: 500,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Spacer(),
                Text(
                  'Make Post',
                  style: GoogleFonts.montserrat(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton.filled(
                    onPressed: state.status == UploadStatus.loading
                        ? null
                        : () {
                            context.read<UploadCubit>().uploadMedia();
                          },
                    icon: state.status == UploadStatus.loading
                        ? CircularProgressIndicator()
                        : Icon(Icons.send))
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Comments...', border: UnderlineInputBorder()),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        context.read<UploadCubit>().pickMedia();
                      },
                      icon: Icon(Icons.folder))),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.pictures.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.file(
                          state.pictures[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
