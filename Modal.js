import React from 'react'
import {AppRegistry, NativeModules} from "react-native";
import App from "./App";

export const registerModal = () => {
  AppRegistry.registerComponent("appName2", () => ModalHost);
}

let modalHostViewSetView = null;

function ModalHost() {
  const [view, setView] = React.useState(null)
  if (!modalHostViewSetView) {
    modalHostViewSetView = setView
  }
  return view
}

export function present(view, config = {}) {
  if (modalHostViewSetView){
    modalHostViewSetView(view)
  }
  NativeModules.PanManager.present(config)
}
