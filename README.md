# Ml-ops-Azure-
# Azure Fundamentals
This is repository contains the flask app, that displays the names of all the files present in my Azure Container.
This is the first assignment of the MLOps-Azure training.

# Running the app on a local machine
In order to run the flask app, perform the following steps

1. Make sure you have set up the environment with all the dependencies.
2. Activate the virtual environment by typing `source azure_env/bin/activate`
2. Login to your Azure Account, using `az login` command in your terminal.
3. Go to the root directory of the project, that is just outside of the `flask_app` folder in the project directory.
4. Run the command `flask run` and open `localhost:5000` in any browser.
5. Your app should run perfectly!

# Running the app deployed on the Azure Server
1. Make sure that the app is running on the Azure VM.
2. Click on the link [Azure App](azure-vm-dns.eastus.cloudapp.azure.com:5000).


# Project Directory
* `flask_app`: This directory contains `hello.py`.
* `hello.py`: This file is used to deploy flask app into the virtual machine.

# Code Explanation
## `hello.py`
In this file, the code first connects with the Azure Storage Container and then fetches the blob names. 

* For creating a blob service client, the following code is executed
```
# Creating the blob service client 
connect_str = 'AZURE_STORAGE_CONNECTION_STRING'
blob_service_client = ContainerClient.from_connection_string(connect_str,container_name="codecontainer")
```

* For connecting with a specific container, we provide the name of that container to the service client
```
# Getting the existing container from the storage account
container_name = 'XXXXX'
container_client = blob_service_client.get_container_client(container_name)
```

* Using the container_client created above, the blob names are fetched and shown in the localhost.
```
blob_list = blob_service_client.list_blobs()
    print(blob_service_client)
    print(blob_list)
    for blob in blob_list:
        temp = str(blob.name)
        folder,file = temp.split('/')
        if folder  ==  foldername:
            res.append(file)
```
# Billing Information
  (bill.png)
