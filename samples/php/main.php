<?php

declare(strict_types=1);

final class Person
{
    public function __construct(
        private readonly string $name,
        private readonly int $age,
    ) {}

    public function greet(): string
    {
        return "Hello, {$this->name}! You are {$this->age}.";
    }
}

/**
 * @param  list<int>  $numbers
 */
function total(array $numbers): int
{
    $result = 0;
    foreach ($numbers as $n) {
        $result += $n;
    }

    return $result;
}

$people = [new Person('world', 30), new Person('Neovim', 10)];

foreach ($people as $person) {
    echo $person->greet().PHP_EOL;
}

echo 'sum: '.total([1, 2, 3]).PHP_EOL;
