import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';

class LoginStepper extends StatelessWidget {
  const LoginStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.sizeOf(context).height / 2,
        left: 8,
        right: 8,
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return EasyStepper(
            activeStep: state.activeStep,
            lineStyle: LineStyle(
              defaultLineColor: Colors.grey,
              lineLength: MediaQuery.sizeOf(context).width / 4,
              lineType: LineType.normal,
              //unreachedLineType: LineType.normal,
              progress: state.progress,
              finishedLineColor: Theme.of(context).colorScheme.primary,
              progressColor: Theme.of(context).colorScheme.primary,
              lineThickness: 2,
            ),
            stepShape: StepShape.rRectangle,
            stepBorderRadius: 15,
            borderThickness: 2,
            //internalPadding: 10.0,
            stepRadius: 28,
            disableScroll: true,
            showTitle: false,
            /*finishedStepBorderColor: Colors.deepOrange,
                        finishedStepTextColor: Colors.deepOrange,
                        finishedStepBackgroundColor: Colors.deepOrange,
                        activeStepIconColor: Colors.deepOrange,*/
            finishedStepBackgroundColor: Colors.white,
            finishedStepBorderType: BorderType.normal,
            finishedStepBorderColor: Theme.of(context).colorScheme.primary,
            showLoadingAnimation: state.isLoading,
            loadingAnimation: "./assets/images/loading_animation.json",
            fitWidth: true,
            steps: [
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: state.activeStep >= 0 ? 1 : 0.3,
                    child: Image.asset(
                      "./assets/images/${0 == 0 ? "icon_light" : "icon_dark"}.png",
                      height: 35,
                    ),
                  ),
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: state.activeStep >= 1 ? 1 : 0.3,
                    child: const Icon(
                      Icons.telegram,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Opacity(
                    opacity: state.activeStep >= 2 ? 1 : 0.3,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
              /*EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: const Opacity(
                    opacity: 1 >= 3 ? 1 : 0.3,
                    child: Icon(Icons.add),
                  ),
                ),
                customTitle: const Text(
                  'Dash 4',
                  textAlign: TextAlign.center,
                ),
              ),*/
            ],
            onStepReached: (index) {
              if (index < state.activeStep) {
                context.read<LoginBloc>().add(StepChanged(step: index));
              }
            },
          );
        },
      ),
    );
  }
}
