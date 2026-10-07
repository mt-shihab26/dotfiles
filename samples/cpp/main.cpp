#include <iostream>
#include <numeric>
#include <string>
#include <vector>

class Person {
  public:
    Person(std::string name, int age) : name_(std::move(name)), age_(age) {}

    void
    greet() const {
        std::cout << "Hello, " << name_ << "! You are " << age_ << ".\n";
    }

  private:
    std::string name_;
    int age_;
};

template <typename T>
T sum(const std::vector<T> &numbers) {
    return std::accumulate(numbers.begin(), numbers.end(), T{});
}

int main() {
    const std::vector<Person> people = {{"world", 30}, {"Neovim", 10}};

    for (const auto &person : people) {
        person.greet();
    }

    std::cout << "sum: " << sum<int>({1, 2, 3}) << "\n";
    return 0;
}
