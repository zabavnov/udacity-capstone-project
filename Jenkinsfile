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
                    docker capstoneproject ${dockerpath}
                    echo "Docker ID and Image: ${dockerpath}"

                    # Step 3:
                    # Push image to a docker repository
                    docker push ${dockerpath}
                '''
              }
            }  
         }
     }
}
