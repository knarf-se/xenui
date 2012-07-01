var http	= require('http'),
	fs		= require('fs'),
	path	= require('path'),
	port	= 1337;

http.createServer(function ( req, resp ) {
	var fileName = (req.url=='/')?'./index.html':'.'+req.url;
	var mimeType = getMime(fileName);

	fs.exists(fileName, function( exists ) {
		if (exists) {
			var stream = fs.createReadStream(fileName);
			stream.on('error', function () {
				resp.writeHead(500);
				resp.end('An error occured ;-(');
			});

			resp.writeHead(200, { 'Content-Type': mimeType });
			stream.pipe(resp);
		} else {
			resp.writeHead(404);
			resp.end();
		}
	});
}).listen(port);

console.log('Local server started, access at: http://ulh.us:'+port+'/');
console.log('Abort server with Ctrl+C');

function getMime( file ) {
	switch (path.extname(file)) {
		case '.js':
			return 'text/javascript';
			break;
		case '.css':
			return 'text/css';
			break;
		default:
			return 'text/html'
	}
}
