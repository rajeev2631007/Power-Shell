netsh interface ip set address name="Wi-Fi" static 192.168.1.89 255.255.255.0 192.168.1.254 1

netsh interface ip add dns name="Wi-Fi" addr=172.168.1.2 index=1
netsh interface ip add dns name="Wi-Fi" addr=4.2.2.2 index=2
