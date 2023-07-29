pipeline {
    agent any

    environment {
        // Define Salesforce CLI URL
        SALESFORCE_CLI_URL = 'https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-darwin-x64.tar.xz'
        SALESFORCE_CLI_FILE = 'sf-cli.tar.xz'
        SALESFORCE_CLI_DIR = 'sf'
    }

    stages {
        stage('Install Salesforce CLI') {
            steps {
                // Download Salesforce CLI
                sh "curl -o ${env.SALESFORCE_CLI_FILE} ${env.SALESFORCE_CLI_URL}"
                
                // Extract the downloaded CLI
                sh "tar -xf ${env.SALESFORCE_CLI_FILE}"

                // List the files in the current directory
                sh "ls -al"
                
                // Rename the sf-cli.exe to sf
                sh "mv sf-cli.exe sf"
                
                // Make the downloaded CLI executable
                sh "chmod +x sf"
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
                    sh "./sf auth:jwt:grant --clientid \$CONNECTED_APP_CONSUMER_KEY --username \$HUB_ORG --jwtkeyfile \$JWT_KEY_CRED_ID --setdefaultdevhubusername --instanceurl \$SFDC_HOST"
                }
            }
        }
    }
}
