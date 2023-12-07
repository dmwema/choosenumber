import 'package:choosenumber/model/citeria.dart';

import 'package:flutter/material.dart';

//FontName
const fNSfUiBold = 'SfUiBold';
const fNSfUiRegular = 'SfUiRegular';
const fNSfUiMedium = 'SfUiMedium';
const fNSfUiLight = 'SfUiLight';
const fNSfUiSemiBold = 'SfUiSemiBold';
const fNSfUiHeavy = 'SfUiHeavy';

//video view time in seconds
const viewTime = 5;

var criteriaList = <Criteria>[
  Criteria(id: 1, text: "Free Number"),
  Criteria(id: 2, text: "By Prefix"),
  Criteria(id: 3, text: "By Suffix")
];
var reservationTypes = <String>["Person", "Enterprise"];
const double radiusCircular = 15;

const String TOKEN_KEY = "access_token";
const String REFRESH_KEY = "refresh_token";
const String AUTH_USER_KEY = "user";
