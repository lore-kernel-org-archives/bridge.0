Message-ID: <47862D4A.40806@kiusys.com>
Date: Thu, 10 Jan 2008 12:35:54 -0200
From: Ivan Hernandez <ihernandez@kiusys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] cannot ping network when i do addif br0 eth0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

i have a bridge to connect a tap0 interface with openvpn to my eth0 netwotk
the openvpn connections goes fine, but when i try to ping from the box 
it does not work
the problem looks this way:
mail:~# brctl addif br0 eth0
mail:~# ping 10.1.27.161
PING 10.1.27.161 (10.1.27.161) 56(84) bytes of data.

--- 10.1.27.161 ping statistics ---
6 packets transmitted, 0 received, 100% packet loss, time 4999ms

mail:~# brctl delif br0 eth0
mail:~# ping 10.1.27.161
PING 10.1.27.161 (10.1.27.161) 56(84) bytes of data.
64 bytes from 10.1.27.161: icmp_seq=1 ttl=64 time=0.189 ms
64 bytes from 10.1.27.161: icmp_seq=2 ttl=64 time=0.161 ms

some tip to use my eth0 card while it's on the bridge? thanks a lot!
ivan
