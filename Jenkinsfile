pipeline {
    agent any

    environment {
        // Define Salesforce CLI URL
        SALESFORCE_CLI_URL = 'https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-darwin-x64.tar.xz'
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
                // Use the withCredentials block to access the secret text credentials
                withCredentials([
                    string(
                        credentialsId: 'HUB_ORG_DH',
                        variable: 'HUB_ORG'
                    ),
                    string(
                        credentialsId: 'SFDC_HOST_DH',
                        variable: 'SFDC_HOST'
                    ),
                    string(
                        credentialsId: 'JWT_CRED_ID_DH',
                        variable: 'JWT_KEY_CRED_ID'
                    ),
                    string(
                        credentialsId: 'CONNECTED_APP_CONSUMER_KEY_DH',
                        variable: 'CONNECTED_APP_CONSUMER_KEY'
                    )
                ]) {
                    // Now you can use the environment variables directly within this block
                    sh "./sf-cli.exe auth:jwt:grant --clientid \$CONNECTED_APP_CONSUMER_KEY --username \$HUB_ORG --jwtkeyfile \$JWT_KEY_CRED_ID --setdefaultdevhubusername --instanceurl \$SFDC_HOST"
                }
            }
        }
    }
}
