package main

import (
    "strconv"
    "fmt"
)

func main() {
    possible := 0

main:
for i:=156218; i < 652527; i++ {
        str := strconv.Itoa(i)

        for i := range str {
            if i == 0 {
                continue
            }

            if str[i-1] > str[i] {
                continue main
            }
        }

        if amountrepeatedtwos(str) == 0 {
            continue
        }

        println(str)
        possible++
    }

    fmt.Println(possible)
}


func amountrepeatedtwos(str string) int {
    amount := 0
    for i := range str {
        if i == 0 {
            continue
        }
        if i == 1 && str[0] == str[1] && str[2] != str[1] {
            amount++
            continue
        }
        if i == 1 {
            continue
        }
        if i == len(str)-1 && str[i-1] == str[i] && str[i-2] != str[i] {
            amount++
            continue
        }
        if i == len(str)-1 {
            continue
        }
        if str[i-1] == str[i] && str[i-2] != str[i] && str[i+1] != str[i] {
            amount++
            continue
        }
    }

    return amount
}
