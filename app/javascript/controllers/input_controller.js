import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'table', 'tableRow', 'input', 'number', 'tableBody', 'reading' ]

  connect() {
    this.initIDB();

    if (this.data.has('refreshInterval')) {
      this.sync();
    }
  }

  sync() {
    this.refreshTimer = setInterval(() => {
      this.save()
    },this.data.get('refreshInterval'))
  }

  save() {
    this.checkDB();
    var data = this.getTableData();
    var res = new XMLHttpRequest();
    var token = document.getElementsByName('csrf-token')[0];
    res.open('POST', '/readings', true);
    res.setRequestHeader("Content-Type", "application/json");
    res.setRequestHeader('X-CSRF-Token', token.content);
    res.send(data);
  }

  getTableData() {
    var data = [];
    var self = this;
    this.tableRowTargets.forEach(function(tr) {
      var row = {session_id: self.data.get('session_id')};
      for (var i = 0; i < tr.childElementCount; i++) {
        row[tr.children[i].dataset.name] = tr.children[i].innerText
      }
      data.push(row);
    });
    return JSON.stringify({reading: {session_id: self.data.get('session_id'), readings: data}});
  }

  disconnect() {
    this.stopRefreshing()
  }

  stopRefreshing() {
    if (this.refreshTimer) {
      clearInterval(this.refreshTimer)
    }
  }

  form(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      this.data.set('id', this.numberTarget.value);
      this.tableRow(this.getInputData())
      this.sortRows();
      this.nextInput(event);
      this.saveAllData();
    }
  }

  initIDB() {
    var self = this;
    var request = indexedDB.open("records");

    request.onupgradeneeded = function() {
      // The database did not previously exist, so create object stores and indexes.
      self.db = request.result;
      var store = self.db.createObjectStore("readings", {keyPath: "number"});
      var numberIndex = store.createIndex("by_number", "number", {unique: true});
    };

    request.onsuccess = function() {
      self.db = request.result;
      self.checkDB();
    };
  }

  saveData(row) {
    var data = {};
    data['updated_at'] = row.dataset.updated_at;
    for (var i = 0; i < row.children.length; i++) {
      data[row.children[i].dataset.name] = row.children[i].innerText
    }
    var tx = this.db.transaction('readings', 'readwrite');
    var store = tx.objectStore('readings');
    store.put(data);
    tx.oncomplete = function() {
    };
  }

  checkDB() {
    var self = this;
    var tx = this.db.transaction('readings', 'readwrite');
    var store = tx.objectStore('readings');
    var index = store.index('by_number');

    var request = index.openCursor().onsuccess = function(event) {
      var cursor = event.target.result;
      if (cursor) {
        self.data.set('id', cursor.key);
        self.checkLastUpdated(cursor.value);
        cursor.continue();
      }
    }
  }

  checkLastUpdated(data) {
    var tr = document.getElementById(data['number'])
    if (tr == null || tr.dataset.updated_at == data['updated_at']) {
      return
    }
    if (tr.dataset.updated_at > data['updated_at']) {
      this.saveData(tr)
    }else{
      this.updateRow(data, true);
    }
    this.sortRows();
  }

  getTargets() {
    return this.inputTargets;
  }

  checkId(arr) {
    var id = this.data.get('id');
    return arr.findIndex(function(ele) { 
      return ele.id == id
    });
  }

  updateRow(data, force=false) {
    var tr = document.getElementById(data['number'])
    tr = this.updateRowChildren(tr, data, force);
    tr.dataset.updated_at = Math.round(Date.now() / 1000);
    this.tableBodyTarget.appendChild(tr);
  }

  updateRowChildren(tr, data, force=false) {
    var self = this;
    var reading = tr.querySelectorAll('[data-name=readings]')[0]
    var number = tr.querySelectorAll('[data-name=number]')[0]
    var car_class = tr.querySelectorAll('[data-name=car_class]')[0]
    number.innerText = data['number'];
    if (data['car_class'] != '') {
      car_class.innerText = data['car_class'];
    }
    // replace the reading when force is true
    if (force == true) {
      reading.innerText = reading.innerText = data['readings'];
      return tr;
    }
    // Check if reading has a valid value
    if ( data['readings'] != '' && data['readings'] != 0) {
      // Check if reading is a counting number
      if ( data['readings'] < 0 ) {
        // if negative integer use the absolute value to remove the list
        reading.innerText = reading.innerText.replace(Math.abs(data['readings']), '');
      }else{
        // if positive integer append to the list
        reading.innerText +=  ` ${data['readings']}`
      }
      // clear the input to avoid re-using the same entry
      self.clearInput(this.readingTarget);
    };
    return tr;
  }

  removeRowChildren(tr) {
    for (var i = 0; i <= tr.children.length+1; i++) {
      tr.removeChild(tr.children[0]);
    }
    return tr;
  }

  addRowChildren(tr, data) {
    for (var property in data) {
      if (data.hasOwnProperty(property)) {
        var td = document.createElement('td');
        td.innerHTML = data[property];
        td.dataset.name = property;
        tr.appendChild(td);
      }
    }
    return tr;
  }

  getInputData() {
    var inputs = this.getTargets();
    var data = {};
    for (var i = 0; i < inputs.length; i++) {
      data[inputs[i].name] = inputs[i].value;
    }
    return data;
  }

 newRow(data) {
    var tr = document.createElement('tr');
    tr.dataset.target = 'input.tableRow';
    tr.id = this.data.get('id');
    var row = this.addRowChildren(tr, data);
    this.tableBodyTarget.appendChild(row);
  }

  saveAllData() {
    var rows = this.tableRowTargets;
    var self = this;
    rows.forEach(function(row) {
      self.saveData(row);
    });
  }

  tableRow(data) {
    var idx = this.checkId(this.tableRowTargets);
    if ( idx >= 0 ) {
      this.updateRow(data);
    } else {
      this.newRow(data);
    }
  }

  sortRows() {
    var table = this.tableBodyTarget;
    var rows = this.tableRowTargets;
    rows = rows.sort(function(a,b) {
      var order = 0
      order = a.attributes.id.value - b.attributes.id.value;
      if (order == 0) {
        order = a.attributes.id.value.length - b.attributes.id.value.length;
      }
      return order
    });
    rows.forEach(function (row) {
      row.parentElement.removeChild(row);
    });
    rows.forEach(function (row) {
      table.appendChild(row);
    });
  }

  clearInputs(inputs) {
    for (var i = 0; i < inputs.length; i++) {
      this.clearInput(inputs[i])
    }
  }

  clearInput(input) {
    input.value = null;
  }

  nextInput(event) {
    var inputs = this.getTargets();
    var idx =inputs.findIndex(function(ele) {
      return ele == event.srcElement
    });
    if (inputs[idx+1] == undefined) {
      inputs[0].focus();
      this.clearInputs(inputs);
    } else {
      inputs[idx+1].focus();
    }
  }
}
