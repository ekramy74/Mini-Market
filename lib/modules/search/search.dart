import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/layout/cubit/cubit.dart';
import 'package:mini_market/modules/search/cubit/search_cubit.dart';
import 'package:mini_market/modules/search/cubit/search_states.dart';
import 'package:mini_market/sharing/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Search'),
                centerTitle: true,
              ),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          onSubmit: (String text) {
                            if (formkey.currentState.validate()) {
                              SearchCubit.get(context).getSearch(text: text);
                            }
                          },
                          onChange: (String text) {
                            SearchCubit.get(context).getSearch(text: text);
                          },
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'you have to write something';
                            }
                          },
                          label: 'Products Search',
                          labelstyle: TextStyle(
                              color: AppCubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white),

                          //outsideicon: Icon(Icons.search),
                          prefix: Icons.search,
                          prefixiconcolor: AppCubit.get(context).isdark
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: AppCubit.get(context).isdark
                                  ? Colors.black
                                  : Colors.white),
                          outlinedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      SizedBox(
                        height: 20,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListItem(
                                  SearchCubit.get(context)
                                      .searchModel
                                      .data
                                      .data[index],
                                  context,
                                  isOldPrice: false),
                              separatorBuilder: (context, index) =>
                                  myDivider(padding: 40),
                              itemCount: SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
