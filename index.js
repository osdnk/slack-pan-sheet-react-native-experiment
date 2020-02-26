/**
 * @format
 */

import {AppRegistry, NativeModules} from 'react-native';
import App from './App';
import {name as appName} from './app.json';



AppRegistry.registerComponent(appName, () => App());
AppRegistry.registerComponent("appName2", () => App());
