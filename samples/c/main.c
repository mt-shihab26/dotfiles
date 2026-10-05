#include <stdio.h>

typedef struct {
    const char *name;
    int age;
} Person;

static int sum(const int *numbers, int count) {
    int total = 0;
    for (int i = 0; i < count; i++) {
        total += numbers[i];
    }
    return total;
}

static void greet(const Person *person) {
    printf("Hello, %s! You are %d.\n", person->name, person->age);
}

int main(void) {
    Person person = {"world", 30};
    int numbers[] = {1, 2, 3};

    greet(&person);
    printf("sum: %d\n", sum(numbers, 3));
    return 0;
}
