from dataclasses import dataclass


@dataclass
class Person:
    name: str
    age: int

    def greet(self) -> str:
        return f"Hello, {self.name}! You are {self.age}."


def total(numbers: list[int]) -> int:
    result = 0
    for n in numbers:
        result += n
    return result


def main() -> None:
    people = [Person("world", 30), Person("Neovim", 10)]

    for person in people:
        print(person.greet())

    print(f"sum: {total([1, 2, 3])}")


if __name__ == "__main__":
    main()
