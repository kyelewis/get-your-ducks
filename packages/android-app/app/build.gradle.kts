plugins {
    id("com.android.application")
    kotlin("android")
}

android {
    compileSdk = 31

    defaultConfig {
        applicationId = "com.kyedoesdev.getyourducks"
	      targetSdk = 31
        versionCode = 1
        versionName = "0.1.0"
    }

    buildFeatures {
        compose = true
    }

    composeOptions {
        kotlinCompilerExtensionVersion = "1.3.1"
    }

}

dependencies {
    // Kotlin
    implementation("androidx.core.core-ktx:1.3.2")
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.7.10")

    // Jetpack Compose
    implementation("androidx.compose.ui:ui:1.2.1")
    implementation("androidx.activity:activity-compose:1.6.0")
}

