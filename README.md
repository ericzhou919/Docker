# Practice Docker 

First, We have a sample golang application
```go
package main

import (
	"net/http"
	"os"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {

	e := echo.New()

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/", func(c echo.Context) error {
		return c.HTML(http.StatusOK, "Hello, Docker!")
	})

	e.GET("/ping", func(c echo.Context) error {
		return c.JSON(http.StatusOK, struct{ Status string }{Status: "OK"})
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		httpPort = "8080"
	}

	e.Logger.Fatal(e.Start(":" + httpPort))
}

```

然後 新增Dockerfile
```txt
#Define the base image file used when creating a Docker container.
FROM golang:latest

#Set the working directory to /app
WORKDIR /app

#Copy the go.mod and go.sum files into our project directory /app
COPY go.mod .
COPY go.sum .


RUN go mod download

COPY *.go ./

RUN go build -o /docker-test

EXPOSE 8080

CMD [ "/docker-test" ]
```

Build Image
```cmd
docker build --tag docker_test .
```

Check Image
```cmd
docker image ls
```
![image](img/ls.png)  

Run Image
```cmd
docker run --publish 8080:8080 docker_test  
curl http://localhost:8080/ping   
curl http://localhost:8080/
```

![image](img/docker_run.png) 

## Push to Docker Hub  
註冊一個帳號    
https://hub.docker.com  


名字前面必須加上DockerHub的帳號才能成功Push
```cmd
docker tag docker_test zhouchenyu000/docker_test
docker push zhouchenyu000/docker_test:latest
```
![image](img/hub.png) 
