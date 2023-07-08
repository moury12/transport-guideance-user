import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  static final auth=FirebaseAuth.instance;
  static User? get currentUser=>auth.currentUser;
  static Future<bool> login(String email,String password) async {
    final credential =await auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user!=null;
  }
  static Future<UserCredential> register(String email,String password)async{
    final credential =await auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }
  static Future<void> logout() => auth.signOut();

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}