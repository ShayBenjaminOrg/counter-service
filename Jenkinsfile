pipeline {
    agent { node { label 'jenkins-agent' } }
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
                docker image build -t flask_docker .
                echo 'image built'
                sh 'docker images'
                

                //sh 'ssh ec2-user@10.0.1.197 touch /var/www/html/index_pipe.html'
                //sh 'ssh ec2-user@10.0.1.139 sudo git -C /var/www/html pull'
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
}
