package main

import (
	"fmt"
	"html/template"
	"net/http"
)

func index(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("index.html"))
	t.Execute(w,"")
}

func arbol(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("arbol.html"))
	t.Execute(w,"")
}

func errores(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("error.html"))
	t.Execute(w,"")
}

func copia(w http.ResponseWriter, r *http.Request) {
	t := template.Must(template.ParseFiles("copia.html"))
	t.Execute(w,"")
}

func main() {
	http.Handle("/css/", http.StripPrefix("/css/", http.FileServer(http.Dir("css/"))))
	http.Handle("/fonts/", http.StripPrefix("/fonts/", http.FileServer(http.Dir("fonts/"))))
	http.Handle("/js/", http.StripPrefix("/js/", http.FileServer(http.Dir("js/"))))
	http.Handle("/dist/", http.StripPrefix("/dist/", http.FileServer(http.Dir("dist/"))))
	http.Handle("/codemirror/", http.StripPrefix("/codemirror/", http.FileServer(http.Dir("codemirror/"))))


	http.HandleFunc("/", index)
	http.HandleFunc("/arbol", arbol)
	http.HandleFunc("/error", errores)
	http.HandleFunc("/copia", copia)

	fmt.Printf("Servidor escuchando en: http://localhost:8000/")
	http.ListenAndServe(":8000", nil)
}