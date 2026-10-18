// YouTube seeks to 0%-90% of the video on the 0-9 keys. Swallow those keys before the player
// sees them, but leave them alone while typing (search box, comments) and when combined with a
// modifier (Ctrl+1 etc. are browser shortcuts).
const isTyping = (el) =>
    el instanceof HTMLElement &&
    (el.isContentEditable || ["INPUT", "TEXTAREA", "SELECT"].includes(el.tagName));

window.addEventListener(
    "keydown",
    (event) => {
        if (!/^[0-9]$/.test(event.key)) return;
        if (event.ctrlKey || event.altKey || event.metaKey) return;
        if (isTyping(event.composedPath()[0])) return;

        event.stopImmediatePropagation();
    },
    true,
);
