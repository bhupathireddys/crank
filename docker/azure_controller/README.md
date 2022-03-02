# Docker component for crank controller

This folder contains files to build and run a docker container for crank controller. Please read the [crank-agent page](https://github.com/weilinwa/crank/blob/perf/dtr/docker/azure_agent/README.md) and execute steps to deploy it before run the 
controller docker container. 

## Crank + ASP.NET benchmarks + Docker container

To run ASP.NET benchmarks using crank, depending on the test scenario, there need to be at least two or three machines, the load generator, the application server 
(machine under test) and the database server. During the test, we need launch crank-agent on each one of these machines. Crank controller should be located together with test 
config files. The final test results are also stored in controller side.

- The crank controller could be deployed seperately on a different machine. 

  ![image](https://user-images.githubusercontent.com/48932302/154745176-c2aa4fcb-2ee6-43e6-bb20-eb37aafe1926.png) 
  

- Or, deploy controller on the load generator machine if this machine is powerful enough. 

  ![image](https://user-images.githubusercontent.com/48932302/154744803-a569babd-5085-460e-87d8-0524018e069c.png)
  

## Test scenarios

There are two files `run_crank.sh` and `azure.profiles.yml` in `crank/docker/azure_controller/` that contains seven test scenarios from [ASP.NET benchmark](https://github.com/aspnet/Benchmarks/tree/main/scenarios) and test machine information. At the execution time of the crank-controller docker container, the crank-agents will download required test benchmarks, build, and run the required tests.

| Benchmarks| Scenarios | Note|
|-----------|-----------|---|
|Platform | json | |
|Json| json||
|Json| https||
|Platform | plaintext |Require powerful loadgen|
|Plaintext | plaintext |Require powerful loadgen|
|Platform | fortunes |Require database server|
|Database | fortunes |Require database server|


## Notes for machines to use

In scenarios for plaintext testing, a powerful load generator is necessary to avoid it becoming the bottleneck of the test. Similarly, in scenarios using database, 
the database server also needs to be a powerful machine. 


## Get started

Git clone this repository and follow the steps and commands below:
 
1. Switch to the perf/dtr branch

    ``` 
    git checkout perf/dtr  
    ```
2. Fill in ip addresses of all the test machines in `crank/docker/azure_controller/azure.profiles.yml` file.

   Replace the `appServerIP`, `databaseServerIP`, `loadGenIP` with the ip address of the machines used in the test.
   The following configurations also require **inbound TCP port 5000 and 5010** been open for the test machines. 
   
   ```
   dv2:
    variables:
      serverPort: 5000
      serverAddress: appServerIP
      cores: 8
    jobs:
      db:
        endpoints:
          - http://databaseServerIP:5010
      application:
        endpoints:
          - http://appServerIP:5010
        variables:
          databaseServer: databaseServerIP
      load:
        endpoints:
          - http://loadGenIP:5010
   
   ```

3. Install docker and do docker build using the script 

    ```
    bash azure_test_setup_controller.sh
    ```
    Inside folder `crank/docker/azure_controller/`, there are two files `run_crank.sh` and `azure.profiles.yml`. These two files will be added into the container and used when 
    we run the container. We need to update these two files according to our machine setup and test requiement. 
    
    Run `bash build.sh` whenever we update any one of the two file before run the container again.
 
4. Go to the `crank/docker/azure_controller/` directory and run the container

   Note: Please launch crank-agent on all the machines before execute the controller container.
   
    ``` 
    bash run.sh 
    ```
5. Check docker container execution through logs or attach to it

    ```
    docker container attach crank-controller
    
    docker container logs crank-controller 
    ```


## Get results

If the crank-controller container is launched using the `crank/docker/azure_controller/run.sh` script, the final results will be stored in folder `~/docker.controller/` of 
the host machine.  
On a system with `crank`, use command `crank compare` could show a comparison result of two or more files.
