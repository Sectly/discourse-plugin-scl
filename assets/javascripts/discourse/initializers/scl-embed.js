import { later } from "@ember/runloop";

export default {
    name: "scl-embed",
    initialize() {
        const debugMode = false;

        if (debugMode) console.log("SCL Embed Initializer Loading...");

        function sclEmbed() {
            if (debugMode) console.log("SCL Embed Processing...");

            const oneboxes = document.querySelectorAll(".cooked .onebox.allowlistedgeneric");

            if (!oneboxes || oneboxes.length === 0) {
                if (debugMode) console.log("No oneboxes found for SCL Embed, Stopped processing!");

                return;
            }

            oneboxes.forEach(onebox => {
                // Skip if already processed
                if (onebox.dataset.processed === "true") {
                    return;
                }

                const src = onebox.getAttribute("data-onebox-src");

                // Check if it's a strakscargo.ltd onebox
                if (src && src.includes("strakscargo.ltd")) {
                    const headerLink = onebox.querySelector("header.source a");

                    // Fetch the target page to get its title
                    fetch(url)
                        .then(response => response.text())
                        .then(html => {
                            const parser = new DOMParser();
                            const doc = parser.parseFromString(html, "text/html");

                            // Try meta[name=title], then <title>
                            let pageTitle =
                                doc.querySelector('meta[name="title"]')?.getAttribute("content") ||
                                doc.querySelector("title")?.innerText ||
                                headerLink.textContent;

                            headerLink.textContent = pageTitle;
                        })
                        .catch(err => {
                            if (debugMode) console.error("Error fetching title:", err);
                        });

                    if (headerLink) {
                        const url = headerLink.href;

                        // Generate the iframe HTML with the given URL
                        const iframeHTML = `
          <iframe name='embed_readwrite' src='${url}?discourse=true&embed=true' style='border-width:0' frameborder='0' scrolling='no' width='100%' height='600'></iframe>
          <br>
          <a href='${url}?discourse=true' target='_blank'>Open in a new tab</a>
        `;

                        // Find and replace the onebox-body content
                        const body = onebox.querySelector(".onebox-body");
                        if (body) {
                            body.innerHTML = iframeHTML;

                            // Mark as processed
                            onebox.dataset.processed = "true";
                        }
                    }
                }
            });

            if (debugMode) console.log("SCL Embed Processing Completed!");
        }

        function loop() {
            sclEmbed();

            // Repeat every 1.5 seconds
            setTimeout(loop, 1500);
        }

        window.addEventListener("onebox:loaded", () => {
            sclEmbed();
        });

        window.addEventListener("DOMContentLoaded", () => {
            sclEmbed();
        });

        later(() => {
            sclEmbed();
        }, 3000);

        sclEmbed();

        loop();

        if (debugMode) console.log("SCL Embed Initializer Loaded!");
    },
};