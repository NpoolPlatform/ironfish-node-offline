pipeline {
  agent any
  environment {
    GOPROXY = 'https://goproxy.cn,direct'
    IRONFISH_VERSION = "v1.0.1"
  }
  tools {
    go 'go'
  }
  stages {
    stage('Clone ironfish node offline') {
      steps {
        git(url: scm.userRemoteConfigs[0].url, branch: '$BRANCH_NAME', changelog: true, credentialsId: 'KK-github-key', poll: true)
      }
    }

    stage('Build ') {
      when {
        expression { BUILD_TARGET == 'true' }
      }

      steps {
        sh 'make build'
      }
    }

     stage('Release ') {
      when {
        expression { RELEASE_TARGET == 'true' }
      }

      steps {
        sh 'make release'
      }
    }

    stage('Deploy ') {
      when {
        expression { DEPLOY_TARGET == 'true' }
      }

      steps {
        sh 'make deploy'
      }
    }

    stage('Tag') {
      when {
        anyOf{
          expression { TAG_MAJOR == 'true' }
          expression { TAG_MINOR == 'true' }
          expression { TAG_PATCH == 'true' }
        }
        anyOf{
          expression { TAG_FOR == 'testing' }
          expression { TAG_FOR == 'production' }
        }
      }
      steps {
        sh(returnStdout: true, script: '''
          set +e
          // sync remote tags
          git tag -l | xargs git tag -d
          git fetch origin --prune
          // get last tag
          revlist=`git rev-list --tags --max-count=1`
          rc=$?
          set -e
          major=0
          minor=0
          patch=-1
          
          if [ 0 -eq $rc ]; then
            tag=`git describe --tags $revlist`
            major=`echo $tag | awk -F '.' '{ print $1 }'`
            minor=`echo $tag | awk -F '.' '{ print $2 }'`
            patch=`echo $tag | awk -F '.' '{ print $3 }'`
          fi
          if [ "$TAG_MAJOR" == 'true' ]; then
            major=$(( $major + 1 ))
            minor=0
            patch=-1
          elif [ "$TAG_MINOR" == 'true' ]; then
            minor=$(( $minor + 1 ))
            patch=-1
          fi    
          case $TAG_FOR in
            testing)
              patch=$(( $patch + $patch % 2 + 1 ))
              ;;
            production)
              patch=$(( $patch + ( $patch +  1 ) % 2 + 1 ))
              git reset --hard
              git checkout $tag
              ;;
          esac
          tag=$major.$minor.$patch
          
          git tag -a $tag -m "Bump version to $tag"
        '''.stripIndent())

        withCredentials([gitUsernamePassword(credentialsId: 'KK-github-key', gitToolName: 'git-tool')]) {
          sh 'git push --tag'
        }
      }
    }
  }

  post('Report') {
    fixed {
      script {
        sh(script: 'bash $JENKINS_HOME/wechat-templates/send_wxmsg.sh fixed')
     }
      script {
        // env.ForEmailPlugin = env.WORKSPACE
        emailext attachmentsPattern: 'TestResults\\*.trx',
        body: '${FILE,path="$JENKINS_HOME/email-templates/success_email_tmp.html"}',
        mimeType: 'text/html',
        subject: currentBuild.currentResult + " : " + env.JOB_NAME,
        to: '$DEFAULT_RECIPIENTS'
      }
     }
    success {
      script {
        sh(script: 'bash $JENKINS_HOME/wechat-templates/send_wxmsg.sh successful')
     }
      script {
        // env.ForEmailPlugin = env.WORKSPACE
        emailext attachmentsPattern: 'TestResults\\*.trx',
        body: '${FILE,path="$JENKINS_HOME/email-templates/success_email_tmp.html"}',
        mimeType: 'text/html',
        subject: currentBuild.currentResult + " : " + env.JOB_NAME,
        to: '$DEFAULT_RECIPIENTS'
      }
     }
    failure {
      script {
        sh(script: 'bash $JENKINS_HOME/wechat-templates/send_wxmsg.sh failure')
     }
      script {
        // env.ForEmailPlugin = env.WORKSPACE
        emailext attachmentsPattern: 'TestResults\\*.trx',
        body: '${FILE,path="$JENKINS_HOME/email-templates/fail_email_tmp.html"}',
        mimeType: 'text/html',
        subject: currentBuild.currentResult + " : " + env.JOB_NAME,
        to: '$DEFAULT_RECIPIENTS'
      }
     }
    aborted {
      script {
        sh(script: 'bash $JENKINS_HOME/wechat-templates/send_wxmsg.sh aborted')
     }
      script {
        // env.ForEmailPlugin = env.WORKSPACE
        emailext attachmentsPattern: 'TestResults\\*.trx',
        body: '${FILE,path="$JENKINS_HOME/email-templates/fail_email_tmp.html"}',
        mimeType: 'text/html',
        subject: currentBuild.currentResult + " : " + env.JOB_NAME,
        to: '$DEFAULT_RECIPIENTS'
      }
     }
  }
}
