package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
	"os"
	"strconv"
)

func lookupOrDefaultTo(envvar string, defaultValue string) string {
	value, present := os.LookupEnv(envvar)
	if present {
		return value
	}
	fmt.Printf("%s not set. Using default value: %s\n", envvar, defaultValue)
	return defaultValue
}

func main() {
	fmt.Println("Starting server...")

	httpPortStr := lookupOrDefaultTo("HTTP_PORT", "8000")
	httpPort, err := strconv.Atoi(httpPortStr)
	if err != nil {
		log.Fatal(err)
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		endpoint := html.EscapeString(r.URL.Path)
		fmt.Fprintf(w, "Hello, %q", endpoint)
	})
	http.HandleFunc("/hi", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hi")
	})
	http.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		pong := "I'm healthy!"
		fmt.Println(pong)
		fmt.Fprintf(w, pong)
	})
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", httpPort), nil))
}
