import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../Models/Country/countrymodel.dart';
import '../../Repositories/countryrepo.dart';

part 'country_with_state.dart';

class CountryWithCubit extends Cubit<CountryWithState> {
  CountryWithCubit() : super(CountryWithInitial());

  Country? countryResponse;
  void getCountries() {
    //emit(CountryWithInitial());
    CountryRepo().getCountries().then((value) {
      if (value != null) {
        countryResponse = value;
        emit(CountrySuccess());
      } else {
        if (kDebugMode) {
          print("Error");
        }
        emit(CountryFail());
      }
    });
  }
}


// getCountries(){
//   emit(CountryWithInitial()) ;
//   CountryRepo().getCountries().then((value) {
//     if(value != null){
//       emit(CountryWithSuccess(ourResponse: value)) ;
//     }
//     else {
//       emit(CountryErrors()) ;
//     }
//   }
//   );
//
//
//
// }