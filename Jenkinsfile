//comment
Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any //usar cualquier agente de jenkins, porque podemos tener esclavos para lanzar diferentes tipos de aplicaciones

    stages {
        stage('Checkout-git') {//se baja el repositorio
            steps {
                git poll: true, url: 'git@github.com:CMHugo/test-jenkins.git'
            }
        }
        stage('CreateVirtualEnv') {//creacion del entorno virtual de python
            steps {
                sh '''
                    bash -c "virtualenv  entorno_virual && source entorno_virtual/bin/activate"
                '''
            }
        }
        stage('InstallRequirements') {//instalar los requerimientos
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pip install -r requirements.txt"
                '''
            }
        }   
        stage('TestApp') {//prueba de test
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/entorno_virtual/bin/activate &&  cd src && ${WORKSPACE}/entorno_virtual/bin/python ${WORKSPACE}/entorno_virtual/bin/pytest && cd .."
                '''
            }
        }  
        stage('RunApp') {//correr la app
            steps {
            	sh '''
            		bash -c "source entorno_virtual/bin/activate ; ${WORKSPACE}/entorno_virtual/bin/python src/main.py &"
                '''
            }
        } 
        stage('BuildDocker') {//montar el docker
            steps {
            	sh '''
            		docker build -t apptest:latest .
                '''
            }
        } 
    stage('PushDockerImage') {//subir el docker
            steps {
            	sh '''
            		docker tag apptest:latest mihub/apptest:latest
					docker push mihub/apptest:latest
					docker rmi apptest:latest
                '''
            }
        } 
  }
}


/*post {
    success {
      mail to: "XXXXX@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
    }
    failure {
      mail to: "XXXXX@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Boo, we failed."
    }*/