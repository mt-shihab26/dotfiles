import { useState } from "react";

function Counter({ label, step = 1 }) {
    const [count, setCount] = useState(0);

    return (
        <button type="button" onClick={() => setCount(count + step)}>
            {label}: {count}
        </button>
    );
}

export default function App() {
    const names = ["world", "Neovim"];

    return (
        <main>
            {names.map(name => (
                <p key={name}>Hello, {name}!</p>
            ))}
            <Counter label="Clicks" />
        </main>
    );
}
