// Mantém o app abrindo rápido e funcionando mesmo com internet fraca.
// Sempre tenta buscar a versão mais nova primeiro; usa a cópia salva só se estiver sem internet.
const CACHE = 'rei-do-tambor-v1';
const BASE = ['./', 'index.html', 'config.js', 'manifest.webmanifest', 'icon-192.png', 'icon-512.png'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(BASE)).then(() => self.skipWaiting()));
});
self.addEventListener('activate', e => {
  e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== CACHE).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});
self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  const proprio = url.origin === self.location.origin;
  const biblioteca = /cdn\.jsdelivr\.net|fonts\.(googleapis|gstatic)\.com/.test(url.host);
  if (!proprio && !biblioteca) return; // dados do Supabase nunca ficam em cache
  e.respondWith(
    fetch(req).then(res => {
      if (res.ok || res.type === 'opaque') { const copia = res.clone(); caches.open(CACHE).then(c => c.put(req, copia)); }
      return res;
    }).catch(() => caches.match(req).then(r => r || caches.match('index.html')))
  );
});
