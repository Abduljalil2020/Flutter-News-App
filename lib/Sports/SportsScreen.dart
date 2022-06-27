
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/component/componentes.dart';

import '../news_app/cubit/NewsCubit.dart';
import '../news_app/cubit/NewsStates.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;

        return articleBuilder(list,context);
      },
    );

  }
}
