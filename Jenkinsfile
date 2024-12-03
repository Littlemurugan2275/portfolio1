pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-creds') // Ensure this is the correct credential ID in Jenkins
        GIT_REPO_URL = 'https://github.com/Littlemurugan2275/portfolio1.git'
        IMAGE_NAME = 'littlemurugan2275/portfolio1:latest'  // Updated image name to match the repo name
        CONTAINER_NAME = 'portfolio-container'  // Use the same name as the container you're deploying
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
                        echo ${DOCKER_CREDENTIALS_PSW} | docker login -u ${DOCKER_CREDENTIALS_USR} --password-stdin
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
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p 8080:80 ${IMAGE_NAME}
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
