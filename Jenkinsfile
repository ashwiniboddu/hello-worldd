pipeline {
    agent any

    environment {
        IMAGE_NAME = "ashwiniboddu/hello-world"
        IMAGE_TAG = "${BUILD_NUMBER}"
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
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
        stage ('Push Image to DockerHub') {
            steps {
                script {
                    //login to DockerHub
                    docker.withRegistry('', DOCKERHUB_CREDENTIALS ) {
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
        stage ('Deploy Docker Image in Kubernetes') {
            steps {
                sh '''
                kubectl create namespace application
                envsubst < deployment.yaml.template > deployment.yaml
                kubectl apply -f deployment.yaml -n application
                kubectl apply -f service.yaml -n application
                '''
            }
        }
    }
}