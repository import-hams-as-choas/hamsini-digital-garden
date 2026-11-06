---
title: Note 5
description: Fifth test note
tags:
  - test
status: seed
---

# Note 5

This is the fifth test note. It connects to [[Note 3]] and [[Note 7]].

Click either link to open it in the side panel:

- [Note 3](./note3)
- [Note 7](./note7)


<style>
  #quest-sidecar {
    position: fixed; top: 0; right: 0; width: 40vw; height: 100vh;
    background: #faf8f8; border-left: 1px solid #e5e5e5;
    overflow-y: auto; z-index: 100; padding: 2rem;
    display: none; font-family: Georgia, serif;
    box-shadow: -4px 0 12px rgba(0,0,0,0.08);
  }
  #quest-sidecar.open { display: block; }
  #quest-sidecar .close-btn {
    float: right; background: none; border: none;
    font-size: 1.5rem; cursor: pointer; color: #888;
  }
  #quest-sidecar iframe {
    width: 100%; height: 70vh; border: none; border-radius: 8px;
  }
</style>

<div id="quest-sidecar">
  <button class="close-btn" onclick="closeSidecar()">×</button>
  <h2 style="margin-top:0">Side Note</h2>
  <div id="sidecar-content">
    <p style="color:#888">Click a link to open a note beside this one.</p>
  </div>
</div>

<script>
  function openSidecar(url) {
    const panel = document.getElementById('quest-sidecar');
    const content = document.getElementById('sidecar-content');
    panel.classList.add('open');
    content.innerHTML = '<iframe src="' + url + '" loading="lazy"></iframe>';
  }
  function closeSidecar() {
    document.getElementById('quest-sidecar').classList.remove('open');
  }
  document.querySelectorAll('a.internal-link, a[href^="./"]').forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      let href = link.getAttribute('href');
      // Quartz renders wikilinks as ./note-2 (slug); strip the hyphen so the iframe resolves to note2.html.
      href = href.replace(/-/g, '');
      if (!href.endsWith('.html')) href += '.html';
      openSidecar(href);
    });
  });
</script>
