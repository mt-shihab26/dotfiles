use std::fmt;

struct Person {
    name: String,
    age: u32,
}

impl fmt::Display for Person {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Hello, {}! You are {}.", self.name, self.age)
    }
}

fn sum(numbers: &[i32]) -> i32 {
    numbers.iter().sum()
}

fn main() {
    let people = vec![
        Person {
            name: "world".to_string(),
            age: 30,
        },
        Person {
            name: "Neovim".to_string(),
            age: 10,
        },
    ];

    for person in &people {
        println!("{person}");
    }

    println!("sum: {}", sum(&[1, 2, 3]));
}
