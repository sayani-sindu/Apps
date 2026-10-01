import Plotline from 'plotline-engage';
import React, { useEffect } from 'react';
import {View, Text, StyleSheet} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';

const ROWS = ['Account', 'Orders', 'Addresses', 'Notifications', 'Help & support'];

export default function ProfileScreen() {
  useEffect(() => {
      Plotline.identify({
        subscription: 'paid',
        plan: 'pro',
        country: 'IN',
      });
    }, [])
  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <View style={styles.header}>
        <View style={styles.avatar}>
          <Text style={styles.avatarText}>SS</Text>
        </View>
        <Text testID = "sample_uesr" style={styles.name}>Sample User</Text>
        <Text testID = "mailId" style={styles.email}>user@example.com</Text>
      </View>
      {ROWS.map(r => (
        <View key={r} style={styles.row}>
          <Text style={styles.rowText}>{r}</Text>
          <Text style={styles.chev}>›</Text>
        </View>
      ))}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {flex: 1, backgroundColor: '#0f1115'},
  header: {alignItems: 'center', paddingVertical: 30},
  avatar: {width: 80, height: 80, borderRadius: 40, backgroundColor: '#5b6cff', alignItems: 'center', justifyContent: 'center'},
  avatarText: {color: '#fff', fontSize: 28, fontWeight: '700'},
  name: {color: '#fff', fontSize: 20, fontWeight: '700', marginTop: 12},
  email: {color: '#9aa0aa', fontSize: 14, marginTop: 4},
  row: {flexDirection: 'row', justifyContent: 'space-between', paddingHorizontal: 20, paddingVertical: 18, borderBottomWidth: 1, borderBottomColor: '#22262f'},
  rowText: {color: '#fff', fontSize: 16},
  chev: {color: '#9aa0aa', fontSize: 22},
});
