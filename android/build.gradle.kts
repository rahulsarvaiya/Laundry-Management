buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Android Gradle plugin
        classpath("com.android.tools.build:gradle:8.5.2") // use your AGP version

        // Google Services Gradle plugin (needed for Firebase)
        classpath("com.google.gms:google-services:4.4.2")

        // (Optional) Firebase Crashlytics Gradle plugin
        // classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.9")

        // (Optional) Firebase Performance Monitoring plugin
        // classpath("com.google.firebase:perf-plugin:1.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
