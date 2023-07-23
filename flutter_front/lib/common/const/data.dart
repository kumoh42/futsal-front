import 'dart:io';

// ignore: constant_identifier_names
const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
// ignore: constant_identifier_names
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';


const emulatorIp = '10.0.2.2:3000';
const simulatorIP = '127.0.0.1:3000';
final ip = Platform.isAndroid ? emulatorIp : simulatorIP;