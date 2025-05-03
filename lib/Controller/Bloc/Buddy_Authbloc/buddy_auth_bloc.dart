import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../User_Authbloc/auth_bloc.dart';
import 'Buddyauthmodel/Buddyauthmodel.dart';
import 'buddy_auth_event.dart';
import 'buddy_auth_state.dart';

final buddyid_global = FirebaseAuth.instance.currentUser!.uid;

BuddyModel? userData;

class BuddyAuthBloc extends Bloc<BuddyAuthEvent, BuddyAuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  BuddyAuthBloc() : super(BuddyAuthInitial()) {
    // check Auth or Not
    on<checkBuddyloginstateevent>(
      (event, emit) async {
        User? user;
        try {
          await Future.delayed(Duration(seconds: 3));
          user = _auth.currentUser;
          if (user != null) {
            emit(BuddyAuthenticated(user));
          } else {
            emit(BuddyUnAuthenticated());
          }
         } catch (e) {
          emit(BuddyAuthenticatedError(
            message:
                e.toString().split(' ').last, // Extracts only the message part
          ));
        }
      },
    );
    // Signup
    on<BuddySignupEvent>(
      (event, emit) async {
        emit(BuddyAuthloading());
        try {
          final usercredential = await _auth.createUserWithEmailAndPassword(
              email: event.user.email.toString(),
              password: event.user.password.toString());

          final user = usercredential.user;

          if (user != null) {
            print("done");
            await FirebaseFirestore.instance
                .collection("MallBuddyRiders")
                .doc(user.uid)
                .set({
              "userId": user.uid,
              "email": user.email,
              "Customername": event.user.name,
              "Dateodbirth": event.user.Dob,
              "Gender": event.user.Gender,
              "phone_number": event.user.phone,
              "floor": event.user.floor,
             "aadhaarnumber": event.user.Aadhaarnumber,
              "aadhaarimage": event.user.aadhaarimage,
              "amount": "200",
              "timestamp": DateTime.now(),
              "Onesignal_id": "playerId",
              "Availablestatus": "0",
              "ban": "0",
              "status": "0",
              "imagepath":
                  "https://cdn1.iconfinder.com/data/icons/proffesion/257/Driver-512.png"
            });
            print("completed");
            await _auth.signOut();
            emit(BuddyUnAuthenticated());
          } else {
            await _auth.signOut();
            emit(BuddyUnAuthenticated());
          }
        } catch (e) {
          emit(BuddyAuthenticatedError(message: e.toString().split("]").last));
          print("Buddy Authenticated Error : ${e.toString().split(']').last}");
        }
      },
    );

