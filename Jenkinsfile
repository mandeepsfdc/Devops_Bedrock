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
