interface Person {
    name: string;
    age: number;
}

type Greeter = (person: Person) => string;

const greet: Greeter = person => `Hello, ${person.name}! You are ${person.age}.`;

function sum(numbers: readonly number[]): number {
    return numbers.reduce((total, n) => total + n, 0);
}

enum Level {
    Low = "low",
    High = "high",
}

const people: Person[] = [
    { name: "world", age: 30 },
    { name: "Neovim", age: 10 },
];

for (const person of people) {
    console.log(greet(person));
}

console.log(`sum: ${sum([1, 2, 3])}`, Level.High);

export { greet, sum, Level };
