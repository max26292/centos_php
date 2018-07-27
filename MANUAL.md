# How to use this images
## First of all
* You have these config file: 
    * config_mysql.sh for root password
    * php.ini for php configuration
    * httpd.conf for setup apache config
> You must change these value (if necessary) in these files before build your own image.
* Now, go to the docker file
    * Our image bases from the Centos os so use *yum* to install packages.
    * In this file, you should not change anything before the extention line because that may make your build process fail.
    * If you need to install some extension, do it below the  ########### line and before the ENTRYPOINT
        * For example
         ```shell script
            # ADDITIONAL EXTENSION #####################################
            ########## 
            RUN yum install -y git 
            #### END ADDITONAL EXTENSION
            ENTRYPOINT ["/bin/bash","start.sh"]
        ```
        * You should use && \ if have many commands because using many RUN command makes docker create more layer to build your image so that is cause of large size image
        * Example:
         ```
            RUN yum install -y git && \
                yum install abc xyz
         ```
* Well done, now you can build your own container with command 
     ```docker build -t [your image tag] .```
* *Take a cup of coffe while waiting this process complete.* 
  
 ================================================================================

 ## The next thing is docker compose
 - ### docker compose file (*docker-compose.yml*)
    ```
    version: '3.2'
    services:
        #php host
        host:
            # build:
            image: centos_php:latest
            container_name: host       
            ports:
            - "81:80"
            - "3306:3306"
            environment:
            MYSQL_ROOT_PASSWORD: '#Hitman5066789'
            ############### database for test
            # -change next 3 lines below for whatever you want and use this for test
            MYSQL_USER: user
            MYSQL_PASSWORD: pass
            MYSQL_DATABASE: test_db
            volumes:    
            - ./:/var/www/html/
            networks: 
            - local-net     
    networks:
    local-net:    
        driver: bridge
    volumes:
    mysql:
    ```
*  Now, let take a short view on this file, you should pay your attention on these values on the list below:
    * **build**: That is a location where you execute your new docker file *(advance feature)*
        * That build command will effect directly to **base image** that built on previous step
    * **image**: core of any thing you need
        * To use your built image follow these step
            
            * PS C:\Users\hoang.nguyen> docker images -> to get you image name

            REPOSITORY |   TAG  |   IMAGE ID   |    CREATED   |   SIZE
            -----------|--------|--------------|--------------|----------
            centos_php |  latest| bfd98cff4fe9 |  24 hours ago|  1.59GB

            *What are you need in this?*
            * Repo name: **centos_php**
            * tag: **latest**
            
            The command stucture: 
            * **image: [REPOSITORY]:[TAG]**

            **=>>** So you image line is
            * **image: centos_php:latest**
    * *container_name: host*
            
 
