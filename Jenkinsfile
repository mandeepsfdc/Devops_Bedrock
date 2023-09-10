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

                // Make the sf/bin/sf executable
                sh "chmod +x ${env.SALESFORCE_CLI_DIR}/bin/sf"
            }
        }
        
        stage('Run Salesforce CLI Command') {
            steps {
                script {
                    // Determine credentials based on the branch
                    // Defalt to these credentials
                    def USERNAME_CREDENTIAL = 'HUB_ORG_DH'
                    def CONSUMER_KEY_CREDENTIAL = 'CONNECTED_APP_CONSUMER_KEY_DH'
                    def SECRET_KEY_CREDENTIAL = 'ae93cc68-5a5c-40fa-bd08-0925a0e60d6e'

                    def fullbranch = GIT_BRANCH
                    def branchName = GIT_BRANCH.split("/").last()
                    echo "Full BranchName: ${fullbranch}"
                    echo "Branch Name: ${branchName}"
                    echo "Branch: ${env.BRANCH_NAME}"
                    
                    if (env.BRANCH_NAME == 'QA-Branch') {
                        USERNAME_CREDENTIAL = 'QA_Username'
                        CONSUMER_KEY_CREDENTIAL = 'QA_Consumer_Key'
                        SECRET_KEY_CREDENTIAL = 'QA_Secret_Key'
                        
                    } else if (env.BRANCH_NAME == 'CI_Branch') {
                        USERNAME_CREDENTIAL = 'CI_Username'
                        CONSUMER_KEY_CREDENTIAL = 'CI_Consumer_Key'
                        SECRET_KEY_CREDENTIAL = 'CI_Secret_Key'
                    }
                    
                    withCredentials([
                        string(credentialsId: USERNAME_CREDENTIAL, variable: 'USERNAME'),
                        string(credentialsId: 'SFDC_HOST_DH', variable: 'LOGIN_URL'),
                        file(credentialsId: SECRET_KEY_CREDENTIAL, variable: 'SECRET_KEY'),
                        string(credentialsId: CONSUMER_KEY_CREDENTIAL, variable: 'CONNECTED_APP_CONSUMER_KEY')
                    ]) {
                        // Now you can use the environment variables directly within this block
                        sh "./${env.SALESFORCE_CLI_DIR}/bin/sf auth:jwt:grant --clientid \$CONNECTED_APP_CONSUMER_KEY --username \$USERNAME --jwtkeyfile \$SECRET_KEY --setdefaultdevhubusername --instanceurl \$LOGIN_URL"
                        sh "./${env.SALESFORCE_CLI_DIR}/bin/sf force:source:deploy -x manifest/package.xml -u ${USERNAME}"
                    }
                }
            }
        }
    }
}
