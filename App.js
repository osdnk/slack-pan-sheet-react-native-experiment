/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React from 'react';
import {
  Button,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Switch,
  SafeAreaView,
  TextInput,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import {present} from './Modal';

export default function ConfigScreen() {
  const [topOffset, setTopOffset] = React.useState(42);
  const [isShortFormEnabled, setIsShortFormEnabled] = React.useState(true);
  const [longFormHeight, setLongFormHeight] = React.useState(null);
  const [cornerRadius, setCornerRadius] = React.useState(8);
  const [springDamping, setSpringDamping] = React.useState(0.8);
  const [transitionDuration, setTransitionDuration] = React.useState(0.5);
  const [anchorModalToLongForm, setAnchorModalToLongForm] = React.useState(
    true,
  );
  const [allowsDragToDismiss, setAllowsDragToDismiss] = React.useState(true);
  const [allowsTapToDismiss, setAllowsTapToDismiss] = React.useState(true);
  const [
    isUserInteractionEnabled,
    setIsUserInteractionEnabled,
  ] = React.useState(true);
  const [isHapticFeedbackEnabled, setIsHapticFeedbackEnabled] = React.useState(
    true,
  );
  const [shouldRoundTopCorners, setShouldRoundTopCorners] = React.useState(
    true,
  );
  const [showDragIndicator, setShowDragIndicator] = React.useState(true);
  const [headerHeight, setHeaderHeight] = React.useState(50);
  const [shortFormHeight, setShortFormHeight] = React.useState(500);
  const [startFromShortForm, setStartFromShortForm] = React.useState(false);

  return (
    <ScrollView contentContainerStyle={{padding: 12}}>
      <Button
        title="SHOW MODAL"
        onPress={() =>
          present(createAppWithHeader(headerHeight), {
            topOffset,
            isShortFormEnabled,
            longFormHeight,
            cornerRadius,
            springDamping,
            transitionDuration,
            anchorModalToLongForm,
            allowsDragToDismiss,
            allowsTapToDismiss,
            isUserInteractionEnabled,
            isHapticFeedbackEnabled,
            shouldRoundTopCorners,
            showDragIndicator,
            headerHeight,
            shortFormHeight,
            startFromShortForm,
          })
        }
      />

      <View style={{flexDirection: 'row'}}>
        <View style={{flexDirection: 'column', padding: 10}}>
          <Text>topOffset</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={topOffset.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) => setTopOffset(Number(text))}
          />
          <Text>cornerRadius</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={cornerRadius.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) => setCornerRadius(Number(text))}
          />
          <Text>springDamping</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={springDamping.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) => setSpringDamping(Number(text))}
          />
          <Text>transitionDuration</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={transitionDuration.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) =>
              setTransitionDuration(Number(text))
            }
          />
          <Text>headerHeight</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={headerHeight.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) => setHeaderHeight(Number(text))}
          />
          <Text>shortFormHeight</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={shortFormHeight.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) =>
              setShortFormHeight(Number(text))
            }
          />
          <Text>longFormHeight</Text>
          <TextInput
            style={{backgroundColor: 'grey'}}
            value={longFormHeight === null ? '' : longFormHeight.toString()}
            keyboardType="numeric"
            onChange={({nativeEvent: {text}}) =>
              setLongFormHeight(text === '' ? null : Number(text))
            }
          />
        </View>
        <View style={{flexDirection: 'column'}}>
          <Text>anchorModalToLongForm</Text>
          <Switch
            value={anchorModalToLongForm}
            onValueChange={setAnchorModalToLongForm}
          />
          <Text>isShortFormEnabled</Text>
          <Switch
            value={isShortFormEnabled}
            onValueChange={setIsShortFormEnabled}
          />
          <Text>isHapticFeedbackEnabled</Text>
          <Switch
            value={isHapticFeedbackEnabled}
            onValueChange={setIsHapticFeedbackEnabled}
          />
          <Text>allowsDragToDismiss</Text>
          <Switch
            value={allowsDragToDismiss}
            onValueChange={setAllowsDragToDismiss}
          />
          <Text>allowsTapToDismiss</Text>
          <Switch
            value={allowsTapToDismiss}
            onValueChange={setAllowsTapToDismiss}
          />
          <Text>startFromShortForm</Text>
          <Switch
            value={startFromShortForm}
            onValueChange={setStartFromShortForm}
          />
          <Text>showDragIndicator</Text>
          <Switch
            value={showDragIndicator}
            onValueChange={setShowDragIndicator}
          />
          <Text>isUserInteractionEnabled</Text>
          <Switch
            value={isUserInteractionEnabled}
            onValueChange={setIsUserInteractionEnabled}
          />
          <Text>shouldRoundTopCorners</Text>
          <Switch
            value={shouldRoundTopCorners}
            onValueChange={setShouldRoundTopCorners}
          />
        </View>
      </View>
    </ScrollView>
  );
}
const createAppWithHeader = headerHeight => {
  return function App() {
    return (
      <>
        <StatusBar barStyle="dark-content" />
        <View
          style={{width: '100%', height: headerHeight, backgroundColor: 'red'}}
        />
        <ScrollView style={styles.scrollView}>
          <Header />
          {global.HermesInternal == null ? null : (
            <View style={styles.engine}>
              <Text style={styles.footer}>Engine: Hermes</Text>
            </View>
          )}
          <View style={styles.body}>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Step One</Text>
              <Text style={styles.sectionDescription}>
                Edit <Text style={styles.highlight}>App.js</Text> to change this
                screen and then come back to see your edits.
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>See Your Changes</Text>
              <Text style={styles.sectionDescription}>
                <ReloadInstructions />
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Debug</Text>
              <Text style={styles.sectionDescription}>
                <DebugInstructions />
              </Text>
            </View>
            <View style={styles.sectionContainer}>
              <Text style={styles.sectionTitle}>Learn More</Text>
              <Text style={styles.sectionDescription}>
                Read the docs to discover what to do next:
              </Text>
            </View>
            <LearnMoreLinks />
          </View>
        </ScrollView>
      </>
    );
  };
};

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: Colors.lighter,
    height: '100%',
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});
