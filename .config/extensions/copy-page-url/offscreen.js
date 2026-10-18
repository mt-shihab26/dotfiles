// navigator.clipboard needs a focused document, which an offscreen one never is, so fall back
// to the old select + execCommand("copy") trick.
chrome.runtime.onMessage.addListener((message) => {
    if (message.type !== "copy") return;

    const textarea = document.getElementById("text");
    textarea.value = message.text;
    textarea.select();
    document.execCommand("copy");
});
