Message-ID: <403A796E.7000708@guerrier.com>
Date: Mon, 23 Feb 2004 23:06:38 +0100
From: Olivier Guerrier <olivier@guerrier.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Linux-bridge, uml, and harware-hub 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "'bridge@osdl.org'" <bridge@osdl.org>

Hello,

I use bridge to give user-mode-linux boxs an Internet access

When the uml-host is connected to the gateway via a cross-wired cable,
everything works fine.

If I put a hub (I've also make tests with another hub and a switch) between
the host and the gateway, uml-guests no more see the gateway (and therefore
no more see the Internet)

In both case the uml-host can ping the gateway and the uml-guests, the
gateway can always ping the uml-host, and the uml-guests can always
ping the uml-host:

* direct cross wired cable between umlhost and gateway:

[umlhost:br2:192.168.1.2/24] -------- [gateway:eth4:192.168.1.1/24]
            |
            |
[uml1:eth0:192.168.1.3/24]

umlhost# ping 192.168.1.1 is OK
umlhost# ping 192.168.1.3 is OK
uml1# ping 192.168.1.1 is OK


* a hub (or a switch) between umlhost and gateway

[umlhost:br2:192.168.1.2/24] --[hub]-- [gateway:eth4:192.168.1.1/24]
            |
            |
[uml1:eth0:192.168.1.3/24]

umlhost# ping 192.168.1.1 is OK
umlhost# ping 192.168.1.3 is OK
uml1# ping 192.168.1.1 no response
gateway# ping 192.168.1.3 no response


I've noticed that dmesg gives me lot of lines like theses:
eth2: received packet with  own address as source address
eth2: received packet with  own address as source address
...

I first think about a MAC adress sort of conflict, so I take care of
assigning specifics ones to the uml-guests, but no changes.


What did I miss ?


Thanks,
Olivier.

PS: my current configuration look like this:

host kernel is a 2.4.22 (with almost all security patchs, skas3, and
cryptoloop) SMP enabled on a dual PIII/400
(cannot try latest 2.4 kernel now, it's planned)

umlhost# brctl show
bridge name     bridge id               STP enabled     interfaces
br2             8000.0080c8e8ac3f       no              eth2
                                                        tap0

umlhost# brctl showmacs br2
port no mac addr                is local?       ageing timer
  1     00:00:e8:3d:be:81       no               202.29   (this is the 
gateway)
  1     00:80:c8:e8:ac:3f       yes                0.00   (this is eth2)
  2     00:ff:c0:6a:b1:46       yes                0.00   (this is tap0)
  2     fe:fd:0a:00:00:01       no               218.27   (this is eth0 
inside uml)

umlhost# ifconfig eth2
eth2      Link encap:Ethernet  HWaddr 00:80:C8:E8:AC:3F
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:1029587 errors:0 dropped:5 overruns:0 frame:104
          TX packets:2307201 errors:3 dropped:0 overruns:3 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:152173060 (145.1 MiB)  TX bytes:3011077736 (2.8 GiB)
          Interrupt:18 Base address:0x9000

umlhost# ifconfig tap0
tap0      Link encap:Ethernet  HWaddr 00:FF:C0:6A:B1:46
          UP BROADCAST RUNNING PROMISC MULTICAST  MTU:1500  Metric:1
          RX packets:7595 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7641 errors:0 dropped:2 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:6853964 (6.5 MiB)  TX bytes:732177 (715.0 KiB)

umlhost# ifconfig br2
br2       Link encap:Ethernet  HWaddr 00:80:C8:E8:AC:3F 
          inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4019 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1342 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:394739 (385.4 KiB)  TX bytes:184260 (179.9 KiB)


uml1:~# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr FE:FD:0A:00:00:01
          inet addr:192.168.1.3  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::fcfd:aff:fe00:1/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7641 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7595 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:625203 (610.5 KiB)  TX bytes:6853964 (6.5 MiB)
          Interrupt:5

gateway# ifconfig eth4
eth4      Link encap:10Mbps Ethernet  HWaddr 00:00:E8:3D:BE:81
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6188 errors:0 dropped:0 overruns:0
          TX packets:5398 errors:0 dropped:0 overruns:0
          Interrupt:12 Base address:0xc400

