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
          branch 'bugfix'
        }
      }
      steps {
        gctsDeploy(
          script: this
          host: 'https://s4hana2021.clebaltech.com:8010',
          client: '200',
          abapCredentialsId: 'ADITYA_CREDENTIALS',
          repository: 'adtygpt-adtygpt',
          remoteRepositoryURL: "https://github.com/adtygpt/adtygpt",
          role: 'PROVIDED',
          vSID: 'DEV',
          branch: 'bugfix',
          commit: '	0ea3e78',
          scope: 'LASTACTION',
          rollback: true,
          configuration: [VCS_AUTOMATIC_PULL: 'FALSE',VCS_AUTOMATIC_PUSH: 'FALSE',CLIENT_VCS_LOGLVL: 'debug']

          )
      }
    }
  }
}
