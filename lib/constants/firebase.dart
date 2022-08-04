import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const String userCollection = "users";
const String restaurantCollection = "restaurants";
const String hotelCollection = "hotels";
const String reservationCollection = "reservations";
const String ecotourismCollection = "ecotourisms";
const String imagesCollection = "images";

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final firebaseMessaging = FirebaseMessaging.instance;
