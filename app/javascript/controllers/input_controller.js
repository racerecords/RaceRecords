import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'table', 'tableRow', 'input', 'number' ]

  initialize() {
    this.initIDB();
  }

  form() {
    if (event.keyCode === 13) {
      event.preventDefault();
      this.data.set('id', this.numberTarget.value);
      this.tableRow()
      this.sortRows();
      this.nextInput();
      this.saveAllData();
    }
  }

  initIDB() {
    console.log('init db');
    var self = this;
    var request = indexedDB.open("records");

    request.onupgradeneeded = function() {
      // The database did not previously exist, so create object stores and indexes.
      self.db = request.result;
      var store = self.db.createObjectStore("readings", {keyPath: "number"});
      var numberIndex = store.createIndex("by_number", "number", {unique: true});
      console.log('Upgrade DB');
    };

    request.onsuccess = function() {
      self.db = request.result;
      console.log('On Success');
      self.checkDB();
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
        console.log(cursor);
        self.newRow(cursor.value);
        cursor.continue();
      }
    }

  }

  getTargets() {
    return this.inputTargets;
  }

  checkId(arr) {
    var id = this.data.get('id');
    return arr.findIndex(function(ele) { 
      return ele.dataset.id == id
    });
  }

  updateRow(idx) {
    var tr = this.tableRowTargets[idx];
    tr = this.updateRowChildren(tr);
    this.tableTarget.appendChild(tr);
  }

  updateRowChildren(tr) {
    var inputs = this.getTargets();
    var self = this;
    for (var i = 0; i < tr.children.length; i++) {
        inputs.forEach(function (input){
          if ( tr.children[i].dataset.name == input.name && input.value != '' && input.value != 0) {
            if (input.name == 'reading') {
              if (input.value < 0) {
                var val = tr.children[i].innerText;
                tr.children[i].innerText = val.replace(Math.abs(input.value), '');
              } else {
                tr.children[i].innerText += `   ${input.value}`;
              }
              self.clearInput(input);
            } else {
              tr.children[i].innerText = input.value;
            }
          }
        });
      }
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
    tr.dataset.id = this.data.get('id');
    var row = this.addRowChildren(tr, data);
    this.tableTarget.appendChild(row);
  }

  saveAllData() {
    var rows = this.tableRowTargets;
    var self = this;
    rows.forEach(function(row) {
      self.saveData(row);
    });
  }

  saveData(row) {
    var data = {};
    for (var i = 0; i < row.children.length; i++) {
      data[row.children[i].dataset.name] = row.children[i].innerText
    }
    var tx = this.db.transaction('readings', 'readwrite');
    var store = tx.objectStore('readings');
    store.put(data);
    tx.oncomplete = function() {
      console.log('transaction complete');
    };
  }

  tableRow() {
    var idx = this.checkId(this.tableRowTargets);
    if ( idx >= 0 ) {
      this.updateRow(idx);
    } else {
      this.newRow(this.getInputData());
    }
  }

  sortRows() {
    var table = this.tableTarget;
    var rows = this.tableRowTargets;
    rows.sort(function(a,b) {
      var order
      order = a.firstChild.innerText - b.firstChild.innerText;
      if (order == 0) {
        order = a.firstChild.innerText.length - b.firstChild.innerText.length;
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

  nextInput() {
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
