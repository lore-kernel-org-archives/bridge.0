Message-ID: <427D8B20.7010301@SiuLung.com>
Date: Sun, 08 May 2005 11:44:32 +0800
From: Alan Tam <Tam@SiuLung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] How to disable verbose kernel logs for linux ethernet
	bridge?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

This is part of my dmesg output which is generated whenever some network 
topology changes. It is very annoying. Any ways for me to inhibit those 
which are only informational but not warnings which I need to take care? 
I am running the all bridges on tap* interfaces emulated by OpenVPN. I 
am running stock 2.6.8 kernel from Debian sarge.

Please CC me Thanks!

---8<---8<---8<---8<---8<---8<---8<---8<---8<---
br0: port 1(tap0) entering listening state
br0: port 1(tap0) entering learning state
br0: topology change detected, propagating
br0: port 1(tap0) entering forwarding state
br0: port 1(tap0) entering disabled state
device tap1 entered promiscuous mode
br0: port 2(tap1) entering listening state
br0: port 1(tap0) entering listening state
br0: port 2(tap1) entering learning state
br0: port 1(tap0) entering learning state
br0: topology change detected, propagating
br0: port 2(tap1) entering forwarding state
br0: topology change detected, propagating
br0: port 1(tap0) entering forwarding state
eth0: no IPv6 routers present
tap0: no IPv6 routers present
br0: no IPv6 routers present
tap1: no IPv6 routers present
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: neighbor 8000.00:ff:04:c8:95:4e lost on port 1(tap0)
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, propagating
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: neighbor 8000.00:ff:05:d2:76:ca lost on port 1(tap0)
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, sending tcn bpdu
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, sending tcn bpdu
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, sending tcn bpdu
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, sending tcn bpdu
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
tap0: received packet with  own address as source address
tap0: received packet with  own address as source address
tap0: received packet with  own address as source address
tap0: received packet with  own address as source address
tap0: received packet with  own address as source address
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, propagating
tap0: received packet with  own address as source address
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: neighbor 8000.00:ff:05:d2:76:ca lost on port 1(tap0)
br0: port 2(tap1) entering listening state
br0: received tcn bpdu on port 1(tap0)
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering learning state
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
br0: topology change detected, propagating
br0: port 2(tap1) entering forwarding state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering blocking state
br0: neighbor 8000.00:ff:05:d2:76:ca lost on port 1(tap0)
br0: port 2(tap1) entering listening state
br0: port 2(tap1) entering learning state
br0: topology change detected, sending tcn bpdu
br0: port 2(tap1) entering forwarding state
br0: neighbor 8000.00:ff:16:cb:25:97 lost on port 2(tap1)
br0: topology change detected, propagating
---8<---8<---8<---8<---8<---8<---8<---8<---8<---

-- 
Regards,
Alan

