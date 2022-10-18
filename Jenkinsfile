node {
try {
properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '10')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])

def mavenhome = tool name: 'maven3.8.6'

stage ('checkout code'){
git branch: 'development', credentialsId: 'e820db54-3a90-4e00-b4a5-8fd92032dc16', url: 'https://github.com/vikasaroor/maven-web-application.git'
}

//build stage
stage ('build'){
sh "${mavenhome}/bin/mvn package"
}

//sonar report
stage ('sonar_report'){
sh "${mavenhome}/bin/mvn sonar:sonar"
}

//save in nexus repo
stage ('nexus repo'){
sh "${mavenhome}/bin/mvn deploy"
}
}
catch (e) {
    currentBuild.result = "FAILED"
    throw e
  }
 finally {
    // Success or failure, always send notifications
    notifyBuild(currentBuild.result)
  }
  } //node end
  
  def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
  



