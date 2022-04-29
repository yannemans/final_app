import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_app/home/bloc/home_bloc.dart';
import 'package:final_app/services/boredService.dart';
import 'package:final_app/services/connectivityService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dutch Coding Company flutter chalange',
              style: TextStyle(fontSize: 25, foreground: Paint())),
          backgroundColor: Colors.redAccent.withOpacity(0.5),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            state.activityName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("The accesibility has been rated as a "+state.accessibility.toString() +" out of 1 "),
                          Text("The type of activity is "+ state.activityType),
                          Text("the price on a scale of 0 to 1 is \""+state.price.toString()+"\" "),
                          Text("The number of people you can do this with is " +state.participants.toString() + " people",
                          ),
                          ElevatedButton(
                            onPressed: () => BlocProvider.of<HomeBloc>(context)
                                .add(LoadApiEvent()),
                            child: Text('Next activity'),
                          )
                        ],
                      )
                    ]),
              );
            }
            if (state is HomeNoInternetState) {
              return Text('no internet :(');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
