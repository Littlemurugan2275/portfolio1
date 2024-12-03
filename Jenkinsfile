pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-creds') // Replace with the actual ID of your Docker credentials in Jenkins
        GIT_REPO_URL = 'https://github.com/Littlemurugan2275/portfolio1.git'
        IMAGE_NAME = 'littlemurugan2275/dockerwebimg:latest'
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning GitHub repository...'
                git branch: 'main', url: "${GIT_REPO_URL}"
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh '''
                    docker build -t ${IMAGE_NAME} .
                '''
            }
        }
        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                script {
                    sh '''
                        echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                        docker push ${IMAGE_NAME}
                        docker logout
                    '''
                }
            }
        }
        stage('Deploy Container') {
            steps {
                echo 'Deploying Docker container...'
                sh '''
                    docker stop portfolio-container || true
                    docker rm portfolio-container || true
                    docker run -d --name portfolio-container -p 8080:80 ${IMAGE_NAME}
                '''
            }
        }
    }
    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
