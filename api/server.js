
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
let allPromises = Promise.all([bengalahindustantimesPromise,bengaliNews18Promise,bengaliOneindiaPromise,bengalaAbplivePromise,eisamayIndiatimePromise]);
allPromises.then(success => {
  //console.log('sucess: ', success);
let mainList =[];

for (let index = 0; index < 4; index++) {
  success.forEach(element => {
   mainList =mainList.concat(element.slice(index *3,  (index+1) *3))
});
  
}

  


res.send(mainList);}).catch(error => console.log('error: ', error));

});
const bengaliNews18Promise = new Promise((resolve, reject) => {
  let parser = new Parser({
  customFields: {
    item: [
      ['g:image_link', 'media:content', {keepArray: true}],
    ]
  }
})
 let all=[];
  parser.parseURL('https://bengali.news18.com/rss/national.xml').then(function(feed){
    console.log(feed.title);
 
  feed.items.forEach(item => {
let obj={};
obj.source = "Bengali News18";
obj.logo = "News18Bangla.png";
obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
obj.urlToImage =item['media:content'][0].substring(item['media:content'][0].indexOf('src=\'')+5,item['media:content'][0].lenght);
obj.urlToImage =obj.urlToImage.substring(0,obj.urlToImage.indexOf('\''));
    all.push(obj);
  });
  });
resolve(all);
});

const bengalahindustantimesPromise = new Promise((resolve, reject) => {
  let parser = new Parser({
  customFields: {
    item: [
       ['media:content', 'media:content', {keepArray: true}],
    ]
  }
})
 let all=[];
  parser.parseURL('https://bangla.hindustantimes.com/rss/bengal/kolkata').then(function(feed){
    console.log(feed.title);
 
  //console.dir(feed);
  feed.items.forEach(item => {
let obj={};
obj.source = "Hindustan Times";
obj.logo = "htbanglal.svg";

obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
obj.Date = item.pubDate;
obj.urlToImage = item['media:content'][0]['$']['url'];
    all.push(obj);
  });
 
  });
resolve(all);

});

const bengaliOneindiaPromise = new Promise((resolve, reject) => {
  let parser = new Parser({
  customFields: {
    item: [
       ['media:content', 'media:content', {keepArray: true}],
    ]
  }
})
 let all=[];
  parser.parseURL('https://bengali.oneindia.com/rss/news-fb.xml').then(function(feed){
    console.log(feed.title);
 
  feed.items.forEach(item => {
let obj={};
obj.source = "Oneindia";
obj.logo = "bengalioneindia.svg";
obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
obj.Date = item.pubDate;

obj.urlToImage = item.enclosure.url;
    all.push(obj);
  });
 
  });

resolve(all);

});


const bengalaAbplivePromise = new Promise((resolve, reject) => {
  let parser = new Parser({
  customFields: {
    item: [
       ['media:thumbnail', 'media:thumbnail', {keepArray: true}],
    ]
  }
})
 let all=[];
  parser.parseURL('https://bengali.abplive.com/home/feed').then(function(feed){
    console.log(feed.title);
 
  //console.dir(feed);
  feed.items.forEach(item => {
let obj={};
obj.source = "ABP Bengali";
obj.logo = "bengaliabp.png";
obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
obj.Date = item.pubDate;
//console.log(item);
obj.urlToImage = item['media:thumbnail'][0]['$']['url'];
    all.push(obj);
  });
 
  });
resolve(all);

});




const eisamayIndiatimePromise = new Promise((resolve, reject) => {
  let parser = new Parser({
  customFields: {
    item: [
      ['content:encoded', 'content:encoded', {keepArray: true}],
    ]
  }
})
 let all=[];
  parser.parseURL('https://eisamay.indiatimes.com/rssfeedsdefault.cms').then(function(feed){
    console.log(feed.title);
 
  feed.items.forEach(item => {
let obj={};
obj.source = "Ei Samay";
obj.logo = "eisamay.jpg";
obj.author = feed.title;
obj.title = item.title;
obj.description = item.content;
obj.url = item.link;
//console.log(item['content:encoded'][0]);
console.log(item['content:encoded'][0].indexOf('src=\'')+5);
obj.urlToImage =item['content:encoded'][0].substring(item['content:encoded'][0].indexOf('src=\"')+5,item['content:encoded'][0].lenght);
console.log(obj.urlToImage);
obj.urlToImage =obj.urlToImage.substring(0,obj.urlToImage.indexOf('\"'));
    all.push(obj);
  });
  });
resolve(all);
});

 
app.listen(process.env.PORT || 3000)