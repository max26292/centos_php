# How to use this images
## First of all
* You have these config file: 
    * config_mysql.sh for root password
    * php.ini for php configuration
    * httpd.conf for setup apache config
> You must change the value in these files before build your own image.
* Now, go to the docker file
    * Our image bases from the Centos os so use *yum* to install packages.
    * In this file, you should not change anything before the extention line because that may make your build process fail.
    * If you need to install some extension, do it below the <br> ############# line and before the ENTRYPOINT
        * For example
         ```shell script
            ######### 
            ## add your code here
            RUN yum install -y git 
            ENTRYPOINT ["/bin/bash","start.sh"]
        ```
        * You should use && \ if have many commands because using many RUN command makes docker create more layer to build your image so that is cause of large size image
* Well done, now you can build your own container with command **docker build -t [your image tag] .**
* *Take a cup of coffe while waiting this process complete.*
         
 
