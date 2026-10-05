import java.util.List;

public class Main {
    record Person(String name, int age) {
        String greet() {
            return "Hello, " + name + "! You are " + age + ".";
        }
    }

    static int sum(List<Integer> numbers) {
        int total = 0;
        for (int n : numbers) {
            total += n;
        }
        return total;
    }

    public static void main(String[] args) {
        List<Person> people = List.of(new Person("world", 30), new Person("Neovim", 10));

        for (Person person : people) {
            System.out.println(person.greet());
        }

        System.out.println("sum: " + sum(List.of(1, 2, 3)));
    }
}
