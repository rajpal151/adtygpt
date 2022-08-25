@Library(['piper-lib-os']) _
pipeline {
  agent any
  options {
    disableConcurrentBuilds()
  }
  stages {
    stage('Prepare') {
      when {
        anyOf {
          branch 'bugfix'
        }
      }
      steps {
        checkout scm
        setupCommonPipelineEnvironment script:this
      }
    }
    stage('Deploy') {
      when {
        anyOf {
          branch 'feature'
        }
      }
      steps {
        gctsDeploy(
          script: this
          )
      }
    }
  }
}
