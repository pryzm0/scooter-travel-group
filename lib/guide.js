var all = function (doc) {
  if (doc.type === 'guide') emit(doc._id, doc);
}

var list = function (doc) {
  if (doc.type === 'guide') emit(doc._id, {
    name: doc.name
  });
}

var link = function (doc) {
  if (doc.type === 'guide') emit(doc.link, doc);
}

module.exports = {
  _id: "_design/guide",
  language: "javascript",
  version: "0.0.1",
  views: {
    all: {
      map: all.toString()
    },
    listRows: {
      map: list.toString()
    },
    link: {
      map: link.toString()
    },
  }
}
