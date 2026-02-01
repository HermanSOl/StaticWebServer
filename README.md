This is a simple web server that creates a socket, binds it, listens on it and responds with 
"HTTP/1.0 200 OK\r\n\r\n" no matter what the user request is.

In the future I could make the server dynamic by implementing the read command and based on the input give
different responses. After that I could also make the server support multiple users at once through forking.
