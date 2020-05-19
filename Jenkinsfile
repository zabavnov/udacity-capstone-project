pipeline {
     agent any
     environment {
         dockerpath = "zabavnov/capstoneproject"
     }
     stages {
         stage('Build') {
             steps {
                 sh 'echo "Building project"'
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
                  sh 'echo "Lint success"'
              }
         }
         stage('Security Scan') {
              steps {
                 aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail',  outputFormat: 'json'
              }
         }
         stage('Docker build') {
              steps {
                 sh'docker build -t capstoneproject:latest .'
              }
         }
         stage('Docker push') {
              steps {
              withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                sh '''
                    docker tag capstoneproject ${dockerpath}
                    echo "Docker ID and Image: ${dockerpath}"

                    # Step 3:
                    # Push image to a docker repository
                    docker push ${dockerpath}
                '''
              }
            }
            stage('Deploy k8s') {
                 steps {
                withAWS(region:'us-west-2',credentials: 'aws-k8s') {
                 sh '''
                 eksctl create cluster \
                --name prod \
                --region us-west-2 \
                --zones us-west-1a \
                --zones us-west-1b \
                --version 1.16 \
                --nodegroup-name nodes \
                --node-type t3.medium \
                --node-ami auto \
                --nodes 2 \
                --nodes-min 1 \
                --nodes-max 2
                kubectl apply --filename=k8-config.yml
                 '''
                 }
            }
        }
         }
     }
}
