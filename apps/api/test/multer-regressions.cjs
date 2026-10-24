// Owned synthetic fixture from Decision 0009. No uncaughtException handler,
// parser error listener added by the test, vendor patch, or external test library.
const assert = require('node:assert/strict');
const http = require('node:http');
const { PassThrough } = require('node:stream');
const { createRequire } = require('node:module');
const adapter = createRequire(require.resolve('@nestjs/platform-express/package.json'));
assert.equal(adapter('./package.json').version, '12.2.0');
const multer = adapter('multer');
assert.equal(adapter('multer/package.json').version, '2.5.0');
const boundary = 'YourOwnSyntheticRegression250';
function multipart(parts, close = true) {
 const chunks = [];
 for (const part of parts) {
  const filename = part.file ? `; filename="${part.name}.txt"` : '';
  chunks.push(Buffer.from(`--${boundary}\r\nContent-Disposition: form-data; name="${part.name}"${filename}\r\n${part.file ? 'Content-Type: text/plain\r\n' : ''}\r\n`), Buffer.from(part.value), Buffer.from('\r\n'));
 }
 if (close) chunks.push(Buffer.from(`--${boundary}--\r\n`));
 return Buffer.concat(chunks);
}
const headers = body => ({'content-type': `multipart/form-data; boundary=${boundary}`, 'content-length': body.length});
const nextTurn = () => new Promise(resolve => setImmediate(resolve));
async function exchange(upload, body) {
 let calls = 0;
 const server = http.createServer((req, res) => upload(req, res, err => {
  calls++;
  res.writeHead(err ? 400 : 200, {'content-type':'application/json'});
  res.end(JSON.stringify(err ? {code:err.code, field:err.field, storageErrors:err.storageErrors} : {fields:req.body, files:(req.files || []).map(file => ({name:file.originalname, value:file.buffer?.toString('hex'), size:file.size}))}));
 }));
 server.requestTimeout = 4000;
 await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
 const address = server.address(); assert.equal(address.address, '127.0.0.1');
 try {
  const response = await new Promise((resolve, reject) => {
   const request = http.request({host:'127.0.0.1', port:address.port, path:'/synthetic', method:'POST', headers:headers(body)}, res => {
    const chunks=[]; res.on('data', chunk => chunks.push(chunk)); res.on('error',reject);
    res.on('end', () => resolve({status:res.statusCode, body:JSON.parse(Buffer.concat(chunks).toString('utf8'))}));
   });
   request.setTimeout(4000, () => request.destroy(new Error('Synthetic client timeout')));
   request.on('error', reject); request.end(body);
  });
  await nextTurn(); assert.equal(calls,1); return response;
 } finally {
  server.closeAllConnections(); await new Promise((resolve,reject) => server.close(err => err ? reject(err) : resolve()));
  assert.equal(server.listening,false);
 }
}
async function asynchronousTeardown() {
 const request = new PassThrough();
 const body = multipart([{name:'parked',file:true,value:'abc'}, {name:'rejected',file:true,value:'xyz'}], false);
 request.headers = headers(body);
 let parser, release, count=0;
 const expected = new Error('Synthetic filter rejection');
 const upload = multer({fileHwm:1, streamHandler(input, actualParser) {parser=actualParser;input.pipe(actualParser);}, fileFilter(input,file,callback) {
  if (file.fieldname==='parked') release=callback;
  else input.once('end', () => setImmediate(() => callback(expected)));
 }}).any();
 const completed = new Promise(resolve => upload(request, null, error => {count++;resolve(error);}));
 request.end(body);
 assert.equal(await completed,expected);assert.equal(typeof release,'function');
 await nextTurn(); // The package's queued teardown has now run.
 // Only observe close: events.once(parser,'close') would itself add an error listener.
 const closed = new Promise(resolve => parser.once('close',resolve));
 release(null,true);await closed;await nextTurn();
 assert.equal(count,1);assert.deepEqual(request.files,[]);assert.equal(parser.destroyed,true);
 assert.match(parser.errored.message,/Unexpected end of form/);
 return {nextCalls:count,files:0,realLateParserError:parser.errored.message};
}
async function main(name) {
 if(name==='async-teardown') return asynchronousTeardown();
 if(name==='normal-upload') {
  const response=await exchange(multer().any(),multipart([{name:'note',value:'synthetic only'}, {name:'sample',file:true,value:'hello synthetic'}]));
  assert.equal(response.status,200);assert.equal(response.body.fields.note,'synthetic only');
  assert.deepEqual(response.body.files,[{name:'sample.txt',value:Buffer.from('hello synthetic').toString('hex'),size:15}]);return response;
 }
 const fields={
  'field-exact':[6,'abcdef'], 'field-over':[6,'abcdefg'],
  'field-default-exact':[undefined,'x'.repeat(1048576)], 'field-default-over':[undefined,'x'.repeat(1048577)],
  'field-unicode-exact':[4,'éé'], 'field-unicode-over':[4,'ééa'],
 };
 if(fields[name]) {
  const [limit,value]=fields[name];const response=await exchange(multer(limit===undefined?{}:{limits:{fieldSize:limit}}).none(),multipart([{name:'text',value}]));
  if(name.endsWith('exact')) {assert.equal(response.status,200);assert.equal(response.body.fields.text,value);}
  else {assert.equal(response.status,400);assert.equal(response.body.code,'LIMIT_FIELD_VALUE');assert.equal(response.body.field,'text');}
  return {status:response.status,bytes:Buffer.byteLength(value),code:response.body.code};
 }
 assert(['storage-failed-cleanup','storage-success-cleanup'].includes(name));
 const fails=name==='storage-failed-cleanup';let completed=0;const removed=[];
 const storage={_handleFile(req,file,callback) {
  file.stream.once('limit',()=>setImmediate(()=>{completed++;callback(fails?new Error('Synthetic storage failure'):null,fails?undefined:{path:'synthetic-buffer-only',size:5});}));file.stream.resume();
 }, _removeFile(req,file,callback) {assert.equal(file.path,'synthetic-buffer-only');removed.push(file.path);callback(null);}};
 const response=await exchange(multer({storage,limits:{fileSize:4}}).any(),multipart([{name:'sample',file:true,value:'0123456789'}]));
 assert.equal(response.status,400);assert.equal(response.body.code,'LIMIT_FILE_SIZE');assert.equal(completed,1);
 assert.deepEqual(removed,fails?[]:['synthetic-buffer-only']);assert.deepEqual(response.body.storageErrors,[]);
 return {code:response.body.code,storageCallbacks:completed,removed};
}
const name=process.argv[2];
const timeout=setTimeout(()=>{throw new Error('Regression case exceeded 8 seconds: '+name);},8000);
main(name).then(result=>{clearTimeout(timeout);console.log(JSON.stringify({name,passed:true,result}));});
