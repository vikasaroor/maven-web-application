node {
    
    properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])
    
    def mavenhome = tool name: 'maven3.8.6'
    
    stage ('getfromGIT'){
    git branch: 'development', credentialsId: 'e820db54-3a90-4e00-b4a5-8fd92032dc16', url: 'https://github.com/vikasaroor/maven-web-application.git'    
    }
    
    stage ('Build'){
    sh "${mavenhome}/bin/mvn clean package"
    }
    
    stage ('sonarresult'){
    sh "${mavenhome}/bin/mvn sonar:sonar"
    }
    
    stage ('uploadArtifacts'){
    sh "${mavenhome}/bin/mvn deploy"
    }
    
    stage ('deploy to server'){
    sshagent(['e5544ff6-88e8-42a1-b20f-7dd9b7272fd5']) {
    sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@13.233.85.253:/opt/apache-tomcat-9.0.65/webapps"
    }
    }
    
    echo "homedirevtory is : ${env.JENKINS_HOME}"
    
} //node
