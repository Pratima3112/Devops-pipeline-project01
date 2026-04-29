pipeline {
  agent any

  environment {
    GITHUB_REPO  = "git@github.com:Pratima3112/Devops-pipeline-project01.git"
    IMAGE_NAME   = "localhost:5000/devops-app"
    IMAGE_TAG    = "1.${BUILD_NUMBER}"
    CLUSTER_NAME = "devops-cluster"
  }

  stages {

    stage('Checkout from GitHub') {
      steps {
        git branch: 'main',
            credentialsId: 'github-credentials',
            url: "${GITHUB_REPO}"
        echo "Checked out commit: ${GIT_COMMIT[0..7]}"
      }
    }

    stage('Build Docker Image') {
      steps {
        sh """
          docker build -f docker/Dockerfile -t ${IMAGE_NAME}:${IMAGE_TAG} .
          docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
        """
      }
    }

    stage('Push to Local Registry') {
      steps {
        sh """
          docker push ${IMAGE_NAME}:${IMAGE_TAG}
          docker push ${IMAGE_NAME}:latest
        """
      }
    }

    stage('Load into Kind') {
      steps {
        sh "kind load docker-image ${IMAGE_NAME}:${IMAGE_TAG} --name ${CLUSTER_NAME}"
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh """
          sed -i 's|localhost:5000/devops-app:.*|${IMAGE_NAME}:${IMAGE_TAG}|g' k8s/deployment.yaml
          kubectl apply -f k8s/deployment.yaml
          kubectl apply -f k8s/service.yaml
          kubectl rollout status deployment/devops-app --timeout=90s
        """
      }
    }

    stage('Smoke Test') {
      steps {
        sh """
          sleep 5
          curl -f http://localhost:30080 || exit 1
        """
      }
    }
  }

  post {
    success {
      echo "Pipeline SUCCESS - commit ${GIT_COMMIT[0..7]} deployed as image tag ${IMAGE_TAG}"
    }
    failure {
      echo "Pipeline FAILED on branch ${GIT_BRANCH}"
    }
  }
}
