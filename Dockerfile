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
