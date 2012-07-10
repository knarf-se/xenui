var http	= require('http'),
	fs		= require('fs'),
	path	= require('path'),
	port	= 1337;

http.createServer(function ( req, resp ) {
	var fileName = (req.url=='/')?'./index.html':'.'+req.url;

	fs.stat(fileName, function ( err, stats ) {
		if (err === null && stats.isFile() ) {
			streamFile(resp, fileName);
		} else {
			fileName += 'index.html';
			fs.stat(fileName, function ( err, stats ) {
				if (err === null && stats.isFile() ) {
					streamFile(resp, fileName);
				} else {
					resp.writeHead(404);
					resp.end('File Not Found');
				}
			});
		}
	});
}).listen(port);

console.log('Local server started, access at: http://ulh.us:'+port+'/');
console.log('Abort server with Ctrl+C');

function streamFile( dest, fileName ) {
	var mimeType = getMime(fileName);
	var stream = fs.createReadStream(fileName);
	stream.on('error', function () {
		dest.writeHead(500);
		dest.end('An error occured ;-(');
	});

	dest.writeHead(200, { 'Content-Type': mimeType });
	stream.pipe(dest);
}

function getMime( file ) {
	switch (path.extname(file)) {
		case '.js':
			return 'text/javascript';
		case '.css':
			return 'text/css';
		case '.htm':
		case '.html':
			return 'text/html'
		default:
			return 'application/octet-stream'
	}
}
