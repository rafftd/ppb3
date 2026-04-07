allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    afterEvaluate {
        if (!project.hasProperty("android")) return@afterEvaluate

        val androidExt = extensions.findByName("android") ?: return@afterEvaluate
        val getNamespace = androidExt.javaClass.methods
            .find { it.name == "getNamespace" && it.parameterCount == 0 }
        val setNamespace = androidExt.javaClass.methods
            .find { it.name == "setNamespace" && it.parameterCount == 1 }

        if (getNamespace != null && setNamespace != null) {
            val namespace = getNamespace.invoke(androidExt) as? String
            if (namespace.isNullOrBlank()) {
                setNamespace.invoke(androidExt, project.group.toString())
            }
        }
    }

    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    if (project.path != ":app") {
        project.evaluationDependsOn(":app")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
