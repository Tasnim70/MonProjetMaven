pipeline {
    agent any
    stages {
        stage('Build & SonarQube Scanner') {
            steps {
                node {
                    checkout scm
                    withSonarQubeEnv('sq1') {
                        sh "mvn clean package sonar:sonar -Dspring.profiles.active=test"
                    }
                }
            }
        }
    }
    post {
        always {
            node {
                cleanWs()
            }
        }
    }
}
