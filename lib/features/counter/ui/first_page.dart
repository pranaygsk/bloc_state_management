import 'package:bloc_state_management/features/counter/bloc/counter_bloc.dart';
import 'package:bloc_state_management/features/counter/ui/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterBloc, CounterState>(
      bloc: counterBloc,
      listenWhen: (previous, current) => current is CounterActionState,
      buildWhen: (previous, current) => current is !CounterActionState,
      listener: (context, state) {
        if (state is CounterNavigateToSecondPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SecondPage(counterBloc: counterBloc,),
            ),
          );
        } else if (state is CounterIncrementActionState ||
            state is CounterDecrementActionState ||
        state is CounterResetActionState) {
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "First Page",
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  counterBloc.count.toString(),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterNavigateToSecondPageEvent(),
                    );
                  },
                  child: const Text("Navigate"),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterIncrementEvent(),
                    );
                  },
                  child: const Text("Increment"),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterDecrementEvent(),
                    );
                  },
                  child: const Text("Decrement"),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(
                      CounterResetEvent(),
                    );
                  },
                  child: const Text("Reset"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
