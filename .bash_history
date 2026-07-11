  header h1 { font-size:1.5rem; color:#fff; }
  .dot { width:10px; height:10px; border-radius:50%; background:var(--red); }
  .dot.live { background:var(--green); animation:pulse 1.5s infinite; }
  @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:.4} }
  .status-text { font-size:.8rem; color:var(--muted); }
  .sub { font-size:.75rem; color:var(--muted); margin-left:auto; }
  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(260px,1fr)); gap:16px; margin-bottom:20px; }
  .card { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; }
  .card-title { font-size:.75rem; text-transform:uppercase; letter-spacing:.08em; color:var(--muted); margin-bottom:12px; }
  .big-number { font-size:2.6rem; font-weight:700; color:#fff; line-height:1; }
  .sub-label { font-size:.8rem; color:var(--muted); margin-top:4px; }
  .bw-row { display:flex; justify-content:space-between; margin-top:10px; gap:8px; }
  .bw-box { flex:1; background:var(--bg); border:1px solid var(--border); border-radius:6px; padding:10px 12px; }
  .bw-label { font-size:.7rem; color:var(--muted); }
  .bw-val { font-size:1.3rem; font-weight:700; margin-top:2px; }
  .bw-total { font-size:.72rem; color:var(--muted); margin-top:2px; }
  .up { color:var(--orange); } .down { color:var(--blue); }
  .sys-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:12px; margin-top:4px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.5rem; font-weight:700; color:#fff; }
  .sys-lbl { font-size:.72rem; color:var(--muted); margin-top:2px; }
  .bar-wrap { background:var(--bg); border-radius:4px; height:6px; margin-top:6px; overflow:hidden; }
  .bar-fill { height:100%; border-radius:4px; transition:width .4s; }
  .bar-cpu { background:var(--blue); } .bar-ram { background:var(--orange); }
  .section { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; margin-bottom:20px; }
  .addrow { display:flex; gap:8px; margin-bottom:14px; flex-wrap:wrap; }
  input[type=text] { background:var(--bg); border:1px solid var(--border); color:var(--text); padding:9px 12px; border-radius:6px; flex:1; min-width:180px; font-size:.85rem; }
  button { background:var(--blue); color:#000; border:none; padding:9px 16px; border-radius:6px; cursor:pointer; font-size:.8rem; font-weight:600; }
  button.danger { background:var(--red); color:#fff; }
  button.secondary { background:#21262d; color:var(--text); border:1px solid var(--border); }
  button:hover { opacity:.85; }
  .msg { font-size:.78rem; margin-bottom:10px; min-height:16px; }
  .msg.err { color:var(--red); } .msg.ok { color:var(--green); }
  table { width:100%; border-collapse:collapse; font-size:.85rem; }
  th { text-align:left; padding:8px 10px; color:var(--muted); border-bottom:1px solid var(--border); font-weight:500; font-size:.72rem; text-transform:uppercase; }
  td { padding:10px; border-bottom:1px solid var(--border); }
  tr:last-child td { border-bottom:none; }
  .badge { display:inline-block; padding:2px 8px; border-radius:4px; font-size:.72rem; font-weight:600; }
  .badge.online, .badge.valid { background:rgba(63,185,80,.15); color:var(--green); border:1px solid rgba(63,185,80,.3); }
  .badge.offline { background:rgba(139,148,158,.15); color:var(--muted); border:1px solid var(--border); }
  .badge.revoked { background:rgba(248,81,73,.15); color:var(--red); border:1px solid rgba(248,81,73,.3); }
  .empty { color:var(--muted); font-size:.85rem; padding:16px 0; text-align:center; }
  #log { background:#000; border-radius:6px; padding:12px; height:280px; overflow-y:auto; font-size:.75rem; line-height:1.6; font-family:Consolas,monospace; }
  .logline { color:var(--muted); }
  .logline.evt { color:var(--green); }
  .two-col { display:grid; grid-template-columns:1.3fr 1fr; gap:16px; }
  @media (max-width:900px){ .two-col{ grid-template-columns:1fr; } }
  .ts { font-size:.72rem; color:var(--muted); margin-top:10px; text-align:right; }
</style>
</head>
<body>
<header>
  <div class="dot" id="dot"></div>
  <h1>🔒 OpenVPN Control Center</h1>
  <span class="status-text" id="conn-status">Connecting...</span>
  <span class="sub">152.42.241.74 · tun0 / eth0 live</span>
</header>

<div class="grid">
  <div class="card">
    <div class="card-title">Connected Clients</div>
    <div class="big-number" id="total-clients">—</div>
    <div class="sub-label">Active VPN connections</div>
  </div>
  <div class="card">
    <div class="card-title">🔵 tun0 — VPN Tunnel</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="tun-up">—</div><div class="bw-total" id="tun-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="tun-down">—</div><div class="bw-total" id="tun-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">🟠 Ethernet</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="eth-up">—</div><div class="bw-total" id="eth-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="eth-down">—</div><div class="bw-total" id="eth-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">System Health</div>
    <div class="sys-grid">
      <div class="sys-item"><div class="sys-val" id="cpu">—</div><div class="bar-wrap"><div class="bar-fill bar-cpu" id="cpu-bar" style="width:0%"></div></div><div class="sys-lbl">CPU</div></div>
      <div class="sys-item"><div class="sys-val" id="ram">—</div><div class="bar-wrap"><div class="bar-fill bar-ram" id="ram-bar" style="width:0%"></div></div><div class="sys-lbl">RAM</div></div>
      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>
    </div>
  </div>
</div>

<div class="two-col">
  <div>
    <div class="section">
      <div class="card-title">Client Management</div>
      <div class="addrow">
        <input type="text" id="newClientName" placeholder="naya client naam (e.g. laptop2)">
        <button onclick="addClient()">+ Add Client</button>
      </div>
      <div id="addMsg" class="msg"></div>
      <table>
        <thead><tr><th>Name</th><th>Status</th><th>Expiry</th><th>Online</th><th>Actions</th></tr></thead>
        <tbody id="clientsBody"><tr><td colspan="5" class="empty">Loading...</td></tr></tbody>
      </table>
    </div>

    <div class="section">
      <div class="card-title">Client Details (Live Usage)</div>
      <div id="clients-container"><div class="empty">Koi client connected nahi hai</div></div>
    </div>
  </div>

  <div class="section">
    <div class="card-title">Live Log Stream</div>
    <div id="log"></div>
  </div>
</div>

<div class="ts" id="ts">Last update: —</div>

<script>
const logEl = document.getElementById('log');
function addLog(text, cls){
  const d = document.createElement('div');
  d.className = 'logline' + (cls ? ' '+cls : '');
  d.textContent = text;
  logEl.appendChild(d);
  logEl.scrollTop = logEl.scrollHeight;
  while(logEl.children.length > 300) logEl.removeChild(logEl.firstChild);
}

function kbps(v){ if(v >= 1024) return (v/1024).toFixed(1)+' MB/s'; return (v||0).toFixed(1)+' KB/s'; }
function mbFmt(b){ b = parseInt(b||0); if(b >= 1048576) return (b/1048576).toFixed(1)+' MB'; return (b/1024).toFixed(1)+' KB'; }
function formatUptime(s){ const h=Math.floor(s/3600), m=Math.floor((s%3600)/60); return `${h}h ${m}m`; }
function esc(s){ return String(s).replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

async function loadClients(){
  const res = await fetch('/api/clients');
  const data = await res.json();
  const body = document.getElementById('clientsBody');
  body.innerHTML = '';
  if(!data.clients.length){ body.innerHTML = '<tr><td colspan="5" class="empty">Koi client nahi hai. Upar se add karain.</td></tr>'; return; }
  data.clients.forEach(c => {
    const statusBadge = c.status === 'valid' ? 'valid' : 'revoked';
    const onlineBadge = c.online ? 'online' : 'offline';
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td>${esc(c.name)}</td>
      <td><span class="badge ${statusBadge}">${c.status}</span></td>
      <td>${c.expiry || '-'}</td>
      <td><span class="badge ${onlineBadge}">${c.online ? 'ONLINE' : 'offline'}</span></td>
      <td>
        <button class="secondary" onclick="downloadClient('${c.name}')">⬇ .ovpn</button>
        <button class="danger" onclick="revokeClient('${c.name}')">Revoke</button>
      </td>`;
    body.appendChild(tr);
  });
}

function downloadClient(name){ window.open('/api/clients/' + encodeURIComponent(name) + '/download', '_blank'); }

async function addClient(){
  const nameInput = document.getElementById('newClientName');
  const name = nameInput.value.trim();
  const msg = document.getElementById('addMsg');
  if(!name){ msg.textContent = 'Pehle naam likhain.'; msg.className='msg err'; return; }
  msg.textContent = 'Client bana rahay hain...'; msg.className = 'msg';
  const res = await fetch('/api/clients/add', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({name}) });
  const data = await res.json();
  if(data.success){
    msg.textContent = 'Client "' + name + '" ban gaya ✔ — download ho raha hai...';
    msg.className = 'msg ok';
    nameInput.value = '';
    downloadClient(name);
    loadClients();
  } else {
    msg.textContent = 'Error: ' + data.error;
    msg.className = 'msg err';
  }
}

async function revokeClient(name){
  if(!confirm('Client "' + name + '" ko revoke karna hai? Ye wapis nahi ho sakta.')) return;
  const res = await fetch('/api/clients/revoke', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({name}) });
  const data = await res.json();
  if(data.success){ addLog('Client revoked: ' + name, 'evt'); loadClients(); }
  else { alert('Error: ' + data.error); }
}

function renderClients(clients){
  const el = document.getElementById('clients-container');
  if(!clients.length){ el.innerHTML = '<div class="empty">Koi client connected nahi hai</div>'; return; }
  let html = '<table><thead><tr><th>Name</th><th>Real IP</th><th>VPN IP</th><th>Data In</th><th>Data Out</th><th>Since</th></tr></thead><tbody>';
  clients.forEach(c => {
    html += `<tr><td>${esc(c.common_name)}</td><td>${esc(c.real_address)}</td><td>${esc(c.vpn_ip)}</td><td class="down">${mbFmt(c.bytes_received)}</td><td class="up">${mbFmt(c.bytes_sent)}</td><td>${esc(c.connected_since)}</td></tr>`;
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

function connect(){
  const es = new EventSource('/api/stream');
  es.onopen = () => { document.getElementById('dot').classList.add('live'); document.getElementById('conn-status').textContent = 'Live'; };
  es.onerror = () => { document.getElementById('dot').classList.remove('live'); document.getElementById('conn-status').textContent = 'Reconnecting...'; es.close(); setTimeout(connect, 3000); };
  es.onmessage = (e) => {
    let d;
    try { d = JSON.parse(e.data); } catch(err){ return; }

    if(d.type === 'metrics'){
      document.getElementById('total-clients').textContent = d.total_clients ?? '0';
      const t = d.tun0 || {};
      document.getElementById('tun-up').textContent = t.available ? kbps(t.upload_kbps) : 'N/A';
      document.getElementById('tun-down').textContent = t.available ? kbps(t.download_kbps) : 'N/A';
      document.getElementById('tun-up-total').textContent = t.available ? `Total: ${t.total_sent_mb} MB` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${t.total_recv_mb} MB` : '';
      const eth = d.ethernet || {};
      document.getElementById('eth-up').textContent = eth.available ? kbps(eth.upload_kbps) : 'N/A';
      document.getElementById('eth-down').textContent = eth.available ? kbps(eth.download_kbps) : 'N/A';
      document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${eth.total_sent_mb} MB` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${eth.total_recv_mb} MB` : '';
      const sys = d.system || {};
      const cpu = sys.cpu_percent ?? 0, ram = sys.ram_percent ?? 0;
      document.getElementById('cpu').textContent = cpu + '%';
      document.getElementById('ram').textContent = ram + '%';
      document.getElementById('cpu-bar').style.width = cpu + '%';
      document.getElementById('ram-bar').style.width = ram + '%';
      document.getElementById('uptime').textContent = formatUptime(sys.uptime_secs ?? 0);
      renderClients(d.clients || []);
      document.getElementById('ts').textContent = 'Last update: ' + new Date(d.timestamp).toLocaleTimeString();
    } else if(d.type === 'connect'){
      addLog(`[CONNECT] ${d.common_name} from ${d.real_address}`, 'evt');
      loadClients();
    } else if(d.type === 'disconnect'){
      addLog(`[DISCONNECT] ${d.common_name}`, 'evt');
      loadClients();
    } else if(d.type === 'client_added'){
      addLog(`[CLIENT ADDED] ${d.name}`, 'evt');
    } else if(d.type === 'client_revoked'){
      addLog(`[CLIENT REVOKED] ${d.name}`, 'evt');
    } else if(d.type === 'log'){
      addLog(d.message);
    }
  };
}

loadClients();
connect();
</script>
</body>
</html>
HTMLEOF

pip3 install flask flask-cors pytz psutil --break-system-packages
which inotifywait || apt install -y inotify-tools
systemctl stop <service-name>
systemctl disable <service-name>
cd /opt/openvpn_dashboard
python3 app.py
python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

# 1) Remove the "Add Client" input row + message div from Client Management card
old_block = '''      <div class="addrow">
        <input type="text" id="newClientName" placeholder="naya client naam (e.g. laptop2)">
        <button onclick="addClient()">+ Add Client</button>
      </div>
      <div id="addMsg" class="msg"></div>
'''
html = html.replace(old_block, "")

# 2) Remove the addClient() JS function entirely
import re
html = re.sub(
    r"async function addClient\(\)\{.*?\n\}\n\n",
    "",
    html,
    flags=re.DOTALL
)

with open(path, "w") as f:
    f.write(html)

print("Done. 'Add Client' UI aur JS function remove ho gaye.")
EOF

python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

# 1) Remove the "Add Client" input row + message div from Client Management card
old_block = '''      <div class="addrow">
        <input type="text" id="newClientName" placeholder="naya client naam (e.g. laptop2)">
        <button onclick="addClient()">+ Add Client</button>
      </div>
      <div id="addMsg" class="msg"></div>
'''
html = html.replace(old_block, "")

# 2) Remove the addClient() JS function entirely
import re
html = re.sub(
    r"async function addClient\(\)\{.*?\n\}\n\n",
    "",
    html,
    flags=re.DOTALL
)

with open(path, "w") as f:
    f.write(html)

print("Done. 'Add Client' UI aur JS function remove ho gaye.")
EOF

cd /opt/openvpn_dashboard
python3 app.py
python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

old_kbps = """function kbps(v){ if(v >= 1024) return (v/1024).toFixed(1)+' MB/s'; return (v||0).toFixed(1)+' KB/s'; }"""
new_kbps = """function kbps(v){
  v = v || 0;
  if(v >= 1048576) return (v/1048576).toFixed(2)+' GB/s';
  if(v >= 1024) return (v/1024).toFixed(2)+' MB/s';
  return v.toFixed(1)+' KB/s';
}"""
html = html.replace(old_kbps, new_kbps)

old_mbfmt = """function mbFmt(b){ b = parseInt(b||0); if(b >= 1048576) return (b/1048576).toFixed(1)+' MB'; return (b/1024).toFixed(1)+' KB'; }"""
new_mbfmt = """function mbFmt(b){
  b = parseInt(b||0);
  if(b >= 1073741824) return (b/1073741824).toFixed(2)+' GB';
  if(b >= 1048576) return (b/1048576).toFixed(2)+' MB';
  if(b >= 1024) return (b/1024).toFixed(1)+' KB';
  return b+' B';
}"""
html = html.replace(old_mbfmt, new_mbfmt)

# Total sent/recv (tun0 / eth0 boxes) — these come from backend already in MB, let's make them auto GB too
old_totals = '''document.getElementById('tun-up-total').textContent = t.available ? `Total: ${t.total_sent_mb} MB` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${t.total_recv_mb} MB` : '';'''
new_totals = '''document.getElementById('tun-up-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_sent_mb)}` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_recv_mb)}` : '';'''
html = html.replace(old_totals, new_totals)

old_eth_totals = '''document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${eth.total_sent_mb} MB` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${eth.total_recv_mb} MB` : '';'''
new_eth_totals = '''document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_sent_mb)}` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_recv_mb)}` : '';'''
html = html.replace(old_eth_totals, new_eth_totals)

# Add helper function fmtMbGb right after mbFmt function
html = html.replace(
    new_mbfmt,
    new_mbfmt + """
function fmtMbGb(mb){
  mb = parseFloat(mb || 0);
  if(mb >= 1024) return (mb/1024).toFixed(2)+' GB';
  return mb.toFixed(1)+' MB';
}"""
)

with open(path, "w") as f:
    f.write(html)

print("Bandwidth formatting updated: ab KB/MB/GB dono auto-scale ho gaye.")
EOF

python3 app.py 
python3 << 'EOF'
path = "/opt/openvpn_dashboard/app.py"
with open(path) as f:
    code = f.read()

old = '''            if psutil:
                cpu = psutil.cpu_percent(interval=None)
                ram = psutil.virtual_memory().percent
                uptime_secs = int(time.time() - psutil.boot_time())
            else:
                cpu, ram, uptime_secs = 0, 0, 0'''

new = '''            if psutil:
                cpu = psutil.cpu_percent(interval=None)
                ram = psutil.virtual_memory().percent
                uptime_secs = int(time.time() - psutil.boot_time())
                disk = psutil.disk_usage('/')
                disk_percent = disk.percent
                disk_used_gb = round(disk.used / (1024**3), 1)
                disk_total_gb = round(disk.total / (1024**3), 1)
            else:
                cpu, ram, uptime_secs = 0, 0, 0
                disk_percent, disk_used_gb, disk_total_gb = 0, 0, 0'''
code = code.replace(old, new)

old2 = '''                "system": {"cpu_percent": cpu, "ram_percent": ram, "uptime_secs": uptime_secs},'''
new2 = '''                "system": {"cpu_percent": cpu, "ram_percent": ram, "uptime_secs": uptime_secs,
                           "disk_percent": disk_percent, "disk_used_gb": disk_used_gb, "disk_total_gb": disk_total_gb},'''
code = code.replace(old2, new2)

with open(path, "w") as f:
    f.write(code)

print("app.py updated with disk usage metrics.")
EOF

python3 app.py 
cat > /opt/openvpn_dashboard/templates/dashboard.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenVPN Control Center</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<style>
  :root { --bg:#0d1117; --card:#161b22; --border:#30363d; --green:#3fb950; --blue:#58a6ff; --orange:#d29922; --red:#f85149; --purple:#a371f7; --text:#c9d1d9; --muted:#8b949e; }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { background:var(--bg); color:var(--text); font-family:'Segoe UI',system-ui,sans-serif; padding:24px; }
  header { display:flex; align-items:center; gap:12px; margin-bottom:24px; border-bottom:1px solid var(--border); padding-bottom:16px; }
  header h1 { font-size:1.5rem; color:#fff; }
  .dot { width:10px; height:10px; border-radius:50%; background:var(--red); }
  .dot.live { background:var(--green); animation:pulse 1.5s infinite; }
  @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:.4} }
  .status-text { font-size:.8rem; color:var(--muted); }
  .sub { font-size:.75rem; color:var(--muted); margin-left:auto; }
  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:16px; margin-bottom:20px; }
  .card { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; transition:transform .2s, box-shadow .2s; }
  .card:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(0,0,0,.3); }
  .card-title { font-size:.75rem; text-transform:uppercase; letter-spacing:.08em; color:var(--muted); margin-bottom:12px; }
  .big-number { font-size:2.6rem; font-weight:700; color:#fff; line-height:1; }
  .sub-label { font-size:.8rem; color:var(--muted); margin-top:4px; }
  .bw-row { display:flex; justify-content:space-between; margin-top:10px; gap:8px; }
  .bw-box { flex:1; background:var(--bg); border:1px solid var(--border); border-radius:6px; padding:10px 12px; }
  .bw-label { font-size:.7rem; color:var(--muted); }
  .bw-val { font-size:1.3rem; font-weight:700; margin-top:2px; }
  .bw-total { font-size:.72rem; color:var(--muted); margin-top:2px; }
  .up { color:var(--orange); } .down { color:var(--blue); }
  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:12px; margin-top:4px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.4rem; font-weight:700; color:#fff; }
  .sys-lbl { font-size:.7rem; color:var(--muted); margin-top:2px; }
  .bar-wrap { background:var(--bg); border-radius:4px; height:6px; margin-top:6px; overflow:hidden; }
  .bar-fill { height:100%; border-radius:4px; transition:width .4s; }
  .bar-cpu { background:var(--blue); } .bar-ram { background:var(--orange); } .bar-disk { background:var(--purple); }
  .section { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; margin-bottom:20px; }
  table { width:100%; border-collapse:collapse; font-size:.85rem; }
  th { text-align:left; padding:8px 10px; color:var(--muted); border-bottom:1px solid var(--border); font-weight:500; font-size:.72rem; text-transform:uppercase; }
  td { padding:10px; border-bottom:1px solid var(--border); }
  tr:last-child td { border-bottom:none; }
  .badge { display:inline-block; padding:2px 8px; border-radius:4px; font-size:.72rem; font-weight:600; }
  .badge.online, .badge.valid { background:rgba(63,185,80,.15); color:var(--green); border:1px solid rgba(63,185,80,.3); }
  .badge.offline { background:rgba(139,148,158,.15); color:var(--muted); border:1px solid var(--border); }
  .badge.revoked { background:rgba(248,81,73,.15); color:var(--red); border:1px solid rgba(248,81,73,.3); }
  .empty { color:var(--muted); font-size:.85rem; padding:16px 0; text-align:center; }
  #log { background:#000; border-radius:6px; padding:12px; height:280px; overflow-y:auto; font-size:.75rem; line-height:1.6; font-family:Consolas,monospace; }
  .logline { color:var(--muted); }
  .logline.evt { color:var(--green); }
  .two-col { display:grid; grid-template-columns:1.3fr 1fr; gap:16px; }
  @media (max-width:900px){ .two-col{ grid-template-columns:1fr; } }
  .ts { font-size:.72rem; color:var(--muted); margin-top:10px; text-align:right; }
  .device-icon { margin-right:6px; }
  .chart-wrap { position:relative; height:220px; margin-top:10px; }

  /* Toast notifications */
  #toast-container { position:fixed; top:20px; right:20px; z-index:9999; display:flex; flex-direction:column; gap:10px; }
  .toast { background:var(--card); border:1px solid var(--border); border-left:4px solid var(--blue); border-radius:8px; padding:12px 16px; min-width:240px; box-shadow:0 8px 24px rgba(0,0,0,.4); animation:slideIn .3s ease-out; font-size:.82rem; }
  .toast.connect { border-left-color:var(--green); }
  .toast.disconnect { border-left-color:var(--muted); }
  .toast.added { border-left-color:var(--blue); }
  .toast.revoked { border-left-color:var(--red); }
  .toast .t-title { font-weight:700; color:#fff; margin-bottom:2px; }
  .toast .t-sub { color:var(--muted); font-size:.75rem; }
  @keyframes slideIn { from{ transform:translateX(120%); opacity:0; } to{ transform:translateX(0); opacity:1; } }
  @keyframes fadeOut { to{ opacity:0; transform:translateX(30px); } }
</style>
</head>
<body>
<div id="toast-container"></div>

<header>
  <div class="dot" id="dot"></div>
  <h1>🔒 OpenVPN Control Center</h1>
  <span class="status-text" id="conn-status">Connecting...</span>
  <span class="sub">152.42.241.74 · tun0 / eth0 live</span>
</header>

<div class="grid">
  <div class="card">
    <div class="card-title">Connected Clients</div>
    <div class="big-number" id="total-clients">0</div>
    <div class="sub-label">Active VPN connections</div>
  </div>
  <div class="card">
    <div class="card-title">🔵 tun0 — VPN Tunnel</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="tun-up">—</div><div class="bw-total" id="tun-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="tun-down">—</div><div class="bw-total" id="tun-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">🟠 Ethernet</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="eth-up">—</div><div class="bw-total" id="eth-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="eth-down">—</div><div class="bw-total" id="eth-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">System Health</div>
    <div class="sys-grid">
      <div class="sys-item"><div class="sys-val" id="cpu">0%</div><div class="bar-wrap"><div class="bar-fill bar-cpu" id="cpu-bar" style="width:0%"></div></div><div class="sys-lbl">CPU</div></div>
      <div class="sys-item"><div class="sys-val" id="ram">0%</div><div class="bar-wrap"><div class="bar-fill bar-ram" id="ram-bar" style="width:0%"></div></div><div class="sys-lbl">RAM</div></div>
      <div class="sys-item"><div class="sys-val" id="disk">0%</div><div class="bar-wrap"><div class="bar-fill bar-disk" id="disk-bar" style="width:0%"></div></div><div class="sys-lbl">Disk</div></div>
      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>
    </div>
  </div>
</div>

<div class="section">
  <div class="card-title">📈 Live Bandwidth (last 60s)</div>
  <div class="chart-wrap"><canvas id="bwChart"></canvas></div>
</div>

<div class="two-col">
  <div>
    <div class="section">
      <div class="card-title">Client Management</div>
      <table>
        <thead><tr><th>Name</th><th>Status</th><th>Expiry</th><th>Online</th><th>Actions</th></tr></thead>
        <tbody id="clientsBody"><tr><td colspan="5" class="empty">Loading...</td></tr></tbody>
      </table>
    </div>

    <div class="section">
      <div class="card-title">Client Details (Live Usage)</div>
      <div id="clients-container"><div class="empty">Koi client connected nahi hai</div></div>
    </div>
  </div>

  <div class="section">
    <div class="card-title">Live Log Stream</div>
    <div id="log"></div>
  </div>
</div>

<div class="ts" id="ts">Last update: —</div>

<script>
/* ---------- Toasts ---------- */
function showToast(type, title, sub){
  const c = document.getElementById('toast-container');
  const el = document.createElement('div');
  el.className = 'toast ' + type;
  el.innerHTML = `<div class="t-title">${title}</div><div class="t-sub">${sub||''}</div>`;
  c.appendChild(el);
  setTimeout(() => { el.style.animation = 'fadeOut .4s forwards'; setTimeout(()=>el.remove(), 400); }, 4000);
}

/* ---------- Animated numbers ---------- */
function animateNumber(el, newVal, suffix){
  suffix = suffix || '';
  const current = parseFloat(el.dataset.val || '0');
  const target = parseFloat(newVal) || 0;
  const steps = 12;
  let step = 0;
  clearInterval(el._timer);
  el._timer = setInterval(() => {
    step++;
    const val = current + (target - current) * (step/steps);
    el.textContent = (suffix === '%' ? Math.round(val) : val.toFixed(0)) + suffix;
    if(step >= steps){ clearInterval(el._timer); el.textContent = Math.round(target) + suffix; }
  }, 25);
  el.dataset.val = target;
}

/* ---------- Device icon guesser ---------- */
function deviceIcon(name){
  const n = (name||'').toLowerCase();
  if(n.includes('phone') || n.includes('mobile') || n.includes('android') || n.includes('iphone')) return '📱';
  if(n.includes('laptop') || n.includes('macbook')) return '💻';
  if(n.includes('desktop') || n.includes('pc')) return '🖥️';
  if(n.includes('server')) return '🖧';
  return '🔑';
}

/* ---------- Log ---------- */
const logEl = document.getElementById('log');
function addLog(text, cls){
  const d = document.createElement('div');
  d.className = 'logline' + (cls ? ' '+cls : '');
  d.textContent = text;
  logEl.appendChild(d);
  logEl.scrollTop = logEl.scrollHeight;
  while(logEl.children.length > 300) logEl.removeChild(logEl.firstChild);
}

/* ---------- Formatters ---------- */
function kbps(v){
  v = v || 0;
  if(v >= 1048576) return (v/1048576).toFixed(2)+' GB/s';
  if(v >= 1024) return (v/1024).toFixed(2)+' MB/s';
  return v.toFixed(1)+' KB/s';
}
function mbFmt(b){
  b = parseInt(b||0);
  if(b >= 1073741824) return (b/1073741824).toFixed(2)+' GB';
  if(b >= 1048576) return (b/1048576).toFixed(2)+' MB';
  if(b >= 1024) return (b/1024).toFixed(1)+' KB';
  return b+' B';
}
function fmtMbGb(mb){
  mb = parseFloat(mb || 0);
  if(mb >= 1024) return (mb/1024).toFixed(2)+' GB';
  return mb.toFixed(1)+' MB';
}
function formatUptime(s){ const h=Math.floor(s/3600), m=Math.floor((s%3600)/60); return `${h}h ${m}m`; }
function esc(s){ return String(s).replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

/* ---------- Client management ---------- */
async function loadClients(){
  const res = await fetch('/api/clients');
  const data = await res.json();
  const body = document.getElementById('clientsBody');
  body.innerHTML = '';
  if(!data.clients.length){ body.innerHTML = '<tr><td colspan="5" class="empty">Koi client nahi hai.</td></tr>'; return; }
  data.clients.forEach(c => {
    const statusBadge = c.status === 'valid' ? 'valid' : 'revoked';
    const onlineBadge = c.online ? 'online' : 'offline';
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td><span class="device-icon">${deviceIcon(c.name)}</span>${esc(c.name)}</td>
      <td><span class="badge ${statusBadge}">${c.status}</span></td>
      <td>${c.expiry || '-'}</td>
      <td><span class="badge ${onlineBadge}">${c.online ? 'ONLINE' : 'offline'}</span></td>
      <td>
        <button class="secondary" onclick="downloadClient('${c.name}')">⬇ .ovpn</button>
        <button class="danger" onclick="revokeClient('${c.name}')">Revoke</button>
      </td>`;
    body.appendChild(tr);
  });
}
function downloadClient(name){ window.open('/api/clients/' + encodeURIComponent(name) + '/download', '_blank'); }
async function revokeClient(name){
  if(!confirm('Client "' + name + '" ko revoke karna hai?')) return;
  const res = await fetch('/api/clients/revoke', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({name}) });
  const data = await res.json();
  if(data.success){ loadClients(); }
  else { alert('Error: ' + data.error); }
}

function renderClients(clients){
  const el = document.getElementById('clients-container');
  if(!clients.length){ el.innerHTML = '<div class="empty">Koi client connected nahi hai</div>'; return; }
  let html = '<table><thead><tr><th>Name</th><th>Real IP</th><th>VPN IP</th><th>Data In</th><th>Data Out</th><th>Since</th></tr></thead><tbody>';
  clients.forEach(c => {
    html += `<tr><td>${deviceIcon(c.common_name)} ${esc(c.common_name)}</td><td>${esc(c.real_address)}</td><td>${esc(c.vpn_ip)}</td><td class="down">${mbFmt(c.bytes_received)}</td><td class="up">${mbFmt(c.bytes_sent)}</td><td>${esc(c.connected_since)}</td></tr>`;
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

/* ---------- Live bandwidth chart ---------- */
const MAX_POINTS = 30;
const chartLabels = Array(MAX_POINTS).fill('');
const chartData = {
  labels: chartLabels,
  datasets: [
    { label: 'tun0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#58a6ff', backgroundColor: 'rgba(88,166,255,.1)', tension:.35, fill:true, pointRadius:0, borderWidth:2 },
    { label: 'tun0 ⬆ Up (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#d29922', backgroundColor: 'rgba(210,153,34,.1)', tension:.35, fill:true, pointRadius:0, borderWidth:2 },
    { label: 'eth0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#3fb950', backgroundColor: 'rgba(63,185,80,.05)', tension:.35, fill:false, pointRadius:0, borderWidth:1, borderDash:[4,4] },
  ]
};
const ctx = document.getElementById('bwChart').getContext('2d');
const bwChart = new Chart(ctx, {
  type: 'line',
  data: chartData,
  options: {
    responsive:true, maintainAspectRatio:false,
    animation: { duration: 300 },
    plugins: { legend: { labels: { color:'#c9d1d9', font:{size:11} } } },
    scales: {
      x: { display:false },
      y: { beginAtZero:true, ticks:{ color:'#8b949e', font:{size:10} }, grid:{ color:'#21262d' } }
    }
  }
});
function pushChartPoint(tunDown, tunUp, ethDown){
  chartData.datasets[0].data.push(tunDown); chartData.datasets[0].data.shift();
  chartData.datasets[1].data.push(tunUp); chartData.datasets[1].data.shift();
  chartData.datasets[2].data.push(ethDown); chartData.datasets[2].data.shift();
  bwChart.update('none');
}

/* ---------- SSE stream ---------- */
func


cat > /opt/openvpn_dashboard/templates/dashboard.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenVPN Control Center</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<style>
  :root { --bg:#0d1117; --card:#161b22; --border:#30363d; --green:#3fb950; --blue:#58a6ff; --orange:#d29922; --red:#f85149; --purple:#a371f7; --text:#c9d1d9; --muted:#8b949e; }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { background:var(--bg); color:var(--text); font-family:'Segoe UI',system-ui,sans-serif; padding:24px; }
  header { display:flex; align-items:center; gap:12px; margin-bottom:24px; border-bottom:1px solid var(--border); padding-bottom:16px; }
  header h1 { font-size:1.5rem; color:#fff; }
  .dot { width:10px; height:10px; border-radius:50%; background:var(--red); }
  .dot.live { background:var(--green); animation:pulse 1.5s infinite; }
  @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:.4} }
  .status-text { font-size:.8rem; color:var(--muted); }
  .sub { font-size:.75rem; color:var(--muted); margin-left:auto; }
  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:16px; margin-bottom:20px; }
  .card { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; transition:transform .2s, box-shadow .2s; }
  .card:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(0,0,0,.3); }
  .card-title { font-size:.75rem; text-transform:uppercase; letter-spacing:.08em; color:var(--muted); margin-bottom:12px; }
  .big-number { font-size:2.6rem; font-weight:700; color:#fff; line-height:1; }
  .sub-label { font-size:.8rem; color:var(--muted); margin-top:4px; }
  .bw-row { display:flex; justify-content:space-between; margin-top:10px; gap:8px; }
  .bw-box { flex:1; background:var(--bg); border:1px solid var(--border); border-radius:6px; padding:10px 12px; }
  .bw-label { font-size:.7rem; color:var(--muted); }
  .bw-val { font-size:1.3rem; font-weight:700; margin-top:2px; }
  .bw-total { font-size:.72rem; color:var(--muted); margin-top:2px; }
  .up { color:var(--orange); } .down { color:var(--blue); }
  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:12px; margin-top:4px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.4rem; font-weight:700; color:#fff; }
  .sys-lbl { font-size:.7rem; color:var(--muted); margin-top:2px; }
  .bar-wrap { background:var(--bg); border-radius:4px; height:6px; margin-top:6px; overflow:hidden; }
  .bar-fill { height:100%; border-radius:4px; transition:width .4s; }
  .bar-cpu { background:var(--blue); } .bar-ram { background:var(--orange); } .bar-disk { background:var(--purple); }
  .section { background:var(--card); border:1px solid var(--border); border-radius:10px; padding:20px; margin-bottom:20px; }
  table { width:100%; border-collapse:collapse; font-size:.85rem; }
  th { text-align:left; padding:8px 10px; color:var(--muted); border-bottom:1px solid var(--border); font-weight:500; font-size:.72rem; text-transform:uppercase; }
  td { padding:10px; border-bottom:1px solid var(--border); }
  tr:last-child td { border-bottom:none; }
  .badge { display:inline-block; padding:2px 8px; border-radius:4px; font-size:.72rem; font-weight:600; }
  .badge.online, .badge.valid { background:rgba(63,185,80,.15); color:var(--green); border:1px solid rgba(63,185,80,.3); }
  .badge.offline { background:rgba(139,148,158,.15); color:var(--muted); border:1px solid var(--border); }
  .badge.revoked { background:rgba(248,81,73,.15); color:var(--red); border:1px solid rgba(248,81,73,.3); }
  .empty { color:var(--muted); font-size:.85rem; padding:16px 0; text-align:center; }
  #log { background:#000; border-radius:6px; padding:12px; height:280px; overflow-y:auto; font-size:.75rem; line-height:1.6; font-family:Consolas,monospace; }
  .logline { color:var(--muted); }
  .logline.evt { color:var(--green); }
  .two-col { display:grid; grid-template-columns:1.3fr 1fr; gap:16px; }
  @media (max-width:900px){ .two-col{ grid-template-columns:1fr; } }
  .ts { font-size:.72rem; color:var(--muted); margin-top:10px; text-align:right; }
  .device-icon { margin-right:6px; }
  .chart-wrap { position:relative; height:220px; margin-top:10px; }

  /* Toast notifications */
  #toast-container { position:fixed; top:20px; right:20px; z-index:9999; display:flex; flex-direction:column; gap:10px; }
  .toast { background:var(--card); border:1px solid var(--border); border-left:4px solid var(--blue); border-radius:8px; padding:12px 16px; min-width:240px; box-shadow:0 8px 24px rgba(0,0,0,.4); animation:slideIn .3s ease-out; font-size:.82rem; }
  .toast.connect { border-left-color:var(--green); }
  .toast.disconnect { border-left-color:var(--muted); }
  .toast.added { border-left-color:var(--blue); }
  .toast.revoked { border-left-color:var(--red); }
  .toast .t-title { font-weight:700; color:#fff; margin-bottom:2px; }
  .toast .t-sub { color:var(--muted); font-size:.75rem; }
  @keyframes slideIn { from{ transform:translateX(120%); opacity:0; } to{ transform:translateX(0); opacity:1; } }
  @keyframes fadeOut { to{ opacity:0; transform:translateX(30px); } }
</style>
</head>
<body>
<div id="toast-container"></div>

<header>
  <div class="dot" id="dot"></div>
  <h1>🔒 OpenVPN Control Center</h1>
  <span class="status-text" id="conn-status">Connecting...</span>
  <span class="sub">152.42.241.74 · tun0 / eth0 live</span>
</header>

<div class="grid">
  <div class="card">
    <div class="card-title">Connected Clients</div>
    <div class="big-number" id="total-clients">0</div>
    <div class="sub-label">Active VPN connections</div>
  </div>
  <div class="card">
    <div class="card-title">🔵 tun0 — VPN Tunnel</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="tun-up">—</div><div class="bw-total" id="tun-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="tun-down">—</div><div class="bw-total" id="tun-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">🟠 Ethernet</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="eth-up">—</div><div class="bw-total" id="eth-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="eth-down">—</div><div class="bw-total" id="eth-down-total"></div></div>
    </div>
  </div>
  <div class="card">
    <div class="card-title">System Health</div>
    <div class="sys-grid">
      <div class="sys-item"><div class="sys-val" id="cpu">0%</div><div class="bar-wrap"><div class="bar-fill bar-cpu" id="cpu-bar" style="width:0%"></div></div><div class="sys-lbl">CPU</div></div>
      <div class="sys-item"><div class="sys-val" id="ram">0%</div><div class="bar-wrap"><div class="bar-fill bar-ram" id="ram-bar" style="width:0%"></div></div><div class="sys-lbl">RAM</div></div>
      <div class="sys-item"><div class="sys-val" id="disk">0%</div><div class="bar-wrap"><div class="bar-fill bar-disk" id="disk-bar" style="width:0%"></div></div><div class="sys-lbl">Disk</div></div>
      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>
    </div>
  </div>
</div>

<div class="section">
  <div class="card-title">📈 Live Bandwidth (last 60s)</div>
  <div class="chart-wrap"><canvas id="bwChart"></canvas></div>
</div>

<div class="two-col">
  <div>
    <div class="section">
      <div class="card-title">Client Management</div>
      <table>
        <thead><tr><th>Name</th><th>Status</th><th>Expiry</th><th>Online</th><th>Actions</th></tr></thead>
        <tbody id="clientsBody"><tr><td colspan="5" class="empty">Loading...</td></tr></tbody>
      </table>
    </div>

    <div class="section">
      <div class="card-title">Client Details (Live Usage)</div>
      <div id="clients-container"><div class="empty">Koi client connected nahi hai</div></div>
    </div>
  </div>

  <div class="section">
    <div class="card-title">Live Log Stream</div>
    <div id="log"></div>
  </div>
</div>

<div class="ts" id="ts">Last update: —</div>

<script>
/* ---------- Toasts ---------- */
function showToast(type, title, sub){
  const c = document.getElementById('toast-container');
  const el = document.createElement('div');
  el.className = 'toast ' + type;
  el.innerHTML = `<div class="t-title">${title}</div><div class="t-sub">${sub||''}</div>`;
  c.appendChild(el);
  setTimeout(() => { el.style.animation = 'fadeOut .4s forwards'; setTimeout(()=>el.remove(), 400); }, 4000);
}

/* ---------- Animated numbers ---------- */
function animateNumber(el, newVal, suffix){
  suffix = suffix || '';
  const current = parseFloat(el.dataset.val || '0');
  const target = parseFloat(newVal) || 0;
  const steps = 12;
  let step = 0;
  clearInterval(el._timer);
  el._timer = setInterval(() => {
    step++;
    const val = current + (target - current) * (step/steps);
    el.textContent = (suffix === '%' ? Math.round(val) : val.toFixed(0)) + suffix;
    if(step >= steps){ clearInterval(el._timer); el.textContent = Math.round(target) + suffix; }
  }, 25);
  el.dataset.val = target;
}

/* ---------- Device icon guesser ---------- */
function deviceIcon(name){
  const n = (name||'').toLowerCase();
  if(n.includes('phone') || n.includes('mobile') || n.includes('android') || n.includes('iphone')) return '📱';
  if(n.includes('laptop') || n.includes('macbook')) return '💻';
  if(n.includes('desktop') || n.includes('pc')) return '🖥️';
  if(n.includes('server')) return '🖧';
  return '🔑';
}

/* ---------- Log ---------- */
const logEl = document.getElementById('log');
function addLog(text, cls){
  const d = document.createElement('div');
  d.className = 'logline' + (cls ? ' '+cls : '');
  d.textContent = text;
  logEl.appendChild(d);
  logEl.scrollTop = logEl.scrollHeight;
  while(logEl.children.length > 300) logEl.removeChild(logEl.firstChild);
}

/* ---------- Formatters ---------- */
function kbps(v){
  v = v || 0;
  if(v >= 1048576) return (v/1048576).toFixed(2)+' GB/s';
  if(v >= 1024) return (v/1024).toFixed(2)+' MB/s';
  return v.toFixed(1)+' KB/s';
}
function mbFmt(b){
  b = parseInt(b||0);
  if(b >= 1073741824) return (b/1073741824).toFixed(2)+' GB';
  if(b >= 1048576) return (b/1048576).toFixed(2)+' MB';
  if(b >= 1024) return (b/1024).toFixed(1)+' KB';
  return b+' B';
}
function fmtMbGb(mb){
  mb = parseFloat(mb || 0);
  if(mb >= 1024) return (mb/1024).toFixed(2)+' GB';
  return mb.toFixed(1)+' MB';
}
function formatUptime(s){ const h=Math.floor(s/3600), m=Math.floor((s%3600)/60); return `${h}h ${m}m`; }
function esc(s){ return String(s).replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

/* ---------- Client management ---------- */
async function loadClients(){
  const res = await fetch('/api/clients');
  const data = await res.json();
  const body = document.getElementById('clientsBody');
  body.innerHTML = '';
  if(!data.clients.length){ body.innerHTML = '<tr><td colspan="5" class="empty">Koi client nahi hai.</td></tr>'; return; }
  data.clients.forEach(c => {
    const statusBadge = c.status === 'valid' ? 'valid' : 'revoked';
    const onlineBadge = c.online ? 'online' : 'offline';
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td><span class="device-icon">${deviceIcon(c.name)}</span>${esc(c.name)}</td>
      <td><span class="badge ${statusBadge}">${c.status}</span></td>
      <td>${c.expiry || '-'}</td>
      <td><span class="badge ${onlineBadge}">${c.online ? 'ONLINE' : 'offline'}</span></td>
      <td>
        <button class="secondary" onclick="downloadClient('${c.name}')">⬇ .ovpn</button>
        <button class="danger" onclick="revokeClient('${c.name}')">Revoke</button>
      </td>`;
    body.appendChild(tr);
  });
}
function downloadClient(name){ window.open('/api/clients/' + encodeURIComponent(name) + '/download', '_blank'); }
async function revokeClient(name){
  if(!confirm('Client "' + name + '" ko revoke karna hai?')) return;
  const res = await fetch('/api/clients/revoke', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({name}) });
  const data = await res.json();
  if(data.success){ loadClients(); }
  else { alert('Error: ' + data.error); }
}

function renderClients(clients){
  const el = document.getElementById('clients-container');
  if(!clients.length){ el.innerHTML = '<div class="empty">Koi client connected nahi hai</div>'; return; }
  let html = '<table><thead><tr><th>Name</th><th>Real IP</th><th>VPN IP</th><th>Data In</th><th>Data Out</th><th>Since</th></tr></thead><tbody>';
  clients.forEach(c => {
    html += `<tr><td>${deviceIcon(c.common_name)} ${esc(c.common_name)}</td><td>${esc(c.real_address)}</td><td>${esc(c.vpn_ip)}</td><td class="down">${mbFmt(c.bytes_received)}</td><td class="up">${mbFmt(c.bytes_sent)}</td><td>${esc(c.connected_since)}</td></tr>`;
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

/* ---------- Live bandwidth chart ---------- */
const MAX_POINTS = 30;
const chartLabels = Array(MAX_POINTS).fill('');
const chartData = {
  labels: chartLabels,
  datasets: [
    { label: 'tun0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#58a6ff', backgroundColor: 'rgba(88,166,255,.1)', tension:.35, fill:true, pointRadius:0, borderWidth:2 },
    { label: 'tun0 ⬆ Up (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#d29922', backgroundColor: 'rgba(210,153,34,.1)', tension:.35, fill:true, pointRadius:0, borderWidth:2 },
    { label: 'eth0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#3fb950', backgroundColor: 'rgba(63,185,80,.05)', tension:.35, fill:false, pointRadius:0, borderWidth:1, borderDash:[4,4] },
  ]
};
const ctx = document.getElementById('bwChart').getContext('2d');
const bwChart = new Chart(ctx, {
  type: 'line',
  data: chartData,
  options: {
    responsive:true, maintainAspectRatio:false,
    animation: { duration: 300 },
    plugins: { legend: { labels: { color:'#c9d1d9', font:{size:11} } } },
    scales: {
      x: { display:false },
      y: { beginAtZero:true, ticks:{ color:'#8b949e', font:{size:10} }, grid:{ color:'#21262d' } }
    }
  }
});
function pushChartPoint(tunDown, tunUp, ethDown){
  chartData.datasets[0].data.push(tunDown); chartData.datasets[0].data.shift();
  chartData.datasets[1].data.push(tunUp); chartData.datasets[1].data.shift();
  chartData.datasets[2].data.push(ethDown); chartData.datasets[2].data.shift();
  bwChart.update('none');
}

/* ---------- SSE stream ---------- */
function connect(){
  const es = new EventSource('/api/stream');
  es.onopen = () => { document.getElementById('dot').classList.add('live'); document.getElementById('conn-status').textContent = 'Live'; };
  es.onerror = () => { document.getElementById('dot').classList.remove('live'); document.getElementById('conn-status').textContent = 'Reconnecting...'; es.close(); setTimeout(connect, 3000); };
  es.onmessage = (e) => {
    let d;
    try { d = JSON.parse(e.data); } catch(err){ return; }

    if(d.type === 'metrics'){
      animateNumber(document.getElementById('total-clients'), d.total_clients ?? 0, '');
      const t = d.tun0 || {};
      document.getElementById('tun-up').textContent = t.available ? kbps(t.upload_kbps) : 'N/A';
      document.getElementById('tun-down').textContent = t.available ? kbps(t.download_kbps) : 'N/A';
      document.getElementById('tun-up-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_sent_mb)}` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_recv_mb)}` : '';
      const eth = d.ethernet || {};
      document.getElementById('eth-up').textContent = eth.available ? kbps(eth.upload_kbps) : 'N/A';
      document.getElementById('eth-down').textContent = eth.available ? kbps(eth.download_kbps) : 'N/A';
      document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_sent_mb)}` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_recv_mb)}` : '';

      pushChartPoint(t.download_kbps||0, t.upload_kbps||0, eth.download_kbps||0);

      const sys = d.system || {};
      animateNumber(document.getElementById('cpu'), sys.cpu_percent ?? 0, '%');
      animateNumber(document.getElementById('ram'), sys.ram_percent ?? 0, '%');
      animateNumber(document.getElementById('disk'), sys.disk_percent ?? 0, '%');
      document.getElementById('cpu-bar').style.width = (sys.cpu_percent||0) + '%';
      document.getElementById('ram-bar').style.width = (sys.ram_percent||0) + '%';
      document.getElementById('disk-bar').style.width = (sys.disk_percent||0) + '%';
      document.getElementById('uptime').textContent = formatUptime(sys.uptime_secs ?? 0);

      renderClients(d.clients || []);
      document.getElementById('ts').textContent = 'Last update: ' + new Date(d.timestamp).toLocaleTimeString();
    } else if(d.type === 'connect'){
      addLog(`[CONNECT] ${d.common_name} from ${d.real_address}`, 'evt');
      showToast('connect', '🟢 Client Connected', d.common_name + ' — ' + d.real_address);
      loadClients();
    } else if(d.type === 'disconnect'){
      addLog(`[DISCONNECT] ${d.common_name}`, 'evt');
      showToast('disconnect', '⚪ Client Disconnected', d.common_name);
      loadClients();
    } else if(d.type === 'client_added'){
      addLog(`[CLIENT ADDED] ${d.name}`, 'evt');
      showToast('added', '➕ Client Added', d.name);
    } else if(d.type === 'client_revoked'){
      addLog(`[CLIENT REVOKED] ${d.name}`, 'evt');
      showToast('revoked', '🚫 Client Revoked', d.name);
    } else if(d.type === 'log'){
      addLog(d.message);
    }
  };
}

loadClients();
connect();
</script>
</body>
</html>
HTMLEOF

python3 app.py 
cat > /opt/openvpn_dashboard/templates/dashboard.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenVPN Control Center</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
<style>
  :root {
    --bg:#0a0e14; --bg2:#0d1420; --card:#131a24; --card2:#161f2c; --border:#232d3d;
    --green:#3fdd78; --blue:#5eb4ff; --orange:#f0a92c; --red:#ff5c72; --purple:#b088ff; --cyan:#4ddbe8;
    --text:#dce3ea; --muted:#7c8b9e;
  }
  * { box-sizing:border-box; margin:0; padding:0; }
  body {
    background:
      radial-gradient(ellipse 900px 500px at 15% -10%, rgba(94,180,255,.10), transparent),
      radial-gradient(ellipse 900px 500px at 90% 10%, rgba(176,136,255,.08), transparent),
      var(--bg);
    color:var(--text); font-family:'Inter',system-ui,sans-serif; padding:28px; min-height:100vh;
  }
  ::-webkit-scrollbar { width:8px; height:8px; }
  ::-webkit-scrollbar-thumb { background:#2a3646; border-radius:4px; }
  ::-webkit-scrollbar-track { background:transparent; }

  header { display:flex; align-items:center; gap:14px; margin-bottom:28px; padding-bottom:20px; border-bottom:1px solid var(--border); }
  .logo-glow { width:38px; height:38px; border-radius:11px; background:linear-gradient(135deg,#5eb4ff,#b088ff); display:flex; align-items:center; justify-content:center; font-size:18px; box-shadow:0 0 24px rgba(94,180,255,.4); }
  header h1 { font-size:1.4rem; font-weight:800; background:linear-gradient(90deg,#fff,#9fb3c8); -webkit-background-clip:text; background-clip:text; color:transparent; letter-spacing:-.01em; }
  .dot { width:9px; height:9px; border-radius:50%; background:var(--red); box-shadow:0 0 8px var(--red); }
  .dot.live { background:var(--green); box-shadow:0 0 10px var(--green); animation:pulse 1.6s infinite; }
  @keyframes pulse { 0%,100%{opacity:1; transform:scale(1);} 50%{opacity:.5; transform:scale(1.3);} }
  .status-text { font-size:.78rem; color:var(--muted); font-weight:500; }
  .sub { font-size:.72rem; color:var(--muted); margin-left:auto; font-family:'JetBrains Mono',monospace; opacity:.7; }

  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:16px; margin-bottom:18px; }
  .card {
    background:linear-gradient(165deg,var(--card2),var(--card));
    border:1px solid var(--border); border-radius:14px; padding:20px;
    position:relative; overflow:hidden;
    transition:transform .25s ease, box-shadow .25s ease, border-color .25s ease;
    animation:fadeUp .5s ease backwards;
  }
  .card::before { content:''; position:absolute; top:0; left:0; right:0; height:2px; background:var(--accent,linear-gradient(90deg,#5eb4ff,#b088ff)); opacity:.8; }
  .card:hover { transform:translateY(-3px); box-shadow:0 16px 40px rgba(0,0,0,.35); border-color:#2e3a4d; }
  .card.acc-blue { --accent:linear-gradient(90deg,#5eb4ff,#4ddbe8); }
  .card.acc-orange { --accent:linear-gradient(90deg,#f0a92c,#ff8a3d); }
  .card.acc-green { --accent:linear-gradient(90deg,#3fdd78,#4ddbe8); }
  .card.acc-purple { --accent:linear-gradient(90deg,#b088ff,#5eb4ff); }
  @keyframes fadeUp { from{ opacity:0; transform:translateY(14px);} to{ opacity:1; transform:translateY(0);} }

  .card-title { font-size:.7rem; text-transform:uppercase; letter-spacing:.1em; color:var(--muted); margin-bottom:14px; font-weight:600; display:flex; align-items:center; gap:6px; }
  .big-number { font-size:2.8rem; font-weight:800; color:#fff; line-height:1; letter-spacing:-.02em; }
  .sub-label { font-size:.78rem; color:var(--muted); margin-top:6px; }

  .bw-row { display:flex; justify-content:space-between; margin-top:8px; gap:10px; }
  .bw-box { flex:1; background:rgba(255,255,255,.02); border:1px solid var(--border); border-radius:10px; padding:12px 14px; }
  .bw-label { font-size:.68rem; color:var(--muted); font-weight:500; }
  .bw-val { font-size:1.25rem; font-weight:700; margin-top:4px; font-family:'JetBrains Mono',monospace; }
  .bw-total { font-size:.7rem; color:var(--muted); margin-top:3px; font-family:'JetBrains Mono',monospace; }
  .up { color:var(--orange); } .down { color:var(--blue); }

  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-top:2px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.35rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; }
  .sys-lbl { font-size:.68rem; color:var(--muted); margin-top:4px; font-weight:500; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; overflow:hidden; }
  .bar-fill { height:100%; border-radius:6px; transition:width .5s ease; }
  .bar-cpu { background:linear-gradient(90deg,#5eb4ff,#4ddbe8); } .bar-ram { background:linear-gradient(90deg,#f0a92c,#ff8a3d); } .bar-disk { background:linear-gradient(90deg,#b088ff,#e388ff); }

  .section { background:linear-gradient(165deg,var(--card2),var(--card)); border:1px solid var(--border); border-radius:14px; padding:22px; margin-bottom:18px; animation:fadeUp .5s ease backwards; }
  .section .card-title { margin-bottom:16px; }

  table { width:100%; border-collapse:collapse; font-size:.84rem; }
  th { text-align:left; padding:10px; color:var(--muted); border-bottom:1px solid var(--border); font-weight:600; font-size:.68rem; text-transform:uppercase; letter-spacing:.06em; }
  td { padding:12px 10px; border-bottom:1px solid rgba(35,45,61,.6); }
  tr { transition:background .15s; }
  tr:hover td { background:rgba(255,255,255,.015); }
  tr:last-child td { border-bottom:none; }

  .badge { display:inline-flex; align-items:center; gap:4px; padding:3px 10px; border-radius:20px; font-size:.7rem; font-weight:600; }
  .badge.online, .badge.valid { background:rgba(63,221,120,.12); color:var(--green); border:1px solid rgba(63,221,120,.25); }
  .badge.offline { background:rgba(124,139,158,.1); color:var(--muted); border:1px solid var(--border); }
  .badge.revoked { background:rgba(255,92,114,.12); color:var(--red); border:1px solid rgba(255,92,114,.25); }
  .badge.online::before { content:'●'; font-size:8px; }

  .empty { color:var(--muted); font-size:.85rem; padding:24px 0; text-align:center; }
  button { background:linear-gradient(135deg,#5eb4ff,#4a95e0); color:#04121f; border:none; padding:9px 16px; border-radius:8px; cursor:pointer; font-size:.78rem; font-weight:700; transition:transform .15s, box-shadow .15s; }
  button:hover { transform:translateY(-1px); box-shadow:0 6px 16px rgba(94,180,255,.35); }
  button.danger { background:linear-gradient(135deg,#ff5c72,#e0405a); color:#fff; }
  button.danger:hover { box-shadow:0 6px 16px rgba(255,92,114,.35); }
  button.secondary { background:rgba(255,255,255,.05); color:var(--text); border:1px solid var(--border); margin-right:6px; }
  button.secondary:hover { box-shadow:none; background:rgba(255,255,255,.08); }

  #log { background:#050a10; border:1px solid var(--border); border-radius:10px; padding:14px; height:280px; overflow-y:auto; font-size:.74rem; line-height:1.7; font-family:'JetBrains Mono',monospace; }
  .logline { color:var(--muted); opacity:0; animation:logIn .3s forwards; }
  .logline.evt { color:var(--green); }
  @keyframes logIn { to{ opacity:1; } }

  .two-col { display:grid; grid-template-columns:1.3fr 1fr; gap:18px; }
  @media (max-width:900px){ .two-col{ grid-template-columns:1fr; } }
  .ts { font-size:.7rem; color:var(--muted); margin-top:14px; text-align:right; font-family:'JetBrains Mono',monospace; }
  .device-icon { margin-right:6px; }
  .chart-wrap { position:relative; height:230px; margin-top:6px; }

  #toast-container { position:fixed; top:22px; right:22px; z-index:9999; display:flex; flex-direction:column; gap:10px; }
  .toast { background:linear-gradient(165deg,var(--card2),var(--card)); border:1px solid var(--border); border-left:3px solid var(--blue); border-radius:10px; padding:13px 18px; min-width:250px; box-shadow:0 12px 32px rgba(0,0,0,.5); animation:slideIn .35s cubic-bezier(.2,.9,.3,1); font-size:.82rem; }
  .toast.connect { border-left-color:var(--green); }
  .toast.disconnect { border-left-color:var(--muted); }
  .toast.added { border-left-color:var(--blue); }
  .toast.revoked { border-left-color:var(--red); }
  .toast .t-title { font-weight:700; color:#fff; margin-bottom:3px; font-size:.85rem; }
  .toast .t-sub { color:var(--muted); font-size:.73rem; font-family:'JetBrains Mono',monospace; }
  @keyframes slideIn { from{ transform:translateX(130%); opacity:0; } to{ transform:translateX(0); opacity:1; } }
  @keyframes fadeOut { to{ opacity:0; transform:translateX(40px); } }
</style>
</head>
<body>
<div id="toast-container"></div>

<header>
  <div class="logo-glow">🔒</div>
  <h1>OpenVPN Control Center</h1>
  <div class="dot" id="dot"></div>
  <span class="status-text" id="conn-status">Connecting...</span>
  <span class="sub">152.42.241.74 · tun0 / eth0 live</span>
</header>

<div class="grid">
  <div class="card acc-blue" style="animation-delay:.02s">
    <div class="card-title">👥 Connected Clients</div>
    <div class="big-number" id="total-clients">0</div>
    <div class="sub-label">Active VPN connections</div>
  </div>
  <div class="card acc-blue" style="animation-delay:.06s">
    <div class="card-title">🔵 tun0 — VPN Tunnel</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="tun-up">—</div><div class="bw-total" id="tun-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="tun-down">—</div><div class="bw-total" id="tun-down-total"></div></div>
    </div>
  </div>
  <div class="card acc-orange" style="animation-delay:.1s">
    <div class="card-title">🟠 Ethernet</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="eth-up">—</div><div class="bw-total" id="eth-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="eth-down">—</div><div class="bw-total" id="eth-down-total"></div></div>
    </div>
  </div>
  <div class="card acc-purple" style="animation-delay:.14s">
    <div class="card-title">⚙️ System Health</div>
    <div class="sys-grid">
      <div class="sys-item"><div class="sys-val" id="cpu">0%</div><div class="bar-wrap"><div class="bar-fill bar-cpu" id="cpu-bar" style="width:0%"></div></div><div class="sys-lbl">CPU</div></div>
      <div class="sys-item"><div class="sys-val" id="ram">0%</div><div class="bar-wrap"><div class="bar-fill bar-ram" id="ram-bar" style="width:0%"></div></div><div class="sys-lbl">RAM</div></div>
      <div class="sys-item"><div class="sys-val" id="disk">0%</div><div class="bar-wrap"><div class="bar-fill bar-disk" id="disk-bar" style="width:0%"></div></div><div class="sys-lbl">Disk</div></div>
      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>
    </div>
  </div>
</div>

<div class="section acc-green" style="animation-delay:.18s">
  <div class="card-title">📈 Live Bandwidth <span style="opacity:.5; font-weight:400;">(last 60s)</span></div>
  <div class="chart-wrap"><canvas id="bwChart"></canvas></div>
</div>

<div class="two-col">
  <div>
    <div class="section" style="animation-delay:.22s">
      <div class="card-title">🛠️ Client Management</div>
      <table>
        <thead><tr><th>Name</th><th>Status</th><th>Expiry</th><th>Online</th><th>Actions</th></tr></thead>
        <tbody id="clientsBody"><tr><td colspan="5" class="empty">Loading...</td></tr></tbody>
      </table>
    </div>

    <div class="section" style="animation-delay:.26s">
      <div class="card-title">📊 Client Details (Live Usage)</div>
      <div id="clients-container"><div class="empty">Koi client connected nahi hai</div></div>
    </div>
  </div>

  <div class="section" style="animation-delay:.3s">
    <div class="card-title">📜 Live Log Stream</div>
    <div id="log"></div>
  </div>
</div>

<div class="ts" id="ts">Last update: —</div>

<script>
function showToast(type, title, sub){
  const c = document.getElementById('toast-container');
  const el = document.createElement('div');
  el.className = 'toast ' + type;
  el.innerHTML = `<div class="t-title">${title}</div><div class="t-sub">${sub||''}</div>`;
  c.appendChild(el);
  setTimeout(() => { el.style.animation = 'fadeOut .4s forwards'; setTimeout(()=>el.remove(), 400); }, 4000);
}

function animateNumber(el, newVal, suffix){
  suffix = suffix || '';
  const current = parseFloat(el.dataset.val || '0');
  const target = parseFloat(newVal) || 0;
  const steps = 12;
  let step = 0;
  clearInterval(el._timer);
  el._timer = setInterval(() => {
    step++;
    const val = current + (target - current) * (step/steps);
    el.textContent = (suffix === '%' ? Math.round(val) : val.toFixed(0)) + suffix;
    if(step >= steps){ clearInterval(el._timer); el.textContent = Math.round(target) + suffix; }
  }, 25);
  el.dataset.val = target;
}

function deviceIcon(name){
  const n = (name||'').toLowerCase();
  if(n.includes('phone') || n.includes('mobile') || n.includes('android') || n.includes('iphone')) return '📱';
  if(n.includes('laptop') || n.includes('macbook')) return '💻';
  if(n.includes('desktop') || n.includes('pc')) return '🖥️';
  if(n.includes('server')) return '🖧';
  return '🔑';
}

const logEl = document.getElementById('log');
function addLog(text, cls){
  const d = document.createElement('div');
  d.className = 'logline' + (cls ? ' '+cls : '');
  d.textContent = text;
  logEl.appendChild(d);
  logEl.scrollTop = logEl.scrollHeight;
  while(logEl.children.length > 300) logEl.removeChild(logEl.firstChild);
}

function kbps(v){
  v = v || 0;
  if(v >= 1048576) return (v/1048576).toFixed(2)+' GB/s';
  if(v >= 1024) return (v/1024).toFixed(2)+' MB/s';
  return v.toFixed(1)+' KB/s';
}
function mbFmt(b){
  b = parseInt(b||0);
  if(b >= 1073741824) return (b/1073741824).toFixed(2)+' GB';
  if(b >= 1048576) return (b/1048576).toFixed(2)+' MB';
  if(b >= 1024) return (b/1024).toFixed(1)+' KB';
  return b+' B';
}
function fmtMbGb(mb){
  mb = parseFloat(mb || 0);
  if(mb >= 1024) return (mb/1024).toFixed(2)+' GB';
  return mb.toFixed(1)+' MB';
}
function formatUptime(s){ const h=Math.floor(s/3600), m=Math.floor((s%3600)/60); return `${h}h ${m}m`; }
function esc(s){ return String(s).replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

async function loadClients(){
  const res = await fetch('/api/clients');
  const data = await res.json();
  const body = document.getElementById('clientsBody');
  body.innerHTML = '';
  if(!data.clients.length){ body.innerHTML = '<tr><td colspan="5" class="empty">Koi client nahi hai.</td></tr>'; return; }
  data.clients.forEach(c => {
    const statusBadge = c.status === 'valid' ? 'valid' : 'revoked';
    const onlineBadge = c.online ? 'online' : 'offline';
    const tr = document.createElement('tr');
    tr.innerHTML = `
      <td><span class="device-icon">${deviceIcon(c.name)}</span>${esc(c.name)}</td>
      <td><span class="badge ${statusBadge}">${c.status}</span></td>
      <td>${c.expiry || '-'}</td>
      <td><span class="badge ${onlineBadge}">${c.online ? 'ONLINE' : 'offline'}</span></td>
      <td>
        <button class="secondary" onclick="downloadClient('${c.name}')">⬇ .ovpn</button>
        <button class="danger" onclick="revokeClient('${c.name}')">Revoke</button>
      </td>`;
    body.appendChild(tr);
  });
}
function downloadClient(name){ window.open('/api/clients/' + encodeURIComponent(name) + '/download', '_blank'); }
async function revokeClient(name){
  if(!confirm('Client "' + name + '" ko revoke karna hai?')) return;
  const res = await fetch('/api/clients/revoke', { method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify({name}) });
  const data = await res.json();
  if(data.success){ loadClients(); }
  else { alert('Error: ' + data.error); }
}

function renderClients(clients){
  const el = document.getElementById('clients-container');
  if(!clients.length){ el.innerHTML = '<div class="empty">Koi client connected nahi hai</div>'; return; }
  let html = '<table><thead><tr><th>Name</th><th>Real IP</th><th>VPN IP</th><th>Data In</th><th>Data Out</th><th>Since</th></tr></thead><tbody>';
  clients.forEach(c => {
    html += `<tr><td>${deviceIcon(c.common_name)} ${esc(c.common_name)}</td><td>${esc(c.real_address)}</td><td>${esc(c.vpn_ip)}</td><td class="down">${mbFmt(c.bytes_received)}</td><td class="up">${mbFmt(c.bytes_sent)}</td><td>${esc(c.connected_since)}</td></tr>`;
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

const MAX_POINTS = 30;
const chartData = {
  labels: Array(MAX_POINTS).fill(''),
  datasets: [
    { label: 'tun0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#5eb4ff', backgroundColor: 'rgba(94,180,255,.12)', tension:.4, fill:true, pointRadius:0, borderWidth:2.5 },
    { label: 'tun0 ⬆ Up (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#f0a92c', backgroundColor: 'rgba(240,169,44,.1)', tension:.4, fill:true, pointRadius:0, borderWidth:2.5 },
    { label: 'eth0 ⬇ Down (KB/s)', data: Array(MAX_POINTS).fill(0), borderColor: '#3fdd78', backgroundColor: 'rgba(63,221,120,.04)', tension:.4, fill:false, pointRadius:0, borderWidth:1.5, borderDash:[4,4] },
  ]
};
const ctx = document.getElementById('bwChart').getContext('2d');
const bwChart = new Chart(ctx, {
  type: 'line',
  data: chartData,
  options: {
    responsive:true, maintainAspectRatio:false,
    animation: { duration: 300 },
    plugins: { legend: { labels: { color:'#dce3ea', font:{size:11, family:'Inter'}, usePointStyle:true, boxWidth:8 } } },
    scales: {
      x: { display:false },
      y: { beginAtZero:true, ticks:{ color:'#7c8b9e', font:{size:10, family:'JetBrains Mono'} }, grid:{ color:'rgba(255,255,255,.04)' } }
    }
  }
});
function pushChartPoint(tunDown, tunUp, ethDown){
  chartData.datasets[0].data.push(tunDown); chartData.datasets[0].data.shift();
  chartData.datasets[1].data.push(tunUp); chartData.datasets[1].data.shift();
  chartData.datasets[2].data.push(ethDown); chartData.datasets[2].data.shift();
  bwChart.update('none');
}

function connect(){
  const es = new EventSource('/api/stream');
  es.onopen = () => { document.getElementById('dot').classList.add('live'); document.getElementById('conn-status').textContent = 'Live'; };
  es.onerror = () => { document.getElementById('dot').classList.remove('live'); document.getElementById('conn-status').textContent = 'Reconnecting...'; es.close(); setTimeout(connect, 3000); };
  es.onmessage = (e) => {
    let d;
    try { d = JSON.parse(e.data); } catch(err){ return; }

    if(d.type === 'metrics'){
      animateNumber(document.getElementById('total-clients'), d.total_clients ?? 0, '');
      const t = d.tun0 || {};
      document.getElementById('tun-up').textContent = t.available ? kbps(t.upload_kbps) : 'N/A';
      document.getElementById('tun-down').textContent = t.available ? kbps(t.download_kbps) : 'N/A';
      document.getElementById('tun-up-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_sent_mb)}` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_recv_mb)}` : '';
      const eth = d.ethernet || {};
      document.getElementById('eth-up').textContent = eth.available ? kbps(eth.upload_kbps) : 'N/A';
      document.getElementById('eth-down').textContent = eth.available ? kbps(eth.download_kbps) : 'N/A';
      document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_sent_mb)}` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_recv_mb)}` : '';

      pushChartPoint(t.download_kbps||0, t.upload_kbps||0, eth.download_kbps||0);

      const sys = d.system || {};
      animateNumber(document.getElementById('cpu'), sys.cpu_percent ?? 0, '%');
      animateNumber(document.getElementById('ram'), sys.ram_percent ?? 0, '%');
      animateNumber(document.getElementById('disk'), sys.disk_percent ?? 0, '%');
      document.getElementById('cpu-bar').style.width = (sys.cpu_percent||0) + '%';
      document.getElementById('ram-bar').style.width = (sys.ram_percent||0) + '%';
      document.getElementById('disk-bar').style.width = (sys.disk_percent||0) + '%';
      document.getElementById('uptime').textContent = formatUptime(sys.uptime_secs ?? 0);

      renderClients(d.clients || []);
      document.getElementById('ts').textContent = 'Last update: ' + new Date(d.timestamp).toLocaleTimeString();
    } else if(d.type === 'connect'){
      addLog(`[CONNECT] ${d.common_name} from ${d.real_address}`, 'evt');
      showToast('connect', '🟢 Client Connected', d.common_name + ' — ' + d.real_address);
      loadClients();
    } else if(d.type === 'disconnect'){
      addLog(`[DISCONNECT] ${d.common_name}`, 'evt');
      showToast('disconnect', '⚪ Client Disconnected', d.common_name);
      loadClients();
    } else if(d.type === 'client_added'){
      addLog(`[CLIENT ADDED] ${d.name}`, 'evt');
      showToast('added', '➕ Client Added', d.name);
    } else if(d.type === 'client_revoked'){
      addLog(`[CLIENT REVOKED] ${d.name}`, 'evt');
      showToast('revoked', '🚫 Client Revoked', d.name);
    } else if(d.type === 'log'){
      addLog(d.message);
    }
  };
}

loadClients();
connect();
</script>
</body>
</html>
HTMLEOF

systemctl daemon-reload 
python3 app.py 
python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

# 1) CSS fix: prevent uptime wrapping, tighten alignment, consistent number size
old_css = """  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-top:2px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.35rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; }
  .sys-lbl { font-size:.68rem; color:var(--muted); margin-top:4px; font-weight:500; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; overflow:hidden; }"""

new_css = """  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:10px; margin-top:2px; }
  .sys-item { text-align:center; display:flex; flex-direction:column; align-items:center; }
  .sys-val { font-size:1.3rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; white-space:nowrap; line-height:1.1; height:1.5rem; display:flex; align-items:center; }
  .sys-lbl { font-size:.66rem; color:var(--muted); margin-top:8px; font-weight:500; text-transform:uppercase; letter-spacing:.04em; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; width:100%; overflow:hidden; }
  .bar-wrap.spacer { background:transparent; }"""

html = html.replace(old_css, new_css)

# 2) HTML fix: give the uptime item an invisible spacer bar so all 4 items align on the same baseline
old_html = '''      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>'''
new_html = '''      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="bar-wrap spacer"></div><div class="sys-lbl">Uptime</div></div>'''
html = html.replace(old_html, new_html)

with open(path, "w") as f:
    f.write(html)

print("Fixed: uptime no longer wraps, all 4 metrics now align on the same baseline.")
EOF

python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

# 1) CSS fix: prevent uptime wrapping, tighten alignment, consistent number size
old_css = """  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:14px; margin-top:2px; }
  .sys-item { text-align:center; }
  .sys-val { font-size:1.35rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; }
  .sys-lbl { font-size:.68rem; color:var(--muted); margin-top:4px; font-weight:500; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; overflow:hidden; }"""

new_css = """  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:10px; margin-top:2px; }
  .sys-item { text-align:center; display:flex; flex-direction:column; align-items:center; }
  .sys-val { font-size:1.3rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; white-space:nowrap; line-height:1.1; height:1.5rem; display:flex; align-items:center; }
  .sys-lbl { font-size:.66rem; color:var(--muted); margin-top:8px; font-weight:500; text-transform:uppercase; letter-spacing:.04em; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; width:100%; overflow:hidden; }
  .bar-wrap.spacer { background:transparent; }"""

html = html.replace(old_css, new_css)

# 2) HTML fix: give the uptime item an invisible spacer bar so all 4 items align on the same baseline
old_html = '''      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="sys-lbl">Uptime</div></div>'''
new_html = '''      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="bar-wrap spacer"></div><div class="sys-lbl">Uptime</div></div>'''
html = html.replace(old_html, new_html)

with open(path, "w") as f:
    f.write(html)

print("Fixed: uptime no longer wraps, all 4 metrics now align on the same baseline.")
EOF

python3 app.py 
cat > /opt/openvpn_dashboard/templates/dashboard.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenVPN Control Center</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<style>
  :root {
    --bg:#0a0e14; --card:#131a24; --card2:#161f2c; --border:#232d3d;
    --green:#3fdd78; --blue:#5eb4ff; --orange:#f0a92c; --red:#ff5c72; --purple:#b088ff; --cyan:#4ddbe8;
    --text:#dce3ea; --muted:#7c8b9e;
  }
  * { box-sizing:border-box; margin:0; padding:0; }
  body {
    background:
      radial-gradient(ellipse 900px 500px at 15% -10%, rgba(94,180,255,.10), transparent),
      radial-gradient(ellipse 900px 500px at 90% 10%, rgba(176,136,255,.08), transparent),
      var(--bg);
    color:var(--text); font-family:'Inter',system-ui,sans-serif; padding:28px; min-height:100vh;
  }
  ::-webkit-scrollbar { width:8px; height:8px; }
  ::-webkit-scrollbar-thumb { background:#2a3646; border-radius:4px; }
  ::-webkit-scrollbar-track { background:transparent; }

  header { display:flex; align-items:center; gap:14px; margin-bottom:28px; padding-bottom:20px; border-bottom:1px solid var(--border); }
  .logo-glow { width:38px; height:38px; border-radius:11px; background:linear-gradient(135deg,#5eb4ff,#b088ff); display:flex; align-items:center; justify-content:center; font-size:18px; box-shadow:0 0 24px rgba(94,180,255,.4); }
  header h1 { font-size:1.4rem; font-weight:800; background:linear-gradient(90deg,#fff,#9fb3c8); -webkit-background-clip:text; background-clip:text; color:transparent; letter-spacing:-.01em; }
  .dot { width:9px; height:9px; border-radius:50%; background:var(--red); box-shadow:0 0 8px var(--red); margin-left:auto; }
  .dot.live { background:var(--green); box-shadow:0 0 10px var(--green); animation:pulse 1.6s infinite; }
  @keyframes pulse { 0%,100%{opacity:1; transform:scale(1);} 50%{opacity:.5; transform:scale(1.3);} }
  .status-text { font-size:.78rem; color:var(--muted); font-weight:500; }

  .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(240px,1fr)); gap:16px; margin-bottom:18px; }
  .card {
    background:linear-gradient(165deg,var(--card2),var(--card));
    border:1px solid var(--border); border-radius:14px; padding:20px;
    position:relative; overflow:hidden;
    transition:transform .25s ease, box-shadow .25s ease, border-color .25s ease;
    animation:fadeUp .5s ease backwards;
  }
  .card::before { content:''; position:absolute; top:0; left:0; right:0; height:2px; background:var(--accent,linear-gradient(90deg,#5eb4ff,#b088ff)); opacity:.8; }
  .card:hover { transform:translateY(-3px); box-shadow:0 16px 40px rgba(0,0,0,.35); border-color:#2e3a4d; }
  .card.acc-blue { --accent:linear-gradient(90deg,#5eb4ff,#4ddbe8); }
  .card.acc-orange { --accent:linear-gradient(90deg,#f0a92c,#ff8a3d); }
  .card.acc-green { --accent:linear-gradient(90deg,#3fdd78,#4ddbe8); }
  .card.acc-purple { --accent:linear-gradient(90deg,#b088ff,#5eb4ff); }
  @keyframes fadeUp { from{ opacity:0; transform:translateY(14px);} to{ opacity:1; transform:translateY(0);} }

  .card-title { font-size:.7rem; text-transform:uppercase; letter-spacing:.1em; color:var(--muted); margin-bottom:14px; font-weight:600; display:flex; align-items:center; gap:6px; }
  .big-number { font-size:2.8rem; font-weight:800; color:#fff; line-height:1; letter-spacing:-.02em; }
  .sub-label { font-size:.78rem; color:var(--muted); margin-top:6px; }

  .bw-row { display:flex; justify-content:space-between; margin-top:8px; gap:10px; }
  .bw-box { flex:1; background:rgba(255,255,255,.02); border:1px solid var(--border); border-radius:10px; padding:12px 14px; }
  .bw-label { font-size:.68rem; color:var(--muted); font-weight:500; }
  .bw-val { font-size:1.25rem; font-weight:700; margin-top:4px; font-family:'JetBrains Mono',monospace; white-space:nowrap; }
  .bw-total { font-size:.7rem; color:var(--muted); margin-top:3px; font-family:'JetBrains Mono',monospace; }
  .up { color:var(--orange); } .down { color:var(--blue); }

  .sys-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:10px; margin-top:2px; }
  .sys-item { text-align:center; display:flex; flex-direction:column; align-items:center; }
  .sys-val { font-size:1.3rem; font-weight:700; color:#fff; font-family:'JetBrains Mono',monospace; white-space:nowrap; line-height:1.1; height:1.5rem; display:flex; align-items:center; }
  .sys-lbl { font-size:.66rem; color:var(--muted); margin-top:8px; font-weight:500; text-transform:uppercase; letter-spacing:.04em; }
  .bar-wrap { background:rgba(255,255,255,.04); border-radius:6px; height:5px; margin-top:8px; width:100%; overflow:hidden; }
  .bar-wrap.spacer { background:transparent; }
  .bar-fill { height:100%; border-radius:6px; transition:width .5s ease; }
  .bar-cpu { background:linear-gradient(90deg,#5eb4ff,#4ddbe8); } .bar-ram { background:linear-gradient(90deg,#f0a92c,#ff8a3d); } .bar-disk { background:linear-gradient(90deg,#b088ff,#e388ff); }

  /* Total data usage summary (replaces the chart) */
  .totals-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(200px,1fr)); gap:14px; margin-top:6px; }
  .total-box { background:rgba(255,255,255,.02); border:1px solid var(--border); border-radius:10px; padding:16px; text-align:center; }
  .total-box .t-icon { font-size:1.1rem; margin-bottom:6px; }
  .total-box .t-val { font-size:1.6rem; font-weight:800; font-family:'JetBrains Mono',monospace; color:#fff; }
  .total-box .t-lbl { font-size:.7rem; color:var(--muted); margin-top:4px; text-transform:uppercase; letter-spacing:.05em; }

  .section { background:linear-gradient(165deg,var(--card2),var(--card)); border:1px solid var(--border); border-radius:14px; padding:22px; margin-bottom:18px; animation:fadeUp .5s ease backwards; }
  .section .card-title { margin-bottom:16px; }

  table { width:100%; border-collapse:collapse; font-size:.84rem; }
  th { text-align:left; padding:10px; color:var(--muted); border-bottom:1px solid var(--border); font-weight:600; font-size:.68rem; text-transform:uppercase; letter-spacing:.06em; }
  td { padding:12px 10px; border-bottom:1px solid rgba(35,45,61,.6); }
  tr { transition:background .15s; }
  tr:hover td { background:rgba(255,255,255,.015); }
  tr:last-child td { border-bottom:none; }

  .empty { color:var(--muted); font-size:.85rem; padding:24px 0; text-align:center; }
  .device-icon { margin-right:6px; }

  #toast-container { position:fixed; top:22px; right:22px; z-index:9999; display:flex; flex-direction:column; gap:10px; }
  .toast { background:linear-gradient(165deg,var(--card2),var(--card)); border:1px solid var(--border); border-left:3px solid var(--blue); border-radius:10px; padding:13px 18px; min-width:250px; box-shadow:0 12px 32px rgba(0,0,0,.5); animation:slideIn .35s cubic-bezier(.2,.9,.3,1); font-size:.82rem; }
  .toast.connect { border-left-color:var(--green); }
  .toast.disconnect { border-left-color:var(--muted); }
  .toast .t-title { font-weight:700; color:#fff; margin-bottom:3px; font-size:.85rem; }
  .toast .t-sub { color:var(--muted); font-size:.73rem; font-family:'JetBrains Mono',monospace; }
  @keyframes slideIn { from{ transform:translateX(130%); opacity:0; } to{ transform:translateX(0); opacity:1; } }
  @keyframes fadeOut { to{ opacity:0; transform:translateX(40px); } }
</style>
</head>
<body>
<div id="toast-container"></div>

<header>
  <div class="logo-glow">🔒</div>
  <h1>OpenVPN Control Center</h1>
  <div class="dot" id="dot"></div>
  <span class="status-text" id="conn-status">Connecting...</span>
</header>

<div class="grid">
  <div class="card acc-blue" style="animation-delay:.02s">
    <div class="card-title">👥 Connected Clients</div>
    <div class="big-number" id="total-clients">0</div>
    <div class="sub-label">Active VPN connections</div>
  </div>
  <div class="card acc-blue" style="animation-delay:.06s">
    <div class="card-title">🔵 tun0 — VPN Tunnel</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="tun-up">—</div><div class="bw-total" id="tun-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="tun-down">—</div><div class="bw-total" id="tun-down-total"></div></div>
    </div>
  </div>
  <div class="card acc-orange" style="animation-delay:.1s">
    <div class="card-title">🟠 Ethernet</div>
    <div class="bw-row">
      <div class="bw-box"><div class="bw-label">⬆ Upload</div><div class="bw-val up" id="eth-up">—</div><div class="bw-total" id="eth-up-total"></div></div>
      <div class="bw-box"><div class="bw-label">⬇ Download</div><div class="bw-val down" id="eth-down">—</div><div class="bw-total" id="eth-down-total"></div></div>
    </div>
  </div>
  <div class="card acc-purple" style="animation-delay:.14s">
    <div class="card-title">⚙️ System Health</div>
    <div class="sys-grid">
      <div class="sys-item"><div class="sys-val" id="cpu">0%</div><div class="bar-wrap"><div class="bar-fill bar-cpu" id="cpu-bar" style="width:0%"></div></div><div class="sys-lbl">CPU</div></div>
      <div class="sys-item"><div class="sys-val" id="ram">0%</div><div class="bar-wrap"><div class="bar-fill bar-ram" id="ram-bar" style="width:0%"></div></div><div class="sys-lbl">RAM</div></div>
      <div class="sys-item"><div class="sys-val" id="disk">0%</div><div class="bar-wrap"><div class="bar-fill bar-disk" id="disk-bar" style="width:0%"></div></div><div class="sys-lbl">Disk</div></div>
      <div class="sys-item"><div class="sys-val" id="uptime">—</div><div class="bar-wrap spacer"></div><div class="sys-lbl">Uptime</div></div>
    </div>
  </div>
</div>

<div class="section acc-green" style="animation-delay:.18s">
  <div class="card-title">💾 Total Data Usage</div>
  <div class="totals-grid">
    <div class="total-box"><div class="t-icon">🔵⬆</div><div class="t-val" id="tot-tun-up">—</div><div class="t-lbl">tun0 Upload</div></div>
    <div class="total-box"><div class="t-icon">🔵⬇</div><div class="t-val" id="tot-tun-down">—</div><div class="t-lbl">tun0 Download</div></div>
    <div class="total-box"><div class="t-icon">🟠⬆</div><div class="t-val" id="tot-eth-up">—</div><div class="t-lbl">Ethernet Upload</div></div>
    <div class="total-box"><div class="t-icon">🟠⬇</div><div class="t-val" id="tot-eth-down">—</div><div class="t-lbl">Ethernet Download</div></div>
  </div>
</div>

<div class="section" style="animation-delay:.22s">
  <div class="card-title">📊 Client Details (Live Usage)</div>
  <div id="clients-container"><div class="empty">Koi client connected nahi hai</div></div>
</div>

<script>
function showToast(type, title, sub){
  const c = document.getElementById('toast-container');
  const el = document.createElement('div');
  el.className = 'toast ' + type;
  el.innerHTML = `<div class="t-title">${title}</div><div class="t-sub">${sub||''}</div>`;
  c.appendChild(el);
  setTimeout(() => { el.style.animation = 'fadeOut .4s forwards'; setTimeout(()=>el.remove(), 400); }, 4000);
}

function animateNumber(el, newVal, suffix){
  suffix = suffix || '';
  const current = parseFloat(el.dataset.val || '0');
  const target = parseFloat(newVal) || 0;
  const steps = 12;
  let step = 0;
  clearInterval(el._timer);
  el._timer = setInterval(() => {
    step++;
    const val = current + (target - current) * (step/steps);
    el.textContent = (suffix === '%' ? Math.round(val) : val.toFixed(0)) + suffix;
    if(step >= steps){ clearInterval(el._timer); el.textContent = Math.round(target) + suffix; }
  }, 25);
  el.dataset.val = target;
}

function deviceIcon(name){
  const n = (name||'').toLowerCase();
  if(n.includes('phone') || n.includes('mobile') || n.includes('android') || n.includes('iphone')) return '📱';
  if(n.includes('laptop') || n.includes('macbook')) return '💻';
  if(n.includes('desktop') || n.includes('pc')) return '🖥️';
  if(n.includes('server')) return '🖧';
  return '🔑';
}

function kbps(v){
  v = v || 0;
  if(v >= 1048576) return (v/1048576).toFixed(2)+' GB/s';
  if(v >= 1024) return (v/1024).toFixed(2)+' MB/s';
  return v.toFixed(1)+' KB/s';
}
function mbFmt(b){
  b = parseInt(b||0);
  if(b >= 1073741824) return (b/1073741824).toFixed(2)+' GB';
  if(b >= 1048576) return (b/1048576).toFixed(2)+' MB';
  if(b >= 1024) return (b/1024).toFixed(1)+' KB';
  return b+' B';
}
function fmtMbGb(mb){
  mb = parseFloat(mb || 0);
  if(mb >= 1024) return (mb/1024).toFixed(2)+' GB';
  return mb.toFixed(1)+' MB';
}
function formatUptime(s){ const h=Math.floor(s/3600), m=Math.floor((s%3600)/60); return `${h}h ${m}m`; }
function esc(s){ return String(s).replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

function renderClients(clients){
  const el = document.getElementById('clients-container');
  if(!clients.length){ el.innerHTML = '<div class="empty">Koi client connected nahi hai</div>'; return; }
  let html = '<table><thead><tr><th>Name</th><th>Real IP</th><th>VPN IP</th><th>Data In</th><th>Data Out</th><th>Since</th></tr></thead><tbody>';
  clients.forEach(c => {
    html += `<tr><td>${deviceIcon(c.common_name)} ${esc(c.common_name)}</td><td>${esc(c.real_address)}</td><td>${esc(c.vpn_ip)}</td><td class="down">${mbFmt(c.bytes_received)}</td><td class="up">${mbFmt(c.bytes_sent)}</td><td>${esc(c.connected_since)}</td></tr>`;
  });
  html += '</tbody></table>';
  el.innerHTML = html;
}

function connect(){
  const es = new EventSource('/api/stream');
  es.onopen = () => { document.getElementById('dot').classList.add('live'); document.getElementById('conn-status').textContent = 'Live'; };
  es.onerror = () => { document.getElementById('dot').classList.remove('live'); document.getElementById('conn-status').textContent = 'Reconnecting...'; es.close(); setTimeout(connect, 3000); };
  es.onmessage = (e) => {
    let d;
    try { d = JSON.parse(e.data); } catch(err){ return; }

    if(d.type === 'metrics'){
      animateNumber(document.getElementById('total-clients'), d.total_clients ?? 0, '');
      const t = d.tun0 || {};
      document.getElementById('tun-up').textContent = t.available ? kbps(t.upload_kbps) : 'N/A';
      document.getElementById('tun-down').textContent = t.available ? kbps(t.download_kbps) : 'N/A';
      document.getElementById('tun-up-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_sent_mb)}` : '';
      document.getElementById('tun-down-total').textContent = t.available ? `Total: ${fmtMbGb(t.total_recv_mb)}` : '';
      document.getElementById('tot-tun-up').textContent = t.available ? fmtMbGb(t.total_sent_mb) : '—';
      document.getElementById('tot-tun-down').textContent = t.available ? fmtMbGb(t.total_recv_mb) : '—';

      const eth = d.ethernet || {};
      document.getElementById('eth-up').textContent = eth.available ? kbps(eth.upload_kbps) : 'N/A';
      document.getElementById('eth-down').textContent = eth.available ? kbps(eth.download_kbps) : 'N/A';
      document.getElementById('eth-up-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_sent_mb)}` : '';
      document.getElementById('eth-down-total').textContent = eth.available ? `Total: ${fmtMbGb(eth.total_recv_mb)}` : '';
      document.getElementById('tot-eth-up').textContent = eth.available ? fmtMbGb(eth.total_sent_mb) : '—';
      document.getElementById('tot-eth-down').textContent = eth.available ? fmtMbGb(eth.total_recv_mb) : '—';

      const sys = d.system || {};
      animateNumber(document.getElementById('cpu'), sys.cpu_percent ?? 0, '%');
      animateNumber(document.getElementById('ram'), sys.ram_percent ?? 0, '%');
      animateNumber(document.getElementById('disk'), sys.disk_percent ?? 0, '%');
      document.getElementById('cpu-bar').style.width = (sys.cpu_percent||0) + '%';
      document.getElementById('ram-bar').style.width = (sys.ram_percent||0) + '%';
      document.getElementById('disk-bar').style.width = (sys.disk_percent||0) + '%';
      document.getElementById('uptime').textContent = formatUptime(sys.uptime_secs ?? 0);

      renderClients(d.clients || []);
    } else if(d.type === 'connect'){
      showToast('connect', '🟢 Client Connected', d.common_name + ' — ' + d.real_address);
    } else if(d.type === 'disconnect'){
      showToast('disconnect', '⚪ Client Disconnected', d.common_name);
    }
  };
}

connect();
</script>
</body>
</html>
HTMLEOF

python3 app.py 
python3 << 'EOF'
import re
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

replacements = [
    ('⬆ Upload', 'Up ↑ Upload'),
    ('⬇ Download', 'Down ↓ Download'),
    ('🔵⬆', '🔵 Up'),
    ('🔵⬇', '🔵 Down'),
    ('🟠⬆', '🟠 Up'),
    ('🟠⬇', '🟠 Down'),
]

for old, new in replacements:
    html = html.replace(old, new)

with open(path, "w") as f:
    f.write(html)

print("Arrows replaced with Up/Down text labels.")
EOF

python3 app.py 
cat > /etc/systemd/system/openvpn-dashboard.service << 'EOF'
[Unit]
Description=OpenVPN Dashboard (Flask + SSE)
After=network.target openvpn-server@server.service

[Service]
Type=simple
User=root
WorkingDirectory=/opt/openvpn_dashboard
ExecStart=/usr/bin/python3 /opt/openvpn_dashboard/app.py
Restart=always
RestartSec=3
StandardOutput=append:/var/log/openvpn_dashboard.log
StandardError=append:/var/log/openvpn_dashboard_error.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload 
systemctl enable openvpn-dashboard.service 
systemctl start openvpn-dashboard.service 
curl https://raw.githubusercontent.com/complexorganizations/wireguard-manager/main/wireguard-manager.sh --create-dirs -o /usr/local/bin/wireguard-manager.sh
chmod +x /usr/local/bin/wireguard-manager.sh
bash /usr/local/bin/wireguard-manager.sh
systemctl status openvpn-dashboard.service
systemctl restart openvpn-dashboard.service   # code update ke baad restart
systemctl stop openvpn-dashboard.service      # rokna ho to
journalctl -u openvpn-dashboard.service -f    # live logs dekhna
python3 app.py 
cat > /etc/systemd/system/openvpn-dashboard.service << 'EOF'
[Unit]
Description=OpenVPN Dashboard (Flask + SSE)
After=network.target openvpn-server@server.service

[Service]
Type=simple
User=root
WorkingDirectory=/opt/openvpn_dashboard
ExecStart=/usr/bin/python3 /opt/openvpn_dashboard/app.py
Restart=always
RestartSec=3
StandardOutput=append:/var/log/openvpn_dashboard.log
StandardError=append:/var/log/openvpn_dashboard_error.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable openvpn-dashboard.service
systemctl start openvpn-dashboard.service
python3 << 'EOF'
path = "/opt/openvpn_dashboard/templates/dashboard.html"
with open(path) as f:
    html = f.read()

html = html.replace(
    '<th>Data In</th><th>Data Out</th>',
    '<th>Download</th><th>Upload</th>'
)

with open(path, "w") as f:
    f.write(html)

print("Column headers updated: Download / Upload")
EOF

systemctl daemon-reload
systemctl enable openvpn-dashboard.service
systemctl start openvpn-dashboard.service
systemctl restart openvpn-dashboard.service
bash /usr/local/bin/wireguard-manager.sh
sudo apt-get update -y && sudo apt install wireguard-tools net-tools --no-install-recommends -y && git clone https://github.com/WGDashboard/WGDashboard.git && cd ./WGDashboard/src && chmod +x ./wgd.sh && ./wgd.sh install && sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf && sudo sysctl -p /etc/sysctl.conf
[200~sudo apt-get update -y && sudo apt install wireguard-tools net-tools --no-install-recommends -y && git clone https://github.com/WGDashboard/WGDashboard.git && cd ./WGDashboard/src && chmod +x ./wgd.sh && ./wgd.sh install && sudo echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf && sudo sysctl -p /etc/sysctl.conf~
bash /usr/local/bin/wireguard-manager.sh
echo "===== WireGuard interfaces currently up ====="
wg show
echo "===== Is wg0 interface listed at all (even down)? ====="
ip link show wg0
echo "===== wg0.conf exists? ====="
ls -la /etc/wireguard/
echo "===== Try bringing wg0 up manually ====="
wg-quick up wg0
echo "===== Check systemd service for wg-quick@wg0 ====="
systemctl status wg-quick@wg0 --no-pager
echo "===== Kernel module loaded? ====="
lsmod | grep wireguard
modinfo wireguard 2>&1 | head -5
cat -n /etc/wireguard/wg0.conf
sed -i 's#Address = 12.0.0.1/12.0.0.0#Address = 12.0.0.1/24#' /etc/wireguard/wg0.conf
# Verify
grep "Address" /etc/wireguard/wg0.conf
# Ab try karain
wg-quick up wg0
systemctl enable wg-quick@wg0
systemctl restart wg-quick@wg0
systemctl status wg-quick@wg0 --no-pager
wg show
# Pehle backup le lain (safety ke liye)
cp /etc/wireguard/wg0.conf /etc/wireguard/wg0.conf.bak
# Fix apply karain
sed -i 's#Address = 12.0.0.1/12.0.0.0,fd00:00:00::1/8#Address = 12.0.0.1/8,fd00:00:00::1/8#' /etc/wireguard/wg0.conf
# Verify
grep "^Address" /etc/wireguard/wg0.conf
wg-quick up wg0
systemctl enable wg-quick@wg0
systemctl status wg-quick@wg0 --no-pager
wg show
# Pehle interface neechay le ke aayen (clean state)
wg-quick down wg0
# Ab systemd ke through properly start karain (taake service status bhi "active" ho)
systemctl restart wg-quick@wg0
# Verify
systemctl status wg-quick@wg0 --no-pager
wg show
bash /usr/local/bin/wireguard-manager.sh
echo "===== Check for WireGuard install script ====="
find / -iname "*wireguard-install*" 2>/dev/null
find / -iname "*wg-install*" 2>/dev/null
echo "===== Check installed packages ====="
dpkg -l | grep -i wireguard
echo "===== WGDashboard location + how it was installed ====="
find / -iname "wgd.sh" 2>/dev/null
find / -iname "WGDashboard" -type d 2>/dev/null
ls -la /root/ | grep -i wg
echo "===== Current existing peers (save this info before deleting!) ====="
cat -n /etc/wireguard/wg0.conf
sudo apt purge wireguard 
curl https://raw.githubusercontent.com/complexorganizations/wireguard-manager/main/wireguard-manager.sh --create-dirs -o /usr/local/bin/wireguard-manager.sh
chmod +x /usr/local/bin/wireguard-manager.sh
bash /usr/local/bin/wireguard-manager.sh
curl https://raw.githubusercontent.com/complexorganizations/wireguard-manager/main/wireguard-manager.sh --create-dirs -o /usr/local/bin/wireguard-manager.sh
chmod +x /usr/local/bin/wireguard-manager.sh
bash /usr/local/bin/wireguard-manager.sh
cd ..
cd
cd easy-rsa
cd ..
nano /opt/dashboard_server.py
nano /opt/dashboard/dashboard_server,py 
wg show 
cat /etc/wireguard/wg0.cong
sudo cat /etc/wireguard/wg0.conf
sudo nano /etc/wireguard/manager_config.json
cat /etc/wireguard/manager_config.json
conda activate cypher
pip install flask flask-cors
pip3 install flask flask-cors
conda env list
conda activate cypher 
sudo apt instal conda
sudo apt install conda
sudo apt update
sudo apt install python3-pip python3-venv -y
cd /etc/wireguard
sudo python3 -m venv wg-api-env
sudo /etc/wireguard/wg-api-env/bin/pip install flask flask-cors
sudo nano /etc/wireguard/wg_api.py
rm /etc/wireguard/wg_api.py 
sudo nano /etc/wireguard/wg_api.py
cat /etc/wireguard/wg_api.py | wc -l
sudo /etc/wireguard/wg-api-env/bin/python3 /etc/wireguard/wg_api.py
[200~curl "http://127.0.0.1:5002/health"~
curl "http://127.0.0.1:5002/health"
sudo /etc/wireguard/wg-api-env/bin/python3 /etc/wireguard/wg_api.py
echo $?
curl "http://127.0.0.1:5002/health"
curl "http://127.0.0.1:5002/wg-config?name=phone1" -o phone1.conf
cat phone1.conf
whoami
hostname
cd /etc/wireguard
sudo nohup /etc/wireguard/wg-api-env/bin/python3 wg_api.py > wg_api.log 2>&1 &
ps aux | grep wg_api.py
curl "http://127.0.0.1:5002/health"
curl "http://127.0.0.1:5002/wg-config?name=phone1" -o phone1.conf
cat phone1.conf
wg show 
sudo /etc/wireguard/wg-api-env/bin/pip install qrcode[pil]
sudo kill 141251
sudo nano /etc/wireguard/wg_api.py
rm /etc/wireguard/w_api.py 
rm -rf /etc/wirguard/wg_api.py
sudo nano /etc/wireguard/wg_api.py
sudo rm /etc/wireguard/wg_api.py 
sudo nano /etc/wireguard/wg_api.py
cd /etc/wireguard
sudo nohup /etc/wireguard/wg-api-env/bin/python3 wg_api.py > wg_api.log 2>&1 &
curl "http://127.0.0.1:5002/health"
curl "http://127.0.0.1:5002/wg-config?name=phone2&format=qr" -o phone2_qr.png
ls -lh phone2_qr.png
file phone2_qr.png
wg show 
curl "http://127.0.0.1:5002/wg-config?name=laptop1" -o laptop1.conf
curl "http://127.0.0.1:5002/wg-config?name=phone-wife" -o phone-wife.conf
curl "http://127.0.0.1:5002/wg-config?name=tablet1" -o tablet1.conf
http://152.42.241.74:5002/wg-config?name=laptop1
