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
    buildDir = File(rootProject.buildDir, name)

    afterEvaluate {
        plugins.findPlugin("com.android.application")?.let {
            extensions.configure<com.android.build.gradle.AppExtension>("android") {
                compileSdkVersion(35)
                buildToolsVersion = "35.0.1"
            }
        }
        plugins.findPlugin("com.android.library")?.let {
            extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
                compileSdkVersion(35)
                buildToolsVersion = "35.0.1"
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
