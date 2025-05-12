//import java.util.Properties
//import java.io.FileInputStream
//
//plugins {
//    id("com.android.application")
//    // START: FlutterFire Configuration
//    id("com.google.gms.google-services")
//    // END: FlutterFire Configuration
//    id("kotlin-android")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//}
//
//android {
////    namespace = "com.greencorp.greenfarm.triple_h.dev"
//    namespace = "com.greencorp.greenfarm.triple_h"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = "27.0.12077973"
//
//    compileOptions {
////        sourceCompatibility = JavaVersion.VERSION_11
////        targetCompatibility = JavaVersion.VERSION_11
//        sourceCompatibility = JavaVersion.VERSION_1_8
//        targetCompatibility = JavaVersion.VERSION_1_8
//        coreLibraryDesugaringEnabled = true
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
////        applicationId = "com.greencorp.greenfarm.triple_h.dev"
//        applicationId = "com.greencorp.greenfarm.triple_h"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdk = 23
//        targetSdk = 33
//        versionCode = 1
//        versionName = "1.0.1"
//    }
//    flavorDimensions += "environment"
//
//    productFlavors {
//        create("dev") {
//            dimension = "environment"
//            applicationIdSuffix = ".dev"
//            versionNameSuffix = "-dev"
//            manifestPlaceholders["flutterTarget"] = "lib/main_dev.dart"
//        }
//        create("staging") {
//            dimension = "environment"
//            // Final Application ID: com.yourcompany.yourapp.staging
//            applicationIdSuffix = ".staging"
//            versionNameSuffix = "-staging"
//        }
//        create("prod") {
//            dimension = "environment"
//            // Final Application ID: com.yourcompany.yourapp
//        }
//    }
//
////     Load keystore properties from key.properties file
//    val keystoreProperties = Properties()
//    val keystorePropertiesFile = file("key.properties")
////    val keystorePropertiesFile = rootProject.file("key.properties")
//    if (keystorePropertiesFile.exists()) {
//        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
//    }
//
//    signingConfigs {
//        create("release") {
//            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: ""
//            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: ""
//            storeFile = keystoreProperties["storeFile"]?.toString()?.let { file(it) } ?: file(".")
//            storePassword = keystoreProperties["storePassword"]?.toString() ?: ""
//        }
//    }
//
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now,
//            // so `flutter run --release` works.
////            signingConfig = signingConfigs.getByName("debug")
//            signingConfig = signingConfigs.getByName("release")
//        }
//        debug {
//            // TODO: Add your own signing config for the debug build.
//            // Signing with the debug keys for now,
//            // so `flutter run` works.
////            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//flutter {
//    source = "../.."
//}
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter Gradle Plugin
}

android {
    namespace = "com.greencorp.greenfarm.triple_h" // Updated namespace for dev flavor
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_1_8
//        targetCompatibility = JavaVersion.VERSION_1_8
//        isCoreLibraryDesugaringEnabled = true // Use 'isCoreLibraryDesugaringEnabled' in Kotlin DSL
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_1_8.toString()
//    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.greencorp.greenfarm.triple_h" // Updated Application ID
        minSdk = 23
        targetSdk = 33
        versionCode = 1
        versionName = "1.0.1"
    }

    flavorDimensions += "environment"

    productFlavors {
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
            manifestPlaceholders["flutterTarget"] = "lib/main_dev.dart"
        }
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"
            versionNameSuffix = "-staging"
        }
        create("prod") {
            dimension = "environment"
        }
    }

    val keystoreProperties = Properties()
    val keystorePropertiesFile = file("key.properties")
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: ""
            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: ""
            storeFile = keystoreProperties["storeFile"]?.toString()?.let { file(it) } ?: file(".")
            storePassword = keystoreProperties["storePassword"]?.toString() ?: ""
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
        debug {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
//    implementation("com.android.tools:desugar_jdk_libs:2.0.3") // Core library desugaring dependency
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

