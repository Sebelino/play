package main

import (
	"fmt"
	"html"
	"log"
	"net/http"
)

func main() {
	fmt.Println("Starting server...")
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
	log.Fatal(http.ListenAndServe(":8080", nil))
}
