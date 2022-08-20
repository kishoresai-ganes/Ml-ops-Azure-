from flask import Flask,redirect, url_for, request,render_template,jsonify
from azure.storage.blob import ContainerClient,BlobClient
import os
app = Flask(__name__)
#Get request
@app.route('/<foldername>')
def fun(foldername):
    res = []
    connect_str = 'DefaultEndpointsProtocol=https;AccountName=storagekishoresai;AccountKey=44xM+MaX25a4d1hVGD3JOFc3ht+yPZxjrz3V3AlWP2yZ/qQVD/ye28smODlzHC2i9XijLSnnMfjN+ASthECchg==;EndpointSuffix=core.windows.net'
    blob_service_client = ContainerClient.from_connection_string(connect_str,container_name="cont")
    blob_list = blob_service_client.list_blobs()
    print(blob_service_client)
    print(blob_list)
    for blob in blob_list:
        temp = str(blob.name)
        folder,file = temp.split('/')
        if folder  ==  foldername:
            res.append(file)
    return jsonify(res)
if __name__ == '__main__':
    app.run(host ='0.0.0.0', port = 5000) 
