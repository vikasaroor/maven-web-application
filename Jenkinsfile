node {

properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '10', daysToKeepStr: '', numToKeepStr: '10')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * * ')])])
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

echo "current BN is ${currentBuild.number}"
echo "JN home is  ${env.JENKINS_HOME}"
//deploy to tomcat
stage ('deply war'){
 sshagent(['e5544ff6-88e8-42a1-b20f-7dd9b7272fd5']) {
sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@13.235.42.173:/opt/apache-tomcat-9.0.65/webapps"
} 
}
}//nodeend
