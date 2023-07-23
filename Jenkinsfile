#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH

    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
        pipeline {
	    agent any
	    environment {
	        // Define Salesforce CLI URL
	        SALESFORCE_CLI_URL = 'https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-x64.exe'
	    }
	    stages {
	        stage('Install Salesforce CLI') {
	            steps {
	                // Download Salesforce CLI
	                sh "curl -o sf-cli.exe ${env.SALESFORCE_CLI_URL}"
	                
	                // Make the downloaded CLI executable
	                sh "chmod +x sf-cli.exe"
	            }
	        }
	        stage('Run Salesforce CLI Command') {
	            steps {
	                // Run Salesforce CLI command
	                sh "./sf-cli.exe auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultdevhubusername --instanceurl ${SFDC_HOST}"
	            }
	        }
	    }
	}

    }
}
