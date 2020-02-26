/**
 * @format
 */

import {AppRegistry, NativeModules} from 'react-native';
import App from './App';
import {name as appName} from './app.json';

const store = {
  value: 0,
  listeners: [],
  addListener: listener => store.listeners.push(listener),
  increment() {
    store.value++;
    store.listeners.forEach(listener => listener(store.value))
  }
}


AppRegistry.registerComponent(appName, () => App(store));
AppRegistry.registerComponent("appName2", () => App(store));
