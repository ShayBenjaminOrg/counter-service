pipeline {
    agent { node { label 'agent-docker' } }
    environment {
        DOCKERHUB_CREDENTIALS=credentials('DockerhubCreds')
    }
    stages {
        stage('Clone the repo') {
            steps {
                sh 'whoami'
                echo 'clone the repo'
                sh 'rm -fr counter-service'
                sh 'git clone https://github.com/ShayBenjaminOrg/counter-service.git'
            }
        }
        stage('Build the image') {
            steps {
                //sh 'sudo su ec2-user'
                sh 'whoami'
                sh 'pwd'
                echo 'connect to remote host and pull down the latest version'
                sh 'docker image build -t shayben/counter-service:v1 .'
                echo 'image built'
                

                //sh 'ssh ec2-user@10.0.1.197 touch /var/www/html/index_pipe.html'
                //sh 'ssh ec2-user@10.0.1.139 sudo git -C /var/www/html pull'
            }
        }
        stage("verify dockers") {
            steps {
                sh 'docker images'
            }
        }
        stage("push to DockerHub") {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push shayben/counter-service:v1'
            }
        }
        stage('Deploy the image') {
            steps {
                //sh 'sudo su ec2-user'
                sh 'whoami'
                sh 'pwd'
                echo 'connect to remote host and pull down the latest version'
                //sh 'ssh ec2-user@10.0.1.197 touch /var/www/html/index_pipe.html'
                //sh 'ssh ec2-user@10.0.1.139 sudo git -C /var/www/html pull'
            }
        }
        stage('Check website is up') {
            steps {
                echo 'Check website is up'
                //sh 'curl -Is 10.0.1.197 | head -n 1'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
