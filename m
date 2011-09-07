Message-ID: <4E66B9EC.8050603@brooks.nu>
Date: Tue, 06 Sep 2011 18:25:16 -0600
From: Lane Brooks <lane@brooks.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] MTU confusion
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

I am confused regarding MTU issues and bridging.

I have setup an bridge with an MTU of 1492 for the bridge and all the 
devices in the bridge.

I setup the device interface on one leg of the bridge to have an MTU of 
1492 as well. I mount an nfs share on another leg of the bridge. This 
device has an MTU of 1500 and I get problems with the nfs mount until I 
set the MTU to 1492. Do I have to set all devices on the bridge to have 
an MTU of 1492 for the bridge to work? The reason I am confused is that 
the if the two devices are connected directly with one having an MTU of 
1492 and the other 1500, things work. However, putting the bridge 
between them requires setting both devices to have an MTU of 1492.

Here is the bridge setup:


root@bug20:~# brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.0050c269c63f       no              eth0
                                                         usb0
root@bug20:~# ifconfig -a
br0       Link encap:Ethernet  HWaddr 00:50:C2:69:C6:3F
           inet addr:192.168.75.133  Bcast:192.168.75.255  
Mask:255.255.255.0
           inet6 addr: fe80::250:c2ff:fe69:c63f/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1492  Metric:1
           RX packets:128521 errors:0 dropped:0 overruns:0 frame:0
           TX packets:45471 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:163191890 (155.6 MiB)  TX bytes:39435311 (37.6 MiB)

eth0      Link encap:Ethernet  HWaddr 00:50:C2:69:C6:3F
           UP BROADCAST RUNNING MULTICAST  MTU:1492  Metric:1
           RX packets:44140 errors:0 dropped:0 overruns:0 frame:0
           TX packets:60299 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:16728060 (15.9 MiB)  TX bytes:79965979 (76.2 MiB)

usb0      Link encap:Ethernet  HWaddr D2:D0:1C:9A:35:8F
           inet6 addr: fe80::d0d0:1cff:fe9a:358f/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1492  Metric:1
           RX packets:13914 errors:0 dropped:0 overruns:0 frame:0
           TX packets:7373 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:20359268 (19.4 MiB)  TX bytes:778806 (760.5 KiB)



Thanks,
Lane
