// const fetch = require('node-fetch');
//  // const xpath = require("xpath-html");
//   const xpath = require('xpath');
// const parse5 = require('parse5');
// const xmlser = require('xmlserializer');
// const dom = require('xmldom').DOMParser;

let Parser = require('rss-parser');


const express = require('express')
const app = express()
const port = 3000

app.get('/all/bangla', (req, res) => {

 let parser = new Parser({
  customFields: {
    item: [
      ['media:content', 'media:content', {keepArray: true}],
    ]
  }
})
  parser.parseURL('https://www.thedailystar.net/top-news/rss.xml').then(function(feed){
    console.log(feed.title);
  let all=[];
  //console.dir(feed);
  feed.items.forEach(item => {
let obj={};
obj.source = feed.title;
obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
obj.urlToImage = item['media:content'][0]['$']['url'];
//console.log(item);
    all.push(obj);
  });
 res.send(all);
  });
  
// fetch('https://www.thedailystar.net/top-news/rss.xml', { headers:{
//       contentType: "application/json; charset=utf-8",
//     }})
//     .then(resp=> resp.text()).then(function(body){


//       const document = parse5.parse(body.toString());
//       console.log(document);
//     const xhtml = xmlser.serializeToString(document);
//      console.log(xhtml);
//     const doc = new dom().parseFromString(xhtml);

//       const select = xpath.useNamespaces({"x": "http://www.w3.org/1999/xhtml"});
//     const nodes = select("//last-published-at", doc);
//  //console.dir(xhtml);
//  const indexOfFirst = xhtml.indexOf("\"slug\":\"featured\"");
//  let sub =xhtml.substring(indexOfFirst);
//  let indexOfFirst2 = sub.indexOf("\"items\"");
//  let main =sub.substring(indexOfFirst2 + 7);
//  indexOfFirst2 = main.indexOf("\"items\"");
// // console.dir(main);
//  let main2 =main.substring(0,indexOfFirst2);
//  let indexOfFirst3 = main2.lastIndexOf("\"id\"");
//  //console.dir(main2);
//  let main3 =main2.substring(1,indexOfFirst3-3);
//  //console.log(sub.substring(0,indexOfFirst2));
//  console.log(indexOfFirst);

//  const fs = require('fs').promises;

// This must run inside a function marked `async`:
//const file = fs.readFile('filename.txt', 'utf8')
//  fs.writeFile('filename.txt', main3);
//  const obj = JSON.parse(main3);
// //console.dir(main3.substring(0,50));
// console.dir(obj[0]);
// obj.forEach(element => {
     
//      // console.dir(element);

//     });
    // res.send(obj);
    // nodes.forEach(element => {
    //   let topNode =element.parentNode;
    //   let adata =select("//x:a[@class='newsHeadline-m__title-link__1puEG']", topNode);
    //   console.dir(nodes[0].localName +": " + nodes[0].firstChild.data);

    // });
//     for (let index = 0; index < 2; index++) {
//       const element = nodes[index];//
//       let topNode =nodes[index].parentNode.parentNode.parentNode;
//       let topNodeDocument = parse5.parse(topNode.toString());
//  console.dir(topNode.toString());
//   let  topNodeXhtml = xmlser.serializeToString(topNodeDocument);
//     let topNodeDoc = new dom().parseFromString(topNodeXhtml);
//       let adata =select("//x:a[@class='newsHeadline-m__title-link__1puEG']", topNodeDoc);
//        let pdata =select("//x:img[@class='qt-image']", topNodeDoc);
// //console.dir(pdata[0].toString());
// //console.Console(pdata[0].src);
//       // console.dir(pdata[0].src);
//       //console.dir(adata[0].firstChild.data);
//       // console.dir(topNode.localName +": " + topNode.firstChild.firstChild.firstChild.data);
//       // let adata =select("//x:a[@class='newsHeadline-m__title-link__1puEG']", topNode);
//        //console.dir(adata[0].localName +": " + adata[0].firstChild.data);
//     //   console.dir(nodes[0].localName +": " + nodes[0].firstChild.data);
//        //console.dir(nodes[index].localName +": " + nodes[index].firstChild.data);
      
//     }
//  console.log( nodes.length)
// console.dir(nodes[0].parentNode.parentNode.parentNode.parentNode.localName);
// let adata =select("//x:a[@class='newsHeadline-m__title-link__1puEG']", nodes[0].parentNode.parentNode);
// console.dir(nodes[0].localName +": " + nodes[0].firstChild.data);
// console.dir(nodes[0].parentNode.parentNode.parentNode.firstChild.localName);
// console.log(nodes[0].localName + ": " + nodes[0].firstChild.data)
// console.log("Node: " + nodes[0].toString())
    // const select = xpath.useNamespaces({"x": "http://www.w3.org/1999/xhtml"});
    // const nodes = select("//x:a/@href", doc);
    // console.log(nodes);
   //console.log(body) ; 
   //var doc = new dom().parseFromString(xml)
//var nodes = xpath.select("//title", doc)
// const nodes = xpath
//   .fromPageSource(body)
//   .findElements('//span');
//   console.log(nodes.length);
//   console.log("Text of nodes[0]:", nodes[0].getText());
    }); 
 


app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

String.prototype.nthIndexOf = function(searchElement, n, fromElement) {
    n = n || 0;
    fromElement = fromElement || 0;
    while (n > 0) {
        fromElement = this.indexOf(searchElement, fromElement);
        if (fromElement < 0) {
            return -1;
        }
        --n;
        ++fromElement;
    }
    return fromElement - 1;
};
