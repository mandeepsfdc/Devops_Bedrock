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

                // The Salesforce CLI directory should be 'sf'
                // Make the sf/bin/sf executable
                sh "chmod +x ${env.SALESFORCE_CLI_DIR}/bin/sf"
            }
        }

        stage('Determine Branch and Set Environment') {
            steps {
                script {
                    // Check the branch name
                    if (env.BRANCH_NAME == 'A') {
                        // Set QA environment credentials
                        env.CRED_ID_ORG = 'QA_HUB_ORG'
                        env.CRED_ID_HOST = 'QA_SFDC_HOST'
                        env.CRED_ID_KEY_FILE = 'QA_JWT_KEY_FILE'
                        env.CRED_ID_CON_APP_KEY = 'QA_CONNECTED_APP_CONSUMER_KEY'
                    } else if (env.BRANCH_NAME == 'SIT') {
                        // Set SIT environment credentials
                        env.CRED_ID_ORG = 'SIT_HUB_ORG'
                        env.CRED_ID_HOST = 'SIT_SFDC_HOST'
                        env.CRED_ID_KEY_FILE = 'SIT_JWT_KEY_FILE'
                        env.CRED_ID_CON_APP_KEY = 'SIT_CONNECTED_APP_CONSUMER_KEY'
                    }
                }
            }
        }

        stage('Run Salesforce CLI Command') {
            steps {
                // Use the withCredentials block to access the secret text credentials
                withCredentials([
                    string(
                        credentialsId: env.CRED_ID_ORG,
                        variable: 'HUB_ORG'
                    ),
                    string(
                        credentialsId: env.CRED_ID_HOST,
                        variable: 'SFDC_HOST'
                    ),
                    file(
                        credentialsId: env.CRED_ID_KEY_FILE,
                        variable: 'JWT_KEY_FILE'
                    ),
                    string(
                        credentialsId: env.CRED_ID_CON_APP_KEY,
                        variable: 'CONNECTED_APP_CONSUMER_KEY'
                    )
                ]) {
                    // Now you can use the environment variables directly within this block
                    sh "./${env.SALESFORCE_CLI_DIR}/bin/sf auth:jwt:grant --clientid \$CONNECTED_APP_CONSUMER_KEY --username \$HUB_ORG --jwtkeyfile \$JWT_KEY_FILE --setdefaultdevhubusername --instanceurl \$SFDC_HOST"
                    sh "./${env.SALESFORCE_CLI_DIR}/bin/sf force:source:deploy -x manifest/package.xml -u ${HUB_ORG}"
                }
            }
        }
    }
}
