var http	= require('http'),
	fs		= require('fs'),
	path	= require('path'),
	port	= 1337;

http.createServer(function ( req, resp ) {
	var nodeName = '.'+req.url;

	fs.stat(nodeName, function ( err, stats ) {
		if (err === null && stats.isFile() ) {
			streamFile(resp, nodeName);
		} else {
			if (err === null && stats.isDirectory()) {
				fileName = nodeName + 'index.html';
				fs.stat(fileName, function ( err, stats ) {
					if (err === null && stats.isFile() ) {
						streamFile(resp, fileName);
					} else {
						return ls(resp, nodeName);
					}
				});
			} else {
				resp.writeHead(404);
				resp.end('File Not Found');
			};
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

function ls( out, dir ) {
	fs.readdir(dir, function ( err, files ) {
		if(err === null) {
			out.writeHead(300, { 'Content-Type': 'html' });
			out.write('<!DOCTYPE html5><html><head><meta charset="utf-8"/>'+
				'<title>Viewing '+path+'</title></head><body><table><th><td>'+
				'file</td><td>mime</td></th><tr><td><a href="../">Parent '+
				'Directory</a></td></tr>');
			for (var i = files.length - 1; i >= 0; i--) {
				var fsnode = dir+files[i];
				try {
					//	the first sin of node.js -- I know..
					stats = fs.statSync(dir+files[i]);
					var bs = path.basename(files[i]);
					if(stats.isDirectory()) bs += '/';
					out.write('<tr><td><a href="'+bs+'">'+bs+'</a></td>');
					if(stats.isDirectory()) {
						out.write('<td> [Directory Entry] </td></tr>');
					} else {
						out.write('<td>'+getMime(files[i])+'</td></tr>');
					}
				} catch( all ) {}
			}
			out.end('</table></body></html>');
		} else {
			out.writeHead(500);
			out.end('Uh, oh! Something bad happend, sorry! ;-C');
		}
	});
}

function getMime( file ) {
	switch (path.extname(file)) {
		case '.coffee':
			return 'text/coffee-script';
		case '.css':
			return 'text/css';
		case '.htm':
		case '.html':
			return 'text/html'
		case '.js':
			return 'text/javascript';
		case '.json':
			return 'text/json';
		case '.md':
			return 'text/markdown';
		case '.yml':
			return 'text/yaml';
		default:
			return 'application/octet-stream'
	}
}
