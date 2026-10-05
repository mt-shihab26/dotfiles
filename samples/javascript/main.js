class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }

    greet() {
        return `Hello, ${this.name}! You are ${this.age}.`;
    }
}

/**
 * add up a list of numbers
 * @param {number[]} numbers
 * @returns {number}
 */
function sum(numbers) {
    return numbers.reduce((total, n) => total + n, 0);
}

const people = [new Person("world", 30), new Person("Neovim", 10)];

for (const person of people) {
    console.log(person.greet());
}

console.log(`sum: ${sum([1, 2, 3])}`);
