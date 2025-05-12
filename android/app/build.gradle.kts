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

