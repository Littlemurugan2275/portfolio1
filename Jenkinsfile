pipeline {
    agent any
    environment {
        GIT_REPO_URL = 'https://github.com/Littlemurugan2275/portfolio1.git'
        IMAGE_NAME = 'littlemurugan2275/portfolio1:latest'
        CONTAINER_NAME = 'portfolio-container'
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                            echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                            docker push ${IMAGE_NAME}
                            docker logout
                        '''
                    }
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
            script {
                node {
                    echo 'Cleaning up workspace...'
                    cleanWs()
                }
            }
        }
    }
}
