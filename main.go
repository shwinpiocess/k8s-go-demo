package main

import (
	"log"
	"net/http"
	"os"

	"github.com/shwinpiocess/k8s-go-demo/handlers"
	"github.com/shwinpiocess/k8s-go-demo/version"
)

func main() {
	log.Printf("Starting the service...\ncommit:%s, build time: %s, release: %s", version.Commit, version.BuildTime, version.Release)

	port := os.Getenv("PORT")
	if port == "" {
		log.Fatal("Port is not set.")
	}

	router := handlers.Router()

	log.Print("The service is ready to listen and serve.")
	log.Fatal(http.ListenAndServe(":"+port, router))
}
