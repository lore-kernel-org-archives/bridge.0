Sender: seniorr@aracnet.com
From: seniorr@aracnet.com (Russell S. Senior)
Date: 10 Nov 2007 18:31:20 -0800
Message-ID: <s4mode1tsw7.fsf@onyx.spiritone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] WDS STP weirdness
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


I am doing some testing of openwrt'd wireless access points, using
madwifi-ng'd atheros radios.  In the test configuration, I have three
devices in a triangle, each has wds links to the other two devices.
The ath0 interface is in ap mode, ath1 is a wds link to one device,
and ath2 is a wds link to the other device.  All three interfaces (and
an ethernet interface) are in a bridge (br-lan) with STP on.  The
weird thing is that STP doesn't seem to ever block ports.  The same
firmware is on all three devices, a 2.6.23.1 kernel built from a r9512
checkout of openwrt's SVN repository.

If I sniff the wds interfaces (ath1 and ath2) with tcpdump, I see STP
packets, e.g.:

  <timestamp> STP 802.1d, Config, Flags [none], bridge-id 8000.<macaddr>

where ath1 and ath2 show the STP packets with the local bridge-id, and
ath1 *also* shows STP packets from the bridge-id of the bridge on the
other side of the ath1 wds link.  ath2 does not show a second bridge-id.

The network is not completely stable.  It gets out of whack
occasionally (under not-fully-characterized conditions) and doesn't
come back by itself, requiring strategic (random) power cycling until
it works again.  

Clues?


device 10.11.63.4:

   $ brctl show
   bridge name     bridge id               STP enabled     interfaces
   br-lan          8000.00095bf7938d       yes             eth0.0
                                                           ath0
                                                           ath1
                                                           ath2

   $ brctl showstp br-lan
   br-lan
    bridge id              8000.00095bf7938d
    designated root        8000.00095bf7938d
    root port                 0                    path cost                  0
    max age                  20.00                 bridge max age            50.00
    hello time                2.00                 bridge hello time          5.00
    forward delay             0.00                 bridge forward delay       0.00
    ageing time             300.00
    hello timer               1.26                 tcn timer                  0.00
    topology change timer     0.00                 gc timer                   0.26
    flags                  


   eth0.0 (1)
    port id                8001                    state                forwarding
    designated root        8000.00095bf7938d       path cost                100
    designated bridge      8000.00095bf7938d       message age timer          0.00
    designated port        8001                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.25
    flags                  

   ath0 (2)
    port id                8002                    state                forwarding
    designated root        8000.00095bf7938d       path cost                100
    designated bridge      8000.00095bf7938d       message age timer          0.00
    designated port        8002                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.24
    flags                  

   ath1 (3)
    port id                8003                    state                forwarding
    designated root        8000.00095bf7938d       path cost                100
    designated bridge      8000.00095bf7938d       message age timer          0.00
    designated port        8003                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.23
    flags                  

   ath2 (4)
    port id                8004                    state                forwarding
    designated root        8000.00095bf7938d       path cost                100
    designated bridge      8000.00095bf7938d       message age timer          0.00
    designated port        8004                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.22
    flags                  

device 10.11.63.5:

   $ brctl show
   bridge name     8000.000fb50e69e9       yes             eth0.0
                                                           ath0
                                                           ath1
                                                           ath2

   $ brctl showstp br-lan
   br-lan
    bridge id              8000.000fb50e69e9
    designated root        8000.000fb50e69e9
    root port                 0                    path cost                  0
    max age                  20.00                 bridge max age            50.00
    hello time                2.00                 bridge hello time          5.00
    forward delay             0.00                 bridge forward delay       0.00
    ageing time             300.00
    hello timer               1.68                 tcn timer                  0.00
    topology change timer     0.00                 gc timer                   0.68
    flags                  


   eth0.0 (1)
    port id                8001                    state                forwarding
    designated root        8000.000fb50e69e9       path cost                100
    designated bridge      8000.000fb50e69e9       message age timer          0.00
    designated port        8001                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.66
    flags                  

   ath0 (2)
    port id                8002                    state                forwarding
    designated root        8000.000fb50e69e9       path cost                100
    designated bridge      8000.000fb50e69e9       message age timer          0.00
    designated port        8002                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.66
    flags                  

   ath1 (3)
    port id                8003                    state                forwarding
    designated root        8000.000fb50e69e9       path cost                100
    designated bridge      8000.000fb50e69e9       message age timer          0.00
    designated port        8003                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.65
    flags                  

   ath2 (4)
    port id                8004                    state                forwarding
    designated root        8000.000fb50e69e9       path cost                100
    designated bridge      8000.000fb50e69e9       message age timer          0.00
    designated port        8004                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.64
    flags                  

device 10.11.63.6:

   $ brctl show
   bridge name     bridge id               STP enabled     interfaces
   br-lan          8000.000fb50e4fc4       yes             eth0.0
                                                           ath0
                                                           ath1
                                                           ath2
   $ brctl showstp br-lan
   br-lan
    bridge id              8000.000fb50e4fc4
    designated root        8000.000fb50e4fc4
    root port                 0                    path cost                  0
    max age                  20.00                 bridge max age            50.00
    hello time                2.00                 bridge hello time          5.00
    forward delay             0.00                 bridge forward delay       0.00
    ageing time             300.00
    hello timer               1.81                 tcn timer                  0.00
    topology change timer     0.00                 gc timer                   0.81
    flags                  


   eth0.0 (1)
    port id                8001                    state                forwarding
    designated root        8000.000fb50e4fc4       path cost                100
    designated bridge      8000.000fb50e4fc4       message age timer          0.00
    designated port        8001                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.79
    flags                  

   ath0 (2)
    port id                8002                    state                forwarding
    designated root        8000.000fb50e4fc4       path cost                100
    designated bridge      8000.000fb50e4fc4       message age timer          0.00
    designated port        8002                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.78
    flags                  

   ath1 (3)
    port id                8003                    state                forwarding
    designated root        8000.000fb50e4fc4       path cost                100
    designated bridge      8000.000fb50e4fc4       message age timer          0.00
    designated port        8003                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.76
    flags                  

   ath2 (4)
    port id                8004                    state                forwarding
    designated root        8000.000fb50e4fc4       path cost                100
    designated bridge      8000.000fb50e4fc4       message age timer          0.00
    designated port        8004                    forward delay timer        0.00
    designated cost           0                    hold timer                 0.76
    flags                  


-- 
Russell Senior         ``I have nine fingers; you have ten.''
seniorr@aracnet.com