    on<FetchBuddyDetailsById>((event, emit) async {
      emit(Buddyloading());
      User? user = _auth.currentUser;

      if (user != null) {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final doc = await FirebaseFirestore.instance
                .collection('MallBuddyRiders')
                .doc(user.uid)
                .get();

            if (doc.exists) {
              userData = BuddyModel.fromMap(doc.data()!);
              emit(BuddyByidLoaded(userData!));
            } else {
              emit(Buddyerror(error: "User profile not found"));
            }
          } else {
            emit(Buddyerror(error: "User not authenticated"));
          }
        } catch (e) {
          emit(Buddyerror(error: e.toString()));
        }
      }
    });

    // accept
    User? user = _auth.currentUser;

    on<BuddySigOutEvent>(
      (event, emit) async {
        try {
          if (user != null) {
            await _auth.signOut();
            emit(BuddyUnAuthenticated());
          } else {
            emit(BuddyAuthenticatedError(message: "No user is logged in"));
          }
        } catch (e) {
          emit(BuddyAuthenticatedError(message: e.toString()));
        }
      },
    );

    on<AcceptRejectbuddyevent>(
      (event, emit) async {
        try {
          emit(Acceptloading());

          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(event.id)
              .update({
            "status": event.status,
            "floor": event.floor,
            "amount": event.amount
          });
          emit(Refresh());
        } catch (e) {
          print(e);
        }
      },
    );
    on<editamountfloorevent>(
      (event, emit) async {
        try {
          emit(Acceptloading());
          print(event.id);
          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(event.id)
              .update({"amount": event.amount});
          emit(Refresh());
        } catch (e) {
          print(e);
        }
      },
    );
    on<Buddyavailabletoggleevent>(
      (event, emit) async {
        try {
          emit(Acceptloading());
          print(event.id);
          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(event.id)
              .update({"Availablestatus": event.Availablestatus});
          emit(Refresh());
        } catch (e) {
          print(e);
        }
      },
    );

    //editBuddy//
    on<EditBuddy>((event, emit) async {
      emit(EditBuddyLoading());
      try {
        FirebaseFirestore.instance
            .collection("MallBuddyRiders")
            .doc(event.Buddy.uid)
            .update({
          "Customername": event.Buddy.name,
          "phone_number": event.Buddy.phone,
          "Gender": event.Buddy.Gender,
        });
        emit(BuddyRefresh());
      } catch (e) {
        emit(EditBuddyfailerror(e.toString()));
      }
    });

    on<EditBuddyProfile>((event, emit) async {
      emit(EditBuddyLoading());
      try {
        FirebaseFirestore.instance
            .collection("MallBuddyRiders")
            .doc(event.Buddy.uid)
            .update({
          "Customername": event.Buddy.name,
          "phone_number": event.Buddy.phone,
        });
        emit(BuddyRefresh());
      } catch (e) {
        emit(EditBuddyfailerror(e.toString()));
      }
    });

    //ban//

    on<BanBuddyrevent>(
      (event, emit) async {
        try {
          emit(Buddybanloading());

          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(event.id)
              .update({"ban": event.Ban});
        } catch (e) {
          print(e);
        }
      },
    );

    on<BuddyLoginEvent>(
      (event, emit) async {
        emit(BuddyAuthloading());
        try {
          final userCredential = await _auth.signInWithEmailAndPassword(
            email: event.Email,
            password: event.Password,
          );
          final user = userCredential.user;

          if (user != null) {
            print("Id=======${user.uid}");

            // Fetch user document from Firestore
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection("MallBuddyRiders")
                .doc(user.uid)
                .get();

            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;

              // Check if the 'Ban' field is 1
              if (userData['ban'] == "0") {
                if (userData["status"] == "1") {
                  emit(BuddyAuthenticated(user));
                  print("Auth successfully");
                } else if (userData["status"] == "2") {
                  emit(BuddyUnAuthenticated());
                  await _auth.signOut();
                  emit(BuddyAuthenticatedError(message: "Your are Rejected.."));
                } else {
                  await _auth.signOut();
                  emit(BuddyAuthenticatedError(
                      message: "Please waite ... you are in progress"));
                }
              } else {
                await _auth.signOut();
                emit(BuddyUnAuthenticated());
                emit(BuddyAuthenticatedError(
                    message: "Your account has been deleted."));
              }
            } else {
              await _auth.signOut();
              emit(BuddyAuthenticatedError(message: "User data not found."));
            }
          } else {
            emit(BuddyUnAuthenticated());
          }
        } on FirebaseAuthException catch (e) {
          emit(BuddyAuthenticatedError(
              message: e.message ?? "An error occurred."));
          print("FirebaseAuthException: ${e.message}");
        } catch (e) {
          emit(BuddyAuthenticatedError(
              message: "An unexpected error occurred."));
          print("Login error: ${e.toString()}");
        }
      },
    );

    on<BuddyPickAndUploadImageEvent>((event, emit) async {
      try {
        emit(BuddyProfileImageLoading());

        // ✅ Open file picker
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image, // Pick only image files
          withData: true, // Required for web
        );

        if (result == null) {
          print("No image selected.");
          emit(BuddyProfileImageFailure("No image selected."));
          return; // User canceled selection
        }

        String fileName =
            "Buddyprofile/${DateTime.now().millisecondsSinceEpoch}.jpg";
        Reference storageRef = _firebaseStorage.ref().child(fileName);
        UploadTask uploadTask;

        if (kIsWeb) {
          // ✅ Web: Upload image as bytes
          Uint8List imageData = result.files.first.bytes!;
          uploadTask = storageRef.putData(imageData);
        } else {
          // ✅ Mobile: Upload image as a File
          File imageFile = File(result.files.first.path!);
          uploadTask = storageRef.putFile(imageFile);
        }

        // ✅ Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print("Uploaded Image URL: $downloadUrl");

        // ✅ Update Firestore with the image URL
        if (user != null) {
          await FirebaseFirestore.instance
              .collection("MallBuddyRiders")
              .doc(user.uid)
              .update({"imagepath": downloadUrl});
        }

        emit(BuddyProfileImageSuccess());
      } catch (e) {
        print("Error: $e");
        emit(BuddyProfileImageFailure("Failed to upload image"));
      }
    });

    //   get all Buddy

    on<FetchBuddyDetailsEvent>((event, emit) async {
      emit(BuddygetLoading());
      try {
        CollectionReference BuddyCollection =
            FirebaseFirestore.instance.collection('MallBuddyRiders');

        Query query = BuddyCollection;
        query = query.where("status", isEqualTo: event.status);

        query = query.where("ban", isEqualTo: event.ban);
        query = query.where("floor", isEqualTo: event.floor);

        QuerySnapshot snapshot = await query.get();

        List<BuddyModel> Buddys = snapshot.docs.map((doc) {
          return BuddyModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          Buddys = Buddys.where((driver) {
            return driver.name!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }

        emit(Buddyloaded(Buddys));
      } catch (e) {
        emit(Buddyfailerror(e.toString()));
      }
    });
  }
}
