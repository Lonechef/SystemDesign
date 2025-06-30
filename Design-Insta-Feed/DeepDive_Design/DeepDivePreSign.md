-> So we used Presigned url for generating the media Post so basically we had a service called as Presigned URL SERVICE WHIHC Was generating it for us and then sending to Object Storage 
-> So over here basically so this presigned url will give the user permission to store the data in the Object Storage and the data will be stored over here 
-> That means for particular time period our client has the permission to upload the files to out Object Storage 
### Benefits of Using Presigned URLs for Uploading to Object Storage

- **Security**: Presigned URLs grant temporary, limited access to upload files without exposing credentials or giving broad permissions.
- **Scalability**: Clients upload files directly to Object Storage, reducing load on backend servers.
- **Fine-grained Control**: You can specify permissions, expiration time, and allowed operations for each URL.
- **Simplicity**: No need to implement complex authentication or upload logic on the client side.
- **Auditability**: Each presigned URL can be logged and tracked for auditing purposes.
- **Cost Efficiency**: Offloads data transfer from your servers, potentially reducing bandwidth and compute costs.
