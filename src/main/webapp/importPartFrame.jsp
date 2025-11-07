<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.garaman.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    String role = user.getRole().name();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Import Spare Parts</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background: #f5f7fa; }
        .header { background: #007BFF; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { margin: 0; }
        .user-info { display: flex; align-items: center; gap: 15px; }
        .badge { display: inline-block; padding: 5px 10px; background: #ffc107; color: #333; border-radius: 12px; font-size: 12px; font-weight: bold; margin-left: 10px;}
        .logout-btn { padding: 8px 15px; background: #dc3545; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }

        .container { max-width: 1000px; margin: 28px auto; padding: 0 16px; }
        .card { background: #fff; border-radius: 10px; border: 2px solid #007BFF; padding: 20px; }

        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
        .block { background: #fff; border: 1px solid #007BFF33; border-radius: 8px; padding: 18px; }
        .row-2col { display: grid; grid-template-columns: 1fr 1fr; align-items: center; gap: 10px; margin-bottom: 12px; }
        .row { display: grid; grid-template-columns: 90px 1fr; align-items: center; gap: 10px; margin-bottom: 12px; }
        .row label { font-weight: bold; }
        .note { background: #eef2ff; color: #374151; padding: 6px 10px; border-radius: 8px; display: inline-block; }

        input[type="text"], input[type="number"] {
            width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box;
        }

        .inline { display: flex; gap: 10px; align-items: center; }
        .inline .w-100 { flex: 1 1 auto; }
        .inline .w-180 { width: 180px; }

        .btn { padding: 10px 16px; background: #0d6efd; color: #fff; border: none; border-radius: 6px; cursor: pointer; text-decoration: none; }
        .btn:hover { background: #0b5ed7; }
        .btn-green { background: #28a745; }
        .btn-green:hover { background: #218838; }
        .btn-outline { background: transparent; color: #28a745; border: 1px solid #28a745; white-space: nowrap;}
        .btn-outline:hover {background: #28a745; color: #fff}
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #bb2d3b; }

        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        table td:last-child {
            text-align: center;
        }
        th, td { border: 1px solid #e5e7eb; padding: 7px; text-align: left; }
        th { background: #f8fafc; }
        .text-right { text-align: right; }

        .disabled { opacity: .6; pointer-events: none; }

        /* Searchable dropdown */
        .searchable-select { position: relative; width: 100%; }
        .ss-display {
            border: 1px solid #ccc; border-radius: 6px; padding: 10px;
            background: #fff; cursor: pointer; display: flex; justify-content: space-between; align-items: center;
        }
        .ss-display .arrow { margin-left: 8px; color: #666; }
        .ss-panel {
            position: absolute; left: 0; right: 0; top: calc(100% + 4px);
            background: #fff; border: 1px solid #ccc; border-radius: 6px;
            box-shadow: 0 8px 24px rgba(0,0,0,.12);
            display: none; z-index: 20;
        }
        .ss-panel.open { display: block; }
        .ss-search {
            width: 100%; padding: 8px 10px; border: 0; border-bottom: 1px solid #eee; outline: none; box-sizing: border-box;
        }
        .ss-list { max-height: 240px; overflow: auto; list-style: none; margin: 0; padding: 0; }
        .ss-list li { padding: 10px 12px; cursor: pointer; }
        .ss-list li:hover, .ss-list li.active { background: #f0f6ff; }
        .muted { color: #6b7280; font-size: 12px; }
    </style>
</head>
<body>
<div class="header">
    <h1>🚗 GaraMan System</h1>
    <div class="user-info">
        <span><b><%= user.getFullName() %></b> <span class="badge"><%= role %></span></span>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </div>
</div>

<div class="container">
    <div class="card">
        <h2 style="color:#007BFF; margin-top:0;">Import Spare Parts</h2>

        <div class="form-grid">
            <div class="block" id="chooseSupplierBlock">
                <div class="row">
                    <label>Import Date</label>
                    <div class="note" id="importDate"></div>
                    <div></div>
                </div>

                <div class="row">
                    <label>Supplier</label>
                    <div class="w-100 inline">
                        <div class="searchable-select" id="ddSupplier" data-placeholder="-- Select Supplier --">
                            <input type="hidden" id="supplierId" value="">
                            <div class="ss-display"><span class="text">-- Select Supplier --</span><span class="arrow">▾</span></div>
                            <div class="ss-panel">
                                <input class="ss-search" type="text" placeholder="Type to filter suppliers...">
                                <ul class="ss-list">
                                    <li data-value="">-- Select Supplier --</li>
                                    <c:forEach var="s" items="${suppliers}">
                                        <li data-value="${s.idSupplier}" data-name="${s.name}">${s.name}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <button class="btn btn-outline" style="width: 100%; margin-top: 10px" type="button" onclick="location.href='addSupplier'">+ Add Supplier</button>
            </div>

            <div class="block" id="choosePartBlock">
                <div class="row">
                    <label>Spare Part</label>
                    <div class="w-100 inline">
                        <div class="searchable-select" id="ddPart" data-placeholder="-- Select Part --">
                            <input type="hidden" id="partId" value="">
                            <div class="ss-display"><span class="text">-- Select Part --</span><span class="arrow">▾</span></div>
                            <div class="ss-panel">
                                <input class="ss-search" type="text" placeholder="Type to filter spare parts...">
                                <ul class="ss-list">
                                    <li data-value="">-- Select Part --</li>
                                    <c:forEach var="p" items="${parts}">
                                        <li data-value="${p.idPart}" data-name="${p.name}" data-unit="${p.unitPrice}">${p.name}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <button class="btn btn-outline" type="button" onclick="location.href='addPart'">+ Add Part</button>
                    </div>
                </div>
                <div class="row-2col">
                    <div>
                        <label>Quantity</label>
                        <input id="qty" type="number" min="1" value="1" />
                    </div>
                    <div>
                        <label>Unit Price</label>
                        <input id="unitPrice" type="number" placeholder="Enter unit price" />
                    </div>
                </div>
                <button class="btn w-100" type="button" onclick="addToList()">Add to List</button>
                <button class="btn btn-danger w-100" type="button" onclick="rollbackSupplier()" style="margin-left: 10px">Choose supplier again</button>
            </div>
        </div>
<%--        <hr style="margin: 16px 0; border: 0; border-top: 1px dashed #cbd5e1;">--%>
        <div id="importListBlock">
            <h3 style="margin-top: 6px;">Import List</h3>
            <table id="listTable">
                <thead>
                <tr>
                    <th style="width:90px;">Part ID</th>
                    <th>Part Name</th>
                    <th style="width:100px;">Quantity</th>
                    <th style="width:140px;">Unit Price</th>
                    <th style="width:140px;">Total(đ)</th>
                    <th style="width:90px;">Action</th>
                </tr>
                </thead>
                <tbody></tbody>
                <tfoot>
                <tr>
                    <th colspan="4" class="text-right">Grand Total</th>
                    <th id="grandTotal" class="text-right">0</th>
                    <th></th>
                </tr>
                </tfoot>
            </table>
        </div>
            <div class="inline" style="margin-top: 14px;">
                <button id="btnConfirm" class="btn btn-green w-100 disabled" type="button" onclick="confirmImport()" disabled>Confirm Import</button>
                <button class="btn btn-danger w-100" type="button" onclick="history.back()">Back</button>
            </div>
            <div class="muted">Note: Select Supplier first to enable spare part inputs.</div>
    </div>
</div>

<script>
    // Hiển thị ngày
    document.getElementById('importDate').textContent = new Date().toISOString().slice(0,10);

    // Component: Searchable Select
    function createSearchableSelect(containerId) {
        const el = document.getElementById(containerId);
        const hidden = el.querySelector('input[type="hidden"]');
        const display = el.querySelector('.ss-display .text');
        const arrow = el.querySelector('.ss-display .arrow');
        const panel = el.querySelector('.ss-panel');
        const search = el.querySelector('.ss-search');
        const list = el.querySelector('.ss-list');
        const placeholder = el.dataset.placeholder || 'Select...';

        display.textContent = placeholder;

        function open() {
            panel.classList.add('open');
            search.value = '';
            filter('');
            setTimeout(() => search.focus(), 0);
        }
        function close() { panel.classList.remove('open'); }
        function toggle() { panel.classList.toggle('open'); if (panel.classList.contains('open')) { search.value=''; filter(''); setTimeout(()=>search.focus(), 0); } }

        function filter(q) {
            const term = q.trim().toLowerCase();
            list.querySelectorAll('li').forEach(li => {
                const t = li.textContent.toLowerCase();
                li.style.display = t.includes(term) ? '' : 'none';
            });
        }
        function setSelected(li) {
            hidden.value = li.dataset.value || '';
            display.textContent = li.textContent || placeholder;
            el.dispatchEvent(new CustomEvent('change', { detail: { value: hidden.value, label: display.textContent, dataset: li.dataset } }));
        }

        el.querySelector('.ss-display').addEventListener('click', toggle);
        search.addEventListener('input', e => filter(e.target.value));
        list.addEventListener('click', e => {
            const li = e.target.closest('li'); if (!li) return;
            setSelected(li);
            close();
        });
        document.addEventListener('click', e => { if (!el.contains(e.target)) close(); });

        // API
        return {
            el,
            getValue: () => hidden.value,
            getSelectedData: () => {
                const id = hidden.value;
                const items = Array.from(list.children);
                const li = items.find(x => (x.dataset.value || '') === id);
                return li ? li.dataset : {};
            },
            setByValue: (v) => {
                const items = Array.from(list.children);
                const li = items.find(x => (x.dataset.value || '') === String(v));
                if (li) setSelected(li);
            },
            open, close
        };
    }

    const ddSupplier = createSearchableSelect('ddSupplier');
    const ddPart = createSearchableSelect('ddPart');

    const chooseSupplierBlock = document.getElementById('chooseSupplierBlock');
    const choosePartBlock = document.getElementById('choosePartBlock');
    const importListBlock = document.getElementById('importListBlock');
    const btnConfirm = document.getElementById('btnConfirm');
    function onSupplierChanged() {
        const enabled = ddSupplier.getValue() !== '';
        chooseSupplierBlock.classList.toggle('disabled', enabled)
        choosePartBlock.classList.toggle('disabled', !enabled);
        importListBlock.classList.toggle('disabled', !enabled);
        recalcConfirmEnabled();
    }

    function rollbackSupplier(){
        if (confirm("Dữ liệu đã nhập sẽ mất, xác nhận chọn nhà cung cấp khác?")) {
            location.href='importPart'
        }
    }
    ddSupplier.el.addEventListener('change', onSupplierChanged);

    // Khi chọn Part thì tự fill Unit Price nếu có data-unit
    ddPart.el.addEventListener('change', (e) => {
        const data = ddPart.getSelectedData();
        if (data && data.unit) document.getElementById('unitPrice').value = data.unit;
    });

    // Danh sách nhập
    const list = [];
    function addToList() {
        if (!ddSupplier.getValue()) { alert('Please select a supplier first.'); return; }
        const partId = ddPart.getValue();
        if (!partId) { alert('Please choose a spare part.'); return; }

        const data = ddPart.getSelectedData();
        const partName = data.name || '';
        const qty = parseInt(document.getElementById('qty').value, 10);
        const unit = parseInt(document.getElementById('unitPrice').value);

        if (!(qty > 0)) { alert('Quantity must be > 0'); return; }
        if (isNaN(unit)) { alert('Unit price is required.'); return; }

        const existed = list.find(it => it.part.idPart == partId && it.unitCost == unit);
        if (existed) existed.quantity += qty;
        else list.push({ part: { idPart: parseInt(partId, 10), name: partName }, quantity: qty, unitCost: unit });

        renderList();
        document.getElementById('qty').value = 1;
    }

    const tableBody = document.querySelector('#listTable tbody');
    const grandTotalEl = document.getElementById('grandTotal');

    function removeAt(idx) { list.splice(idx,1); renderList(); }
    function renderList() {
        tableBody.innerHTML = "";
        let sum = 0;
        list.forEach((d, i) => {
            const tr = document.createElement('tr');
            const total = d.quantity * d.unitCost;
            var html =
                '<td>' + d.part.idPart + '</td>\n' +
                '<td>' + d.part.name + '</td>\n' +
                '<td class="text-right">' + d.quantity + '</td>\n' +
                '<td class="text-right">' + d.unitCost + '</td>\n' +
                '<td class="text-right">' + total + '</td>\n' +
                '<td><button class="btn btn-danger" type="button" onclick="removeAt(' + i + ')">Delete</button></td>';
            tr.innerHTML = html;
            tableBody.appendChild(tr);
            sum += total;
        });
        grandTotalEl.textContent = sum;
        recalcConfirmEnabled();
    }
    function recalcConfirmEnabled() {
        var isImported = ddSupplier.getValue() && list.length > 0;
        btnConfirm.disabled = !isImported;
        btnConfirm.classList.toggle('disabled', !isImported)
    }

    function confirmImport() {
        if (btnConfirm.disabled) return;

        const mapped = list.map(d => ({
            part: { idPart: d.part.idPart, name: d.part.name },
            quantity: d.quantity,
            unitCost: d.unitCost
        }));

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = 'purchaseReceipt';

        const inp1 = document.createElement('input');
        inp1.type = 'hidden'; inp1.name = 'supplierId'; inp1.value = ddSupplier.getValue(); form.appendChild(inp1);

        const inp2 = document.createElement('input');
            inp2.type = 'hidden'; inp2.name = 'details'; inp2.value = JSON.stringify(mapped); form.appendChild(inp2);

        const inp3 = document.createElement('input');
        inp3.type = 'hidden'; inp3.name = 'staffId'; inp3.value = '<%= String.valueOf(session.getAttribute("userId")) %>'; form.appendChild(inp3);

        document.body.appendChild(form);
        form.submit();
    }

    // Gán vào scope global để nút dùng
    window.addToList = addToList;
    window.confirmImport = confirmImport;

    // init
    onSupplierChanged();
</script>
</body>
</html>