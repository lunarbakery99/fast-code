pipeline {
    agent any
    environment {
        GITNAME='lunarbakery99'
        GITMAIL='lunarbakery0720@gmail.com'
        GITWEBADD'https://github.com/lunarbakery99/fast-code.git'
        GITSSHADD='git@github.com:lunarbakery99/fast-code.git'
        GITCREDENTIAL='git_cre'
        DOCKERHUB='kyungyeonmoon/fast'
        DOCKERHUBCREDENTIAL='docker_cre'
   }
    stages {
        stage('Checkout Github') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [],
                userRemoteConfigs: [[credentialsId: GITCREDENTIAL, url: GITWEBADD]]])
            }
            post {
                failure {
                    sh "echo failed"
                }
                success {
                    sh "echo success"
                }
            }
        }
        stage('start') {
            steps {
                sh "echo hello jenkins!!!"
            }
            post {
                failure {
                    sh "echo failed"
                }
                success {
                    sh "echo success"
                }
            }
        }
        stage('start2') {
            steps {
                sh "echo hello jenkins!!!"
            }
            post {
                failure {
                    sh "echo failed"
                }
                success {
                    sh "echo success"
                }
            }
        }
        stage('start3') {
            steps {
                sh "echo hello jenkins!!!"
            }
            post {
                failure {
                    sh "echo failed"
                }
                success {
                    sh "echo success"
                }
            }
        }
    }
}