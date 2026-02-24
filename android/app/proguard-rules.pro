# ---------- FLUTTER STANDARD RULES ----------
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
# Ignore missing Play Core classes referenced by Flutter's deferred components engine
-dontwarn com.google.android.play.core.**
-dontwarn io.agora.**
# ---------- FIREBASE SAFETY NET ----------
# Firebase usually handles its own rules automatically, but
# if you experience crashes in release mode, uncomment these:
# -keep class com.google.firebase.** { *; }
# -keep class com.google.android.gms.** { *; }

# Keep your custom models if you are passing custom objects to Firebase Functions
# -keep class com.voicly.app.models.** { *; }