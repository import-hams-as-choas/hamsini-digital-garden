---
title: Note 7
description: Seventh test note
tags:
  - test
status: seed
---

# Note 7

This is the seventh test note. It connects to [[Note 5]] and [[Note 9]].

Click either link to open it in the side panel:

- [Note 5](./note5)
- [Note 9](./note9)


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
  // Note stacking support: clicking any link stacks the note in the sidecar
  // URL: ?stackedNotes=bm90ZTE=&stackedNotes=bm90ZTI= (base64-encoded slugs)
  function noteToBase64(slug) { return btoa(slug); }
  function base64ToNote(b64) { try { return atob(b64); } catch(e) { return null; } }

  function getStackedNotes() {
    const params = new URLSearchParams(window.location.search);
    return params.getAll('stackedNotes');
  }

  function addToStack(slug) {
    const params = new URLSearchParams(window.location.search);
    const existing = params.getAll('stackedNotes');
    const b64 = noteToBase64(slug);
    if (!existing.includes(b64)) {
      params.append('stackedNotes', b64);
      const newUrl = window.location.pathname + '?' + params.toString();
      window.history.pushState({}, '', newUrl);
    }
    renderStack();
  }

  function clearStack() {
    const params = new URLSearchParams(window.location.search);
    params.delete('stackedNotes');
    const newUrl = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
    window.history.pushState({}, '', newUrl);
    renderStack();
  }

  function renderStack() {
    const sidecar = document.getElementById('quest-sidecar');
    const content = document.getElementById('sidecar-content');
    const stackedNotes = getStackedNotes();
    if (stackedNotes.length === 0) {
      sidecar.classList.remove('open');
      content.innerHTML = '<p style="color:#888">Click a link to open a note beside this one.</p>';
      return;
    }
    content.innerHTML = '';
    stackedNotes.forEach((slugB64, i) => {
      const slug = base64ToNote(slugB64);
      if (!slug) return;
      const iframe = document.createElement('iframe');
      iframe.src = './' + slug + '.html';
      iframe.loading = 'lazy';
      iframe.style.width = '100%';
      iframe.style.height = i === 0 ? '300px' : '200px';
      iframe.style.border = 'none';
      iframe.style.marginBottom = '1rem';
      iframe.className = 'stacked-note-iframe';
      content.appendChild(iframe);
    });
    sidecar.classList.add('open');
  }

  // Initialize stack on page load (from URL params)
  renderStack();
  document.querySelectorAll('a.internal-link, a[href^="./"]').forEach(link => {
    link.addEventListener('click', (e) => {
      e.preventDefault();
      let href = link.getAttribute('href');
      // Quartz renders wikilinks as ./note-2 (slug); strip the hyphen so the iframe resolves to note2.html.
      href = href.replace(/-/g, '');
      if (!href.endsWith('.html')) href += '.html';
      // Extract the note slug from the href (remove ./ and .html)
      const slug = href.replace(/^\.\/+/, '').replace(/\.html$/, '');
      if (slug) {
        addToStack(slug);
      }
    });
  });
</script>
