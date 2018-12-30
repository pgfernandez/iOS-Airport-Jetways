var restify = require('restify');
var mongojs = require("mongojs");

var http = require('http');
var url = require('url');
var fs = require('fs');
var sys = require('sys');

var amqp = require('amqp');

/*
//COMUNICACION CON EL ESB
var connection = amqp.createConnection({ host: '127.0.0.1' });

// Wait for connection to become established.
connection.on('ready', function () {
  // Use the default 'amq.topic' exchange
  connection.queue('scada', function(q){
      // Catch all messages
      q.bind('#');
      console.log('Connected to queue scada');

      // Receive messages
      q.subscribe(function (message) {
        // Print messages to stdout
        console.log(message.BELT);

        updateCarrouselDepartureFlight(message.flight, message.BELT);


      });
  });
});
*/
//DATABASE

var connection_string = '127.0.0.1:27017/aeriaa';
var db = mongojs(connection_string, ['scada']);
var scadaJetways = db.collection("scadaJetways");


//WEB SERVER

var server;
// the HTTP port
var port = 8091;

server = http.createServer(function(req, res){
  var path = url.parse(req.url).pathname;
  if (path == '/') {
    path = '/home.html'
  }
  console.log("serving " + path);
  fs.readFile(__dirname + path, function(err, data){
    if (err) {
      res.writeHead(404);
      res.end();
    } else {
      res.writeHead(200, {'Content-Type': contentType(path)});
      res.write(data, 'utf8');
      res.end();
    }
  });
});
    
function contentType(path) {
  if (path.match('.js$')) {
    return "text/javascript";
  } else if (path.match('.css$')) {
    return  "text/css";
  }  else {
    return "text/html";
  }
}
    
server.listen(port);
console.log("HTTP server running at htpp://0.0.0.0:" + port );

//REST API and SERVER 

var ip_addr = '127.0.0.1';
var port    =  '8188';
 
var server = restify.createServer({
    name : "scada"
});
 
server.listen(port ,ip_addr, function(){
    console.log('%s listening at %s ', server.name , server.url);
});

server.use(restify.queryParser());
server.use(restify.bodyParser());
server.use(restify.CORS());




//SCADA WEB SERVICES REST API

var PATH = '/scada'
server.get({path : PATH +'/:jetways' , version : '0.0.1'} , requestJetwaysStatus);
server.post({path : PATH +'/:jetways/:jetway/:eq/:value' , version : '0.0.1'} , updateValue);

function updateValue(req, res , next){
  
  
  console.log("jetway recibida para actualizar: "+ req.params.jetway);
  console.log("equipo recibido para actualizar: "+ req.params.eq);
  console.log("valor recibido para actualizar: "+ req.params.value);
  res.setHeader('Access-Control-Allow-Origin','*');
  
   //necesario para pasar como variable el campo a actualizar
   var field = req.params.eq;
   var fieldToUpdate = {};
   fieldToUpdate[field] = req.params.value;

  scadaJetways.update({jetway:req.params.jetway},{$set:fieldToUpdate}, function(error , success){
          if(success){
          

          }else{
            console.log('Find Carrousel Response error '+ err);

          }
      //  console.log('Response error '+err);
        }); 
  // y publicarlo en MQ





  res.send(200 , "ok");
  
}

function requestJetwaysStatus(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    scadaJetways.find().sort({jetway : 1}, function(err , success){
        console.log('Response success '+success);
        console.log('Response error '+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
 
}


