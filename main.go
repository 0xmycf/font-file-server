package main

import (
	"log"
	"fmt"
	"net/http"
)

var (
	version string
)

const DATA_PATH = "./data/"

func main() {
	fmt.Println("Hello, World!")
	fmt.Println("Running on bleeding-edge version:", version)
	http.Handle("/data/", http.StripPrefix("/data/", http.FileServer(http.Dir(DATA_PATH))))

	err := http.ListenAndServe(":3333", nil)
	if err != nil {
		log.Fatal(err)
	}
}

