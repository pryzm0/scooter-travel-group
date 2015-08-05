var all = function (doc) {
  if (doc.type === 'article') emit(doc._id, doc);
}

var list = function (doc) {
  if (doc.type === 'article') emit(doc._id, {
    title: doc.title,
    author: doc.author
  });
}

var link = function (doc) {
  if (doc.type === 'article') emit(doc.link, doc);
}

module.exports = {
  _id: "_design/articles",
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
