# napg-kubernetes-devops

This assignments goal to setup a api service and a databse on kubernetes. The db service must not be exposed outside of the cluster while the api service needs to be exposed.

## Resources

- **API tier docker image** :
- **Github repo** :
- **API service endpoint** :
  - **On local machine** : https://localhost:300/movies
  - **On cloud** : https://your-api-service-endpoint/movies

### Folders

- **./** : Aka the root folder

  - **Dockerfile** : This file is required file to create the image of the nodejs based API Tier.
  - **kustomization.yaml** : This files chains all the K8 spec files for deployments etc.

- **k8-specs** : This folder containg all the kubernetes specification files
  - **api.yaml** : This file contains the spec for the API deployment and service named _api-service_
  - **config.yaml** : This file contains the spec for the configmap and secrets i.e. DB credentials and other configs
  - **db.yaml** : This file contains the spec for the DB deployment and service names _db-service_
- **init-db** : This Folder conatins the SQL Db realted files
  - **db-init.sql** : This file contains the DB initialization script that creates a SQL Table and adds some records to the same.

### How to spin up thing

#### Method 1:

Change your director this director and apply all the files in ths k8-specs folder in the below mentioned order:

- Create the configMap and Secret as both API and the DB service depend on this

  > kubectl apply -f ./k8-specs/config.yaml

- Create the database deployment and service. This should be done first becasue when the API layer attempts to connect the DB should be ready for connections.

  > kubectl apply -f ./k8-specs/mysql-db.yaml

- Create the API deployment and service.
  > kubectl apply -f ./k8-specs/mysql-db.yaml

#### Method 2

- Change your director to this folder and execute the below command in your terminal

  > kubectl apply k .

- All your services and deployments are up and running.

#### Accessing the deployed services

- If you are on your local machine the your service is accessible on **http://localhost:300/movies**

- If you are on cloud infra then get the endpoint of the API service and you can access the api like **{your-service-endpoint}/movies**

##### Setup Database

Once all you services, deployments and pods are up and running. Follow the below steps to add some data to the databse.

- Login into the terminal for the mysql DB container either bash or Bourne shell (sh)

  > kubectl exec -it your-pod-name bash|sh.

- Once inside the terminal, use the below command to login into mysql and enter password when prompted

  > mysql -u your-username-same-as-in-configmap -p

- Now copy the SQL script loacted in **init-db** folder and paste the same in the mysql terminal. Press enter.

- Now when you hit the service endpoints you will get the data you just added to the database
