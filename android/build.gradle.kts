import org.gradle.api.tasks.Delete
import org.gradle.kotlin.dsl.register
import org.gradle.api.tasks.Exec
import java.io.File

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Redéfinition du dossier build principal
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

// Dossiers build pour les sous-projets
subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Assurer l’évaluation de :app avant les sous-projets
subprojects {
    project.evaluationDependsOn(":app")
}

// Tâche clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// --- SAUVEGARDE AUTOMATIQUE SI BUILD RÉUSSI ---
gradle!!.buildFinished {
    // Vérifie que toutes les tâches ont réussi
    val buildSucceeded = gradle!!.taskGraph.allTasks.all { it.state.failure == null }

    if (buildSucceeded) {
        println("Build réussi — lancement sauvegarde automatique")
        exec {
            executable = "powershell"
            args = listOf("-ExecutionPolicy", "Bypass", "-File", "../auto_save.ps1")
        }
    } else {
        println("Build échoué — pas de sauvegarde")
    }
}
