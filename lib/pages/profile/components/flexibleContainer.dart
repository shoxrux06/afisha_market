import 'package:afisha_market/core/bloc/profile/profile/profileBloc.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileEvent.dart';
import 'package:afisha_market/core/bloc/profile/profile/profileState.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FlexibleContainer extends StatefulWidget {
  const FlexibleContainer({Key? key}) : super(key: key);

  @override
  State<FlexibleContainer> createState() => _FlexibleContainerState();
}

class _FlexibleContainerState extends State<FlexibleContainer> {
  bool isButton = true;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProfileState) {
          return Container(
            color: Colors.lightBlueAccent.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: mainColor,
                      child: ClipOval(
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/afisha_logo.png'),
                          image: NetworkImage(
                              state.profileResponse.user!.avatar),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/afisha_logo.png',
                                fit: BoxFit.fitWidth);
                          },
                          width: 156,
                          height: 156,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyText(
                    state.profileResponse.user!.fullname.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        MyText(
                          '${l10n?.category}: ',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        MyText(
                          state.profileResponse.user!.adminUserCategory
                              .toString(),
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        MyText(
                          '${l10n?.accountStatus} ',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        MyText(
                          state.profileResponse.user!.status.toString(),
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        FittedBox(
                          child: MyText(
                            '${l10n?.address}: ',
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            child: MyText(
                              ' ${state.profileResponse.user!.viloyat} ${state.profileResponse.user!.tuman}',
                              color: Colors.blue,
                              fontSize: 14,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyText(
                    "${l10n?.profileViews} ${state.profileResponse.user!.views.toString()} ${l10n?.people}",
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  Container(
                    child: isButton
                        ? MyBigButton(
                            "Контакты",
                            onTap: () {
                              setState(
                                () {
                                  isButton = !isButton;
                                },
                              );
                            },
                          )
                        : MyWrappedText(
                            state.profileResponse.user!.phone.toString(),
                            onTap: () async {
                              final url = Uri.parse(
                                  'tel:${state.profileResponse.user!.phone.toString()}');
                              if (await canLaunchUrl(url)) {
                                launchUrl(url);
                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {
                                    isButton = !isButton;
                                  });
                                });
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            onTap2: () {
                              setState(() {
                                isButton = !isButton;
                              });
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProfileErrorState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n?.noInternet??'',style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),),
              SizedBox(height: 24,),
              InkWell(
                onTap: () {
                  context.read<ProfileBloc>().add(GetProfileEvent());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 56,
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text(l10n?.refresh??'', style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
