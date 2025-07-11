pipeline {
    agent any

    tools {
        maven 'maven s/w'
    }

    environment {
        IMAGE_NAME = "ashwiniboddu/hello-world"
        DOCKERHUB_CREDENTIALS = "dockerhub-cred"
    }

    stages {
        stage ('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ashwiniboddu/hello-worldd.git'
            }
        }
        stage ('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage ('Build Docker image') {
            steps{
                sh 'docker build -t ${IMAGE_NAME}:latest .'
            }
        }
        stage ('Push Image to DockerHub') {
            steps {
                script {
                    //login to DockerHub
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS ) {
                        sh "docker push ${IMAGE_NAME}:latest"
                    }
                }
            }
        }
        stage ('Deploy Docker Image in Kubernetes') {
            steps {
                sh '''
                kubectl apply -f deployment.yaml 
                kubectl apply -f service.yaml 
                '''
            }
        }
    }
}