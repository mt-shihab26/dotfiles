// Copy from inside the tab rather than an offscreen document: on Wayland, Chrome only reaches
// the system clipboard from a focused surface, which an offscreen document never is. Clicking a
// menu item grants activeTab, so no host permissions are needed to inject into the page.
const MENU_ID = "copy-page-url";

chrome.runtime.onInstalled.addListener(() => {
    chrome.contextMenus.create({
        id: MENU_ID,
        title: "Copy page URL",
        contexts: ["page", "frame", "selection", "link", "image", "video", "audio", "editable"],
    });
});

const copy = (text) => navigator.clipboard.writeText(text);

chrome.contextMenus.onClicked.addListener(async (info, tab) => {
    if (info.menuItemId !== MENU_ID || !tab?.id) return;

    const url = info.pageUrl || tab.url;
    if (!url) return;

    await chrome.scripting.executeScript({ target: { tabId: tab.id }, func: copy, args: [url] });
});
