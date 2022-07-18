pipeline {
    //agent { node { label 'agent-docker' } }
    agent any
    parameters { string description: 'Choose the branch to build', name: 'Branch', trim: true, defaultValue: 'dev' }
    
    stages {
        stage('Clone the repo') {
            steps {
                sh 'whoami'
                echo 'cloning the repo'
                sh 'rm -fr counter-service'
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/${Branch}']], 
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://github.com/ShayBenjaminOrg/counter-service.git']]
                ])
                
                echo 'GIT_COMMIT ${GIT_COMMIT}'
                echo 'GIT_LOCAL_BRANCH ${GIT_LOCAL_BRANCH}'
                echo 'GIT_PREVIOUS_COMMIT ${GIT_PREVIOUS_COMMIT}'
                echo 'GIT_URL ${env.GIT_URL}'
                echo 'GIT_URL_N ${GIT_URL_N}'
                echo 'GIT_AUTHOR_NAME ${GIT_AUTHOR_NAME}'
            }
        }
        stage('Build the image') {
            steps {
                
                sh 'docker --version'
                sh 'whoami'
                sh 'pwd'
                sh 'ls -la'
                echo 'connect to remote host and pull down the latest version'
                sh 'docker image build -t shayben/counter-service:v1 .'
                echo 'image built succeffuly '
            }
        }
        stage('verify dockers') {
            steps {
                sh 'docker images'
            }
        }
        stage('push to DockerHub') {
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'DockerhubCreds', 
                                        passwordVariable: 'PASS', usernameVariable: 'USERNAME')]) {
                        echo '${USERNAME}'
                        echo '${PASS}'
                        sh 'docker login -u ${USERNAME} -p ${PASS} && docker push shayben/counter-service:v1'
                }
            }
        }
        stage('Deploy the image') {
            steps {
                 withCredentials([
                    usernamePassword(credentialsId: 'DockerhubCreds', 
                                    passwordVariable: 'PASS', usernameVariable: 'USERNAME')]) {
                     sh 'whoami'
                     sh 'pwd'
                     sh 'docker login -u ${USERNAME} -p ${PASS} && docker pull shayben/counter-service:v1'
                     sh 'docker stop counter-service || true'
                     sh 'docker run -u 0 --name counter-service --rm -p 80:5000 -d shayben/counter-service:v1'
                     
                }
                echo 'connect to remote host and pull down the latest version'
            }
        }
        stage('Check website is up') {
            steps {
                echo 'Check website is up'
                sh returnStdout: true, script: 'curl -s ec2-54-93-101-39.eu-central-1.compute.amazonaws.com'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}