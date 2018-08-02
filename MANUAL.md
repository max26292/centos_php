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
        # build: ./dockerfile/
        image: max26292/centos_php:latest
        container_name: host_joombla       
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
        - ./mysql:/var/lib/mysql
        networks: 
        - local-net            
    networks:
    local-net:    
        driver: bridge
    volumes:
    mysql:    
    ```
    
    *  Now, let take a short view on this file, you should pay your attention on these values on the list below:
    1. **build**: That is a location where you execute your new docker file *(advance feature)*
        * That build command will effect directly to **base image** that built on previous step
    1. **image**: core of any thing you need
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

            **=>>** So your image line is
            * **image: centos_php:latest**
    1. *container_name: host (addition attibute) that use to create your container name* so just take a shot look to it 
    1.  ports: 
        - "81:80"
        - "3306:3306"

        **Structure: [host port(*your laptop, bla bla bla*)]:[container port]**

         - For simple, just understand it simply that when you run localhost:81 on your browser it is use port 80 on container and show up what you need on browser.
         - **Notice:** The port on container is the real port of server so please make sure config that right (*Dont point port 80 to port 81 or some thing like that because your website will be not work*)
    1.  Environment:
        ```
        environment:
            - MYSQL_ROOT_PASSWORD: '#Hitman5066789'
            ############### database for test
            # -change next 3 lines below for whatever you want and use this for test
            - MYSQL_USER: user
            - MYSQL_PASSWORD: pass
            - MYSQL_DATABASE: test_db
        ```
        * 4 upon is your mysql account which's used on your website. Anyway, take a long look to it and read some important information below.
            - MYSQL_ROOT_PASSWORD: '#Hitman5066789' That is your root password and it is a really long shit ... cause of security problem when initial run of mysql 5.7.

                **=>> IF YOU WANNA CHANGE IT PLEASE READ THE MYSQL PASSWORD POLICIES TO KEEP YOUR DATABASE WORKING AFTER CHANGE**
            - MYSQL_USER: user (*normal user*)
            - MYSQL_PASSWORD: pass (*normal password after user shit password to change some shit options*)
            - MYSQL_DATABASE: test_db (*your working database name*)
    1. volumes:
        * mount point for your working directory
            ```
                volumes:    
                - ./:/var/www/html/
                - ./mysql:/var/lib/mysql
            ```
            * In this line, I currently mouting root directory of my website to working dir on server
            
            *=> So if you wanna test some thing different like how to remove my shit function on server just change it like **- ./function/:/var/www/html/**  Done*
            * **Another thing is the mounted folder of your mysql database directory on server so please dont touch that**
### Well, your configtion step is done so open your terminal and run command:

* **docker-compose up**  to run it on attach mode ("*It use to debug some error when your builder make something wrong*")
* **docker-compose up -d** to run it on detach mode ("*using when everything is working fine*")
* **docker-compose build** to buildy your dockerfile on first step
* **NOTICE:**
    * *a small diffent thing with xampp or wamp is your database host is 0.0.0.0 instead of localhost or 127.0.0.1*
# *That all =]]~ wellcome to shit world*

 =================================================================================
# Advandtage guide
*Not complete so dont follow that*
## **The second way to install more extension without touch your base docker file**
* Let take a short look to the yml file below, you should find the #build command that is your way to install extension

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
            - MYSQL_ROOT_PASSWORD: '#Hitman5066789'
            ############### database for test
            # - change next 3 lines below for whatever you want and use this for test
            - MYSQL_USER: user
            - MYSQL_PASSWORD: pass
            - MYSQL_DATABASE: test_db
            volumes:    
            - ./:/var/www/html/
            networks: 
            - local-net     
    networks:
    local-net:    
        driver: bridge 
    volumes:
        - mysql:
    ```
  
* Now let change the #build command like:
    ```
    build:
        context: .
        dockerfile: Dockerfile-alternate
    ```
    * context: your file path, I use the project root path so my path is " . ", *you can change that to your related path: /[docker-addition-file-directory]/*
    *dockerfile: your docker file name
    * I use my project root path to stored my second dockerfile so I create a new dockerfile name "Dockerfile-alternate" and put some content to it
    ```
    FROM max26292/centos_php:latest
    RUN install nano
    ```
    * In this case, I use my previous built image to install nano editor 

            
 
