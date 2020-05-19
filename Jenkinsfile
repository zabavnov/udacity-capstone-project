pipeline {
     agent any
     stages {
         stage('Build') {
             steps {
                 sh 'echo "Building project"'
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Security Scan') {
              steps {
                 aquaMicroscanner imageName: 'alpine:latest', notCompleted: 'exit 1', onDisallowed: 'fail'
              }
         }
         stage('Docker build') {
              steps {
                 sh'docker build -t capstoneproject:latest .'
              }
         }
     }
}
