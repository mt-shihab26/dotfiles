// A service worker has no DOM, so it can't touch the clipboard. Hand the URL to an offscreen
// document instead, which works on every page (unlike injecting a script into the tab, which
// Chrome blocks on chrome:// pages and the Web Store).
const MENU_ID = "copy-page-url";

chrome.runtime.onInstalled.addListener(() => {
    chrome.contextMenus.create({
        id: MENU_ID,
        title: "Copy page URL",
        contexts: ["page", "frame", "selection", "link", "image", "video", "audio", "editable"],
    });
});

const ensureOffscreen = async () => {
    if (await chrome.offscreen.hasDocument()) return;
    await chrome.offscreen.createDocument({
        url: "offscreen.html",
        reasons: ["CLIPBOARD"],
        justification: "Write the page URL to the clipboard",
    });
};

chrome.contextMenus.onClicked.addListener(async (info, tab) => {
    if (info.menuItemId !== MENU_ID) return;

    const url = info.pageUrl || tab?.url;
    if (!url) return;

    await ensureOffscreen();
    await chrome.runtime.sendMessage({ type: "copy", text: url });
});
