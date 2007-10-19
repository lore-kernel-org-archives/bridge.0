DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	bh=xUDNi7alFh5peT3csqENuJYTZIz/pYaFiEVauBAvphU=;
	b=csjnAfsGcHG4TnoJITt84xTlHCFQkwLTte8RyCLtRqxcNk4Ya6mfA6j4UdEDjx4Y4XOpShqy8XGBIvureKu+LeJdUl0u09m6QMdabvplz+58R2e2vijpYzj3RwP2RlNYq0rBpEWL02R2oJY/R56lRLWcaLkvjgEJtYo3jSgxqpY=
Message-ID: <787b0d920710182048s3f8627dek6b6b816897951415@mail.gmail.com>
Date: Thu, 18 Oct 2007 23:48:56 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] firewalling a VM
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I managed to cut my own network connection while
trying to firewall vmware with ebtables and dummy0.
That is, the host PC couldn't reach the net.

Doc trouble:

The distinction between --logical-in and --in-interface
is not clear in the ebtables man page. Nothing seems
to document usage of the dummy devices. Bridging
to/from a normal already-running interface like eth0
could use a few examples. Diagrams of packet flow
through the kernel would help, even if that means a
man page with ASCII art.

So anyway...

Vmware likes to do it's own bridging, and it wants to
use an eth* device. I'll rename dummy0 for that, so I
can use ebtables to get the security under control.
Here goes my attempt:

#############
ip link set dev dummy0 name eth9
brctl addbr hack
brctl stp hack off
brctl addif hack eth0
brctl addif hack eth9

ebtables -N myvmware -P DROP
ebtables -N multi -P DROP
ebtables -N addresses -P RETURN

ebtables -P FORWARD DROP
# (00:0c:29:80:b5:66 is the VM)
ebtables -A FORWARD -d 00:0c:29:80:b5:66 -j ACCEPT
ebtables -A FORWARD -d Multicast -j multi
ebtables -A FORWARD -s 00:0c:29:80:b5:66 -j myvmware

# From my VM, to another single host (could be the gateway)
ebtables -P myvmware DROP
ebtables -A myvmware -p ARP -j ACCEPT
ebtables -A myvmware -p IPv4 --ip-destination 192.168.0.0/20 -j ACCEPT
ebtables -A myvmware -p IPv4 -j addresses
ebtables -A myvmware --log-level info --log-ip --log-arp --log-prefix EB1:

# Any broadcast/multicast, incoming or outgoing
ebtables -P multi DROP
ebtables -A multi -p ARP -j ACCEPT
ebtables -A multi -p IPv4 --ip-proto 6 --ip-sport 67:68 -j ACCEPT
ebtables -A multi -p IPv4 --ip-proto 6 --ip-dport 67:68 -j ACCEPT
ebtables -A multi -p IPv4 --ip-proto 17 --ip-sport 67:68 -j ACCEPT
ebtables -A multi -p IPv4 --ip-proto 17 --ip-dport 67:68 -j ACCEPT
ebtables -A multi --log-level info --log-ip --log-arp --log-prefix EB2:

# Add addresses as required.
ebtables -P addresses RETURN
#ebtables -A addresses -p IPv4 --ip-destination 1.2.3.4 -j ACCEPT

# This didn't fix the problem.
# (00:13:72:29:16:7C is eth0)
ebtables -A FORWARD -d 00:13:72:29:16:7C -j ACCEPT
ebtables -A FORWARD -s 00:13:72:29:16:7C -j ACCEPT
ifconfig eth9 up
#####################

That just kills my net connection. Note that I never
told my host machine to route via the bridge device.
As far as I'm concerned, it ought to still be using eth0.
(getting between host and VM is a separate issue)
The only thing I did with eth0 was to add a bridge over
to the dummy0 device (renamed to eth9), which should
just mean that -- subject to ebtables rules -- packets
get replicated from eth0 to the dummy device and back.

It kind of feels like the bridge is stealing packets
rather than just replicating them to the other devices,
but adding ebtables rules for the host didn't fix things.

FWIW, here is what ifconfig has to say about it:



eth0      Link encap:Ethernet  HWaddr 00:13:72:29:16:7C
         inet addr:192.168.5.242  Bcast:192.168.15.255  Mask:255.255.240.0
         inet6 addr: fe80::213:72ff:fe29:167c/64 Scope:Link
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:23046863 errors:0 dropped:0 overruns:0 frame:0
         TX packets:1699146 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:1000
         RX bytes:9738438913 (9.0 GiB)  TX bytes:161288685 (153.8 MiB)
         Base address:0xcce0 Memory:fe3e0000-fe400000

eth9      Link encap:Ethernet  HWaddr 5E:95:DD:AF:2B:F1
         inet6 addr: fe80::5c95:ddff:feaf:2bf1/64 Scope:Link
         UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
         RX packets:0 errors:0 dropped:0 overruns:0 frame:0
         TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:0 (0.0 b)  TX bytes:70 (70.0 b)

lo        Link encap:Local Loopback
         inet addr:127.0.0.1  Mask:255.0.0.0
         inet6 addr: ::1/128 Scope:Host
         UP LOOPBACK RUNNING  MTU:16436  Metric:1
         RX packets:116406 errors:0 dropped:0 overruns:0 frame:0
         TX packets:116406 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:0
         RX bytes:10533257 (10.0 MiB)  TX bytes:10533257 (10.0 MiB)

vmnet1    Link encap:Ethernet  HWaddr 00:50:56:C0:00:01
         inet addr:192.168.14.1  Bcast:192.168.14.255  Mask:255.255.255.0
         inet6 addr: fe80::250:56ff:fec0:1/64 Scope:Link
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:0 errors:0 dropped:0 overruns:0 frame:0
         TX packets:45 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:1000
         RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

vmnet8    Link encap:Ethernet  HWaddr 00:50:56:C0:00:08
         inet addr:192.168.183.1  Bcast:192.168.183.255  Mask:255.255.255.0
         inet6 addr: fe80::250:56ff:fec0:8/64 Scope:Link
         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
         RX packets:0 errors:0 dropped:0 overruns:0 frame:0
         TX packets:47 errors:0 dropped:0 overruns:0 carrier:0
         collisions:0 txqueuelen:1000
         RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
