# Builder

We want to create a volume so that when gradle downloads dependencies it doesn't need to do it again if the source folder gets updated.
   ```
   docker volume create gradle-dependencies
   ```

Create a volume that will hold the all the source and build artifcats in a volume
  ```
  docker volume create build-$USER
  ```

Full paths are required for docker. You'll need to adjust this path based on your environment.
  ```
  export PROJECT_DIR="/home/${USER}/workspace/docker-builder-pattern-example/"
  ```

## Build the builder
This assembles the builder image
  ```
  docker build --tag builder builder
  ```

## Test the builder
The preflight.sh will check to make sure the environment is correct and print a lot of settings.
```bash
docker run -ti \
  --mount type=volume,source=build-${USER},target=/build \
  builder /preflight.sh
```

## Build the server with the Builder
Mount in the build.sh to execute the build and the source and gradle-dependencies.
```bash
docker run -ti \
  --mount type=bind,source="${PROJECT_DIR}/",target=/source \
  --mount type=volume,source=gradle-dependencies,target=/gradle-dependencies \
  --mount type=volume,source=build-${USER},target=/build \
  builder /build.sh server
```

# Results
This ends up building the binary '/build/server/build/libs/server-0.0.1-SNAPSHOT.jar' which then need to be extracted. Subsequent builds will be faster as you don't have to download the dependencies for gradle again. The issue is now you have to exact the binary from the volume or mount the volume in another container to run it.


Execute the binary from the volume inside of a small alpine image.
  ```bash
  docker run --rm \
    -p 8080:8080 \
    --mount type=volume,source=build-${USER},target=/build \
    openjdk:14-alpine java -jar /build/server/build/libs/server-0.0.1-SNAPSHOT.jar
  ```

Access the server
```bash
curl -i -w '\n' http://localhost:8080/server/v1/acknowledge
```

# Clean up
We left some volumes hanging out
```bash
docker volume rm --force build-${USER}
docker volume rm --force gradle-dependencies
docker image rmi --force server:latest
docker image rmi --force builder:latest
```

