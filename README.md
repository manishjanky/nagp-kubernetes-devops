# nagp-kubernetes-devops

This assignments goal to setup a api service and a databse on kubernetes. The db service must not be exposed outside of the cluster while the api service needs to be exposed.

## Resources

- **API tier docker image** : [manishnagarro/nagp-k8-api-service](https://hub.docker.com/r/manishnagarro/nagp-k8-api-service)
- **Github repo** : [nagp-kubernetes-devops](https://github.com/manishjanky/nagp-kubernetes-devops)
- **API service endpoint** :
  - **On local** : http://localhost:300/movies
  - **On cloud** : http://{your-api-service-endpoint}/movies

### Folders

- **./** : root folder

  - **Dockerfile** : This file is required file to create the image of the nodejs based API Tier.
  - **kustomization.yaml** : This files chains all the K8 spec files for deployments etc. as per _kubectl kustomize_.

- **k8-specs** : This folder containg all the kubernetes specification files

  - **nagp-api.yaml** : This file contains the spec for the API deployment and service named _api-service_
  - **config.yaml** : This file contains the spec for the configmap and secrets i.e. DB credentials and other configs
  - **mysql-db.yaml** : This file contains the spec for the DB deployment and service names _db-service_
  - **namespace.yaml** : This file contains the spec for the namespace _nagp_
  - **volumes.yaml** : This file contains the spec for the PersistentVolume and PersistentVolumeClaim
  - **kustomization.yaml** : This contains specs as per _kubectl kustomize_ to help during the development stage to create/delete resources with one command(explained below in detail)

- **init-db** : This Folder conatins the SQL Db realted files
  - **db-init.sql** : This file contains the DB initialization script that creates a SQL Table and adds some records to the same.

### How to spin things up

#### Method 1:

Change your current directory to this director and apply all the files in ths k8-specs folder in the below mentioned order:

- Create the namespace as all our resources will be linked to this

  ```
  kubectl apply -f ./k8-specs/namespace.yaml
  ```

- Create the configMap and Secret as both API and the DB service depend on this

  ```
  kubectl apply -f ./k8-specs/config.yaml
  ```

- Create persistent volume and volume claim, since db-service will depend on this

  ```
  kubectl apply -f ./k8-specs/volumes.yaml
  ```

- Create the database deployment and service. This should be done befor the API tier so when the API layer attempts to connect the DB should be ready for connections.

  ```
  kubectl apply -f ./k8-specs/mysql-db.yaml
  ```

- Create the API deployment and service.

  ```
  kubectl apply -f ./k8-specs/node-api.yaml
  ```

#### Method 2

- Change your directory to this folder and execute the below command in your terminal

  ```
  kubectl apply k .
  ```

- All your services and deployments are up and running and ready to use.

#### Accessing the deployed services and resources

- Set current namespace context. You can either use the below command or use `kubectl` commands with `-n=<namespace-name>` to execute the command in a particular namespace. In this case the namespace name is **`nagp`**

  ```
  kubectl config set-context --current=true --namespace=nagp
  ```

  or use like

  ```
  kubectl get po -n=nagp
  ```

- If you are on your local machine then your service is accessible on **http://localhost:300/movies**

- If you are on cloud infra then get the endpoint of the API service and you can access the api like **{your-service-endpoint}/movies**

  - Youe can use the below command to get the `service-endpoint`. You will find the endpoint in the External-IP column.

  ```
  kubectl get service api-service
  ```

#### Setup/Add Data

Once all you services, deployments and pods are up and running. Follow the below steps to add some data to the databse.

- Login into the terminal for the mysql DB container either bash or Bourne shell (sh)

  ```
  kubectl exec -it your-pod-name -- /bin/bash.
  ```

- Once inside the terminal, use the below command to login into mysql and enter password when prompted

  ```
  mysql -u your-username-same-as-in-configmap -p
  ```

- Now copy the SQL script loacted in **init-db** folder and paste the same in the mysql terminal. Press enter.

- Now when you hit the service endpoints you will get the data you just added to the database

### Deleting resources

> Note 1: take care while deleting the reources. If you delete a volume claim whichis bound to a volume, the volume will be deleted or release based on reclaim policy. but if the claim is delete, the will not be bound again even if you create the same claim again, becuase its not the same claim as in it is just using the same specs.

> Note 2: Also if you create a namespace and add your resources to that namespace. So when you delete the namespace everthing in that namespace will be deleted.

#### Method 1

- In order to delete execute the below commond to delete all the resources(i.e. everything you created)

  ```
  kubectl delete -k .
  ```

#### Method 2

- Execute the below command one by one for each file. if you delete a resources that other resources depend on it will delete the dependent resource too. For eg. if you delete the namespace first it will delete all esources linked to that namespace.

  ```
  kubectl delete -f ./k8-specs/{filename}.yaml
  ```

#### Method 3 : Development stage only

- Use the below command to delete everything except the persistent volume, volume claim and namespace. This is to help in the development process only.

  ```
  kubectl delete -k ./k8-specs
  ```

#### Method 4

- Use below command to delete each resource one by one

  ```
  kubectl delete {resource-type:[service | pod | pv | pvc | namespace | deployment | congifmap | secret]} {resource-name}
  ```
