#!/bin/bash

# Define a function
greet() {
    echo "Hello, $1!"
}

# Call the function with an argument
greet "Alice"

# Define a function with multiple parameters
add() {
    sum=$(( $1 + $2 ))
    echo "The sum of $1 and $2 is: $sum"
}

# Call the function with two arguments
add 5 10