import { useState } from "react";

interface CounterProps {
    label: string;
    step?: number;
}

function Counter({ label, step = 1 }: CounterProps) {
    const [count, setCount] = useState<number>(0);

    return (
        <button
            type="button"
            onClick={() => setCount(count + step)}
        >
            {label}: {count}
        </button>
    );
}

export default function App() {
    const names: string[] = ["world", "Neovim"];

    return (
        <main>
            {names.map(name => (
                <p key={name}>Hello, {name}!</p>
            ))}
            <Counter label="Clicks" />
        </main>
    );
}
