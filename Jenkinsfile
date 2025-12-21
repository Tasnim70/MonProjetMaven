pipeline {
    agent any

    tools {
        maven 'M2_HOME'  // nom de ton installation Maven sur Jenkins
        jdk 'JAVA_HOME'   // nom de ton JDK sur Jenkins
    }

    environment {
        SONAR_TOKEN = credentials('sonar') // token SonarQube
    }

    stages {

        stage('Checkout Git') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Tasnim70/MonProjetMaven.git'
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Build & Test') {
            steps {
                // Utilisation du profil "test" pour H2
                sh 'mvn verify -Dspring.profiles.active=test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('cube') {
                    sh 'mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN} -Dspring.profiles.active=test'
                }
            }
        }

        stage('Package JAR') {
            steps {
                sh 'mvn package -DskipTests -Dspring.profiles.active=test'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
    }

    post {
        always {
            echo 'Nettoyage du workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline CI/CD exécuté avec succès !'
        }
        failure {
            echo 'Échec du pipeline. Vérifie les logs.'
        }
    }
}
