import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/extension/context_extensions.dart';
import '../bloc/connectivity_bloc.dart';
import '../bloc/connectivity_state.dart';

class ConnectionStatusBanner extends StatelessWidget {
  final Widget child;

  const ConnectionStatusBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        BlocBuilder<ConnectivityBloc, ConnectivityState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            final isOffline = state.isOffline;
            final topPadding = MediaQuery.of(context).viewPadding.top;

            return AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              offset: isOffline ? Offset.zero : const Offset(0, -1.0),
              child: Material(
                elevation: 4,
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: topPadding + 4,
                    bottom: 8,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.error,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sin conexión - Trabajando offline',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
