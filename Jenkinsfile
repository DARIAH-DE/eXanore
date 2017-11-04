node {

  stage('Preparation') {
    checkout scm
    sh 'rm -f build/*.xar'
  }

  stage('Build') {
    sh 'ant'
  }

  stage('Publish') {
    archiveArtifacts artifacts: 'build/*.xar', onlyIfSuccessful: true
    FILENAME = sh (
        script: "find build/ -name '*.xar' -exec basename {} \\;",
        returnStdout: true
      ).trim()
    sh "curl -X POST -F 'file=@build/${FILENAME}' http://localhost:8181/exist/apps/receiver.xql"
  }
  stage('Post') {
      always {
          cleanWs()
      }
  }
}
