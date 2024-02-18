const APP_NAME = "ChooseNumber";
const LOCAL_URL = "";
const REMOTE_URL = "http://154.73.22.121:4490/";
// const REMOTE_URL = "http://192.168.137.1:45455/";
const BASE_URL = REMOTE_URL;
const AUTH_URL = REMOTE_URL + "api/Auth/";
//"http://154.73.22.121:4491/api/Auth/"; //"http://192.168.137.1:4040/api/Auth/";

const ACCOUNT_URL =
    AUTH_URL; //"http://192.168.137.1:4040/api/Auth/"; //192.168.137.1//"http://154.73.22.121:4491/api/Auth/";
const ZONE_URL = "${BASE_URL}api/zone/";
const SIMREG_URL = "${BASE_URL}api/register-sim";
const CHANNEL_URL = "${BASE_URL}api/channel/";
const POS_URL = "${BASE_URL}api/pos/";
const RESERVATION_URL = "${BASE_URL}api/Reservation/";
const CHOOSE_NUMBER_URL = "${BASE_URL}api/ChooseNumber/";
const CREATION_URL = "${BASE_URL}api/Creation/";
