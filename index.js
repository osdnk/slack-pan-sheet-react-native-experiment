/**
 * @format
 */

import {AppRegistry, NativeModules} from 'react-native';
import App from './App';
import {name as appName} from './app.json';
import {registerModal} from "./Modal";

const store = {
  value: 0,
  listeners: [],
  addListener: listener => store.listeners.push(listener),
  increment() {
    store.value++;
    store.listeners.forEach(listener => listener(store.value))
  }
}

registerModal()
AppRegistry.registerComponent(appName, () => App);
