import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/news_app/cubit/NewsCubit.dart';
import 'package:newsapp/shared/component/componentes.dart';

import '../news_app/cubit/NewsStates.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context, state) {},
    builder: (context, state) {
        var list = NewsCubit.get(context).business;

        return articleBuilder(list,context);
    },
    );

  }
}
