pipeline {
    agent any
    environment {
        GITNAME='lunarbakery99'
        GITMAIL='lunarbakery0720@gmail.com'
        GITWEBADD='https://github.com/lunarbakery99/fast-code.git'
        GITSSHADD='git@github.com:lunarbakery99/deployment.git'
        GITCREDENTIAL='git_cre'
        DOCKERHUB='kyungyeonmoon/fast'
        DOCKERHUBCREDENTIAL='docker_cre'
   }
    stages {
        stage('Checkout Github') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [],
                userRemoteConfigs: [[credentialsId: GITCREDENTIAL, url: GITWEBADD]]])
                slackSend (
                    channel: '#jenkins_notification',
                    color: '#FFFF00',
                    message: "STARTED: ${currentBuild.number}"
                )

            }
            post {
                failure {
                    sh "echo clone failed"
                }
                success {
                    sh "echo clone success"
                }
            }
        }
        stage('docker image build') {
            steps {
                sh "docker build -t ${DOCKERHUB}:${currentBuild.number} ."
                // currentBuild.number 젠킨스가 제공하는 빌드넘버 변수
                
            }
            post {
                failure {
                    sh "echo image build failed"
                }
                success {
                    sh "echo image build success"
                }
            }
        }
        stage('docker image push') {
            steps {
                withDockerRegistry(credentialsId: DOCKERHUBCREDENTIAL, url: '') {
                    sh "docker push ${DOCKERHUB}:${currentBuild.number}"
                }
            }
            post {
                failure {
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "echo push failed"
                    // 성공하든 실패하든 로컬에 있는 도커이미지는 삭제
                }
                success {
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "echo push success"
                    // 성공하든 실패하든 로컬에 있는 도커이미지는 삭제
                }
            }
        }
        stage('EKS manifest file update') {
            steps {
                git credentialsId: GITCREDENTIAL, url: GITSSHADD, branch: 'main'
                sh "git config --global user.email ${GITMAIL}"
                sh "git config --global user.name ${GITNAME}"
                sh "sed -i 's@${DOCKERHUB}:.*@${DOCKERHUB}:${currentBuild.number}@g' fast.yml"

                sh "git add ."
                sh "git branch -M main"
                sh "git commit -m 'fixed tag ${currentBuild.number}'"
                sh "git remote remove origin"
                sh "git remote add origin ${GITSSHADD}"
                sh "git push origin main"
            }
            post {
                failure {
                    sh "echo manifest update failed"
                }
                success {
                    sh "echo manifest update success"
                }
            }
        }
        stage('start') {
            steps {
                sh "echo hello jenkins!!!"
            }
            post {
                failure {
                    slackSend (
                    channel: '#jenkins_notification',
                    color: '##FF0000',
                    message: "Failed: ${currentBuild.number}"
                )
                }
                success {
                    slackSend (
                    channel: '#jenkins_notification',
                    color: '#FFFF00',
                    message: "Success: ${currentBuild.number}"
                )
                }
            }
        }
    }
}