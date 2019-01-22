# /usr/bin/bash
# Modified from: https://github.com/meetfranz/franz/issues/49#issuecomment-421188492

cd /Applications/Franz.app/Contents/Resources
cp app.asar.backup app.asar 2>/dev/null || :
cp app.asar app.asar.backup
asar extract app.asar app_extract
sed '/NauticalPatchStart/,/NauticalPatchEnd/d' app_extract/app.js > __temp__
mv __temp__ app_extract/app.js
echo "// NauticalPatchStart
window.addEventListener('keyup', event => {
  if(event.key=='d' && event.ctrlKey){
    var webview = document.getElementsByTagName('webview');
    var disabled = ['https://hangouts.google.com/', 'https://discordapp.com/activity', 'https://web.skype.com/en/'];
    for (let item of webview) {
        if (!disabled.includes(item.src)) {
            item.insertCSS('html {background-color: #222 !important;}body {filter: contrast(90%) invert(90%) hue-rotate(180deg) !important;-ms-filter: invert(100%);-webkit-filter: contrast(90%) invert(90%) hue-rotate(180deg) !important;text-rendering: optimizeSpeed;image-rendering: optimizeSpeed;-webkit-font-smoothing: antialiased;-webkit-image-rendering: optimizeSpeed;}input, textarea, select {color: purple;}img, video, iframe, canvas, svg, embed[type=\'application/x-shockwave-flash\'], object[type=\'application/x-shockwave-flash\'], *[style*=\'url(\'] {filter: invert(100%) hue-rotate(-180deg) !important;-ms-filter: invert(100%) !important;-webkit-filter: invert(100%) hue-rotate(-180deg) !important;}');
        }
    }
  }
})
// NauticalPatchEnd" >> app_extract/app.js
asar pack app_extract app.asar
PROCESS=Franz
count=$(ps aux | grep $PROCESS | wc -l)
if [ $count -gt 1 ]
    then
        echo 'Franz is running .. you may want to restart application to see changes';
else
    echo 'Start Franz now'
fi
