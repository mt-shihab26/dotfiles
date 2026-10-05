package main

import "fmt"

type Person struct {
	Name string
	Age  int
}

func (p Person) Greet() string {
	return fmt.Sprintf("Hello, %s! You are %d.", p.Name, p.Age)
}

func sum(numbers []int) int {
	total := 0
	for _, n := range numbers {
		total += n
	}
	return total
}

func main() {
	people := []Person{{"world", 30}, {"Neovim", 10}}

	for _, person := range people {
		fmt.Println(person.Greet())
	}

	fmt.Println("sum:", sum([]int{1, 2, 3}))
}
