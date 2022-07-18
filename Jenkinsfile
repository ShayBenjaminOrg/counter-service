pipeline {
    //agent { node { label 'agent-docker' } }
    agent any
    environment {
        DOCKERHUB_CREDENTIALS=credentials('DockerhubCreds')
    }
    parameters { string description: 'Choose the branch to build', name: 'Branch', trim: true, defaultValue: 'dev' }
    
    stages {
        stage('Clone the repo') {
            steps {
                sh 'whoami'
                echo 'clone the repo'
                sh 'rm -fr counter-service'
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/${Branch}']], 
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://github.com/ShayBenjaminOrg/counter-service.git']]
                ])
            }
        }
        stage('Build the image') {
            steps {
                //sh 'sudo su ec2-user'
                sh 'docker --version'
                sh 'whoami'
                sh 'pwd'
                sh 'ls -la'
                echo 'connect to remote host and pull down the latest version'
                sh 'docker image build -t shayben/counter-service:v1 .'
                echo 'image built succeffuly '
                

                //sh 'ssh ec2-user@10.0.1.197 touch /var/www/html/index_pipe.html'
                //sh 'ssh ec2-user@10.0.1.139 sudo git -C /var/www/html pull'
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
                    usernamePassword(
                        credentialsId: 'DockerhubCreds', 
                        passwordVariable: 'PASS', 
                        usernameVariable: 'USERNAME')]) {
                    
                        echo '${DOCKERHUB_CREDENTIALS_PSW}'
                        echo '${DOCKERHUB_CREDENTIALS_USR}'
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
                     sh 'docker stop counter-service && docker rm counter-service'
                     sh 'docker run -u 0 --name counter-service --rm -p 80:5000 -d shayben/counter-service:v1'
                     
                }
                
                echo 'connect to remote host and pull down the latest version'
                //sh 'ssh ec2-user@10.0.1.197 touch /var/www/html/index_pipe.html'
                //sh 'ssh ec2-user@10.0.1.139 sudo git -C /var/www/html pull'
            }
        }
        stage('Check website is up') {
            steps {
                echo 'Check website is up'
                //sh 'curl -Is ec2-54-93-101-39.eu-central-1.compute.amazonaws.com'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
