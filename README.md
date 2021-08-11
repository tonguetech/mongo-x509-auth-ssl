# tonguetech/mongo-x509-auth-ssl
[![](http://dockeri.co/image/tonguetech/mongo-x509-auth-ssl)](https://registry.hub.docker.com/u/tonguetech/mongo-x509-auth-ssl/) [![](https://badge.imagelayers.io/tonguetech/mongo-x509-auth-ssl:latest.svg)](https://imagelayers.io/?images=tonguetech/mongo-x509-auth-ssl:latest 'Get your own badge on imagelayers.io')

MongoDB 5.0.2 with TLS/SSL and x509 authentication.
This image is intended to be used for testing purposes as it contains insecure self-signed certificates and publicly accessible keypairs.

# How to use this image

    docker run --name mongo-x509 -p 27017:27017 rzhilkibaev/mongo-x509-auth-ssl
This will start up MongoDB listening on 27017.

# Connecting from command line using mongo

Get the client and CA pem files from the container

    $ docker cp mongo-x509:/etc/ssl/mongodb-client.pem mongodb-client.pem
    $ docker cp mongo-x509:/etc/ssl/mongodb-CA.pem mongodb-CA.pem
    
Now use them with `mongo`
    
    $ mongo localhost/admin --ssl \
        --sslPEMKeyFile mongodb-client.pem \
        --sslCAFile mongodb-CA.pem \
        --authenticationDatabase '$external' \
        --authenticationMechanism MONGODB-X509 \
        --username "C=US,ST=CA,L=San Francisco,O=Jaspersoft,OU=JSDev,CN=admin"
        
# Connecting from Java using mongo-java-driver

First get the JKS store file from the container

    $ docker cp mongo-x509:/etc/ssl/mongodb-client.jks mongodb-client.jks
Now you can use it in java. 
```java
System.setProperty("javax.net.ssl.trustStore", "mongodb-client.jks");
System.setProperty("javax.net.ssl.trustStorePassword", "123456");
System.setProperty("javax.net.ssl.keyStore", "mongodb-client.jks");
System.setProperty("javax.net.ssl.keyStorePassword", "123456");

MongoClientURI connectionString = new MongoClientURI("mongodb://localhost:27017/admin?authMechanism=MONGODB-X509&ssl=true");
MongoClient mongoClient = new MongoClient(connectionString);
```

# How to build this image

You can generate certificates and keys for your own server if `localhost` doesn't work for you.

    $ ./generate-certs HOSTNAME
    $ docker build -t my-image --no-cache .
