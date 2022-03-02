# Docker component for crank agent

This folder contains files to build and run a docker container for crank agent. This is designed to be used together with the crank controller docker component to finish 
specific scenarios.

## Crank + ASP.NET benchmarks + Docker container

To run ASP.NET benchmarks using crank, depending on the test scenario, there need to be at least two or three machines, the load generator, the application server 
(machine under test) and the database server. During the test, **launch crank-agent on each one of these machines**. 
Please read [crank controller page](https://github.com/weilinwa/crank/blob/perf/dtr/docker/azure_controller/README.md) for controller deployment.

- Test machines 

  ![image](https://user-images.githubusercontent.com/48932302/154745176-c2aa4fcb-2ee6-43e6-bb20-eb37aafe1926.png) 
  


## Notes for machines to use

In scenarios for plaintext testing, a powerful load generator is necessary to avoid it becoming the bottleneck of the test. Similarly, in scenarios using database, 
the database server also needs to be a powerful machine. 

## Get started

Git clone this repository and follow the steps and commands below:
 
1. Switch to the perf/dtr branch

    ``` 
    git checkout perf/dtr  
    ```
2. Install docker and do docker build using the script 

    ```
    bash azure_test_setup_agent.sh
    ```
         
3. Go to the `crank/docker/azure_agent/` directory and run the container

   Note: Please launch crank-agent on all the machines before execute the controller container.
   
    ``` 
    bash run.sh 
    ```
   
4. Stop the docker container

   ```
   bash stop.sh
   ```
5. Check docker container execution through logs or attach to it

    ```
    docker container attach crank-agent
    
    docker container logs crank-agent 
    ```

Please read [crank controller page](https://github.com/weilinwa/crank/blob/perf/dtr/docker/azure_controller/README.md) for controller deployment and get test results.
