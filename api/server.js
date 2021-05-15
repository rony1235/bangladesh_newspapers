
let Parser = require('rss-parser');


const express = require('express')
const app = express()

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
});

app.get('/all/kolkata', (req, res) => {

 let parser = new Parser({
  customFields: {
    item: [
      ['g:image_link', 'media:content', {keepArray: true}],
    ]
  }
})
  parser.parseURL('https://bengali.news18.com/rss/national.xml').then(function(feed){
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
console.log(item);
//obj.urlToImage = ;
//let Xml = new DOMParser();
obj.urlToImage =item['media:content'][0].substring(item['media:content'][0].indexOf('src=\'')+5,item['media:content'][0].lenght);
obj.urlToImage =obj.urlToImage.substring(0,obj.urlToImage.indexOf('\''));
//console.log(item);
    all.push(obj);
  });
 res.send(all);
  });
});


 
app.listen(process.env.PORT || 3000)




