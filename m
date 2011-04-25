Message-ID: <4DB5BD6C.7000003@gmail.com>
Date: Mon, 25 Apr 2011 20:29:00 +0200
From: =?UTF-8?B?SXJlbmV1c3ogU3pjemXFm25pYWs=?=
 <irek.szczesniak@gmail.com>
MIME-Version: 1.0
References: <4DB43C0F.9080502@gmail.com>
In-Reply-To: <4DB43C0F.9080502@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] brctl problem: broadcast doesn't get through
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Now I think I understand better what is happening in my case.  I guess 
that my configuration can be depicted as follows:

application
that connects
to tap1
  |   ^
  |   |
  | tap1
  | intf
  |   |
  v   |
bridge "test"
  |   ^
  v   |
tap0 |
intf |
  |   |
  v   |
application
that connects
to tap0

The reasoning for the arrows above is as follows:

1. When I send a broadcast frame to tap0 with "etherwake -b -i tap0 
00:00:00:00:00:00", this frame doesn't reach the bridge, but it 
reaches the application connected to the tap0 interface.

2. It seems that the tap0 interface is transparent, i.e. the messages 
that originate at the bridge and that should be sent to the 
application that connects to tap0 are not consumed by the tap0 
interface.  Listening with tcpdump or tshark on tap0 shows these messages.

3. When I send in the application connected to tap0 a frame with the 
destination address of the tap0 interface, this frame is seen at the 
bridge.

If my reasoning is wrong, please let me know.


Thanks.
Irek

On 24.04.2011 17:04, Ireneusz Szcześniak wrote:
> Hi,
>
> I'm creating a bridge, and then add to it two tap interfaces. No
> physical interface is added to the bridge. These are the commands:
>
> brctl addbr test
> ip tuntap add mode tap tap0
> ip tuntap add mode tap tap1
> ifconfig test up
> ifconfig tap0 up
> ifconfig tap1 up
> brctl addif test tap0
> brctl addif test tap1
>
> The problem is that the bridge doesn't seem to work correctly. I sent
> through tap0 some broadcast frames (WOL frames), and they didn't reach
> tap1. I was sending packets with:
>
> etherwake -b -i tap0 00:00:00:00:00:00
>
> The tshark command for tap0 showed the frames being sent with tap0, but
> another tshark for tap1 didn't show them.
>
> Then I added to tap0 the IP address 192.168.10.1/24, and did:
>
> arping 192.168.1.2
>
> I saw ARP request broadcast frames on tap0, but they didn't reach tap1.
>
> This is the output of ifconfig for test, tap0, and tap1 interfaces:
>
> root@computer:~# ifconfig test
> test Link encap:Ethernet HWaddr 02:07:b1:eb:2c:2a
> inet6 addr: fe80::944b:d9ff:fe10:b240/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
> collisions:0 txqueuelen:0
> RX bytes:0 (0.0 B) TX bytes:3377 (3.2 KiB)
>
> root@computer:~# ifconfig tap0
> tap0 Link encap:Ethernet HWaddr 02:07:b1:eb:2c:2a
> inet addr:192.168.10.0 Bcast:192.168.10.255 Mask:255.255.255.0
> inet6 addr: fe80::7:b1ff:feeb:2c2a/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:0 errors:0 dropped:278 overruns:0 carrier:0
> collisions:0 txqueuelen:500
> RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
>
> root@computer:~# ifconfig tap1
> tap1 Link encap:Ethernet HWaddr b2:ee:2c:f9:d5:0d
> inet6 addr: fe80::b0ee:2cff:fef9:d50d/64 Scope:Link
> UP BROADCAST RUNNING PROMISC MULTICAST MTU:1500 Metric:1
> RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> TX packets:0 errors:0 dropped:19 overruns:0 carrier:0
> collisions:0 txqueuelen:500
> RX bytes:0 (0.0 B) TX bytes:0 (0.0 B)
>
> The output of the brctl:
>
> root@computer:~# brctl show
> bridge name bridge id STP enabled interfaces
> pan0 8000.000000000000 no
> test 8000.0207b1eb2c2a no tap0
> tap1
> root@computer:~# brctl showmacs test
> port no mac addr is local? ageing timer
> 1 02:07:b1:eb:2c:2a yes 0.00
> 2 b2:ee:2c:f9:d5:0d yes 0.00
>
> The output of route:
>
> root@computer:/home/iszczesniak# route -n
> Kernel IP routing table
> Destination Gateway Genmask Flags Metric Ref Use Iface
> 192.168.2.0 0.0.0.0 255.255.255.0 U 2 0 0 eth1
> 192.168.10.0 0.0.0.0 255.255.255.0 U 0 0 0 tap0
> 169.254.0.0 0.0.0.0 255.255.0.0 U 1000 0 0 eth1
> 0.0.0.0 192.168.2.1 0.0.0.0 UG 0 0 0 eth1
>
> What am I doing wrong?
>
>
> Thanks,
> Irek
>


-- 
Ireneusz (Irek) Szczesniak
http://www.irkos.org
