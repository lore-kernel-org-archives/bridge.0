Message-ID: <4069129E.2090500@quantec.de>
Date: Tue, 30 Mar 2004 08:24:30 +0200
From: Bernhard Gustl Bauer <gustl@quantec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] T-shaped bridge inhibits traffic insertion
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

I have built several bridges that are connected to a ring via wlan 
devices. To avoid the problems mentioned in FAQs i use tap-tunnels over 
the wlan links. So my bridge looks like this:

           eth0
            |
tap0 ---- br0 ----- tap1

When traffic is going from tap0 to tap1 it is almost impossible for eth0 
to insert traffic. Is there some priority concerning the traffic on an 
interface?

Is there a way to influence this behavior?

These are my settings:
[root@swa root]# brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             0014.0000cb2610f0       yes             eth0
                                                         tap0
                                                         tap1
[root@swa root]# brctl showstp br0
br0
  bridge id              0014.0000cb2610f0
  designated root        000a.0000cb260d44
  root port                 3                    path cost   100
  max age                  20.00                 bridge max age    20.00
  hello time                2.00                 bridge hello time     2.00
  forward delay            15.00                 bridge forward delay 
  15.00
  ageing time             300.00                 gc interval     4.00
  hello timer               0.00                 tcn timer     0.00
  topology change timer     0.00                 gc timer     0.61
  flags


eth0 (1)
  port id                8001                    state  forwarding
  designated root        000a.0000cb260d44       path cost    10
  designated bridge      0014.0000cb2610f0       message age timer     0.00
  designated port        8001                    forward delay timer 
  0.00
  designated cost         100                    hold timer     0.00
  flags

tap0 (2)
  port id                8002                    state  forwarding
  designated root        000a.0000cb260d44       path cost   100
  designated bridge      0014.0000cb2610f0       message age timer     0.00
  designated port        8002                    forward delay timer 
  0.00
  designated cost         100                    hold timer     0.00
  flags

tap1 (3)
  port id                8003                    state  forwarding
  designated root        000a.0000cb260d44       path cost   100
  designated bridge      000a.0000cb260d44       message age timer     1.36
  designated port        8003                    forward delay timer 
  0.00
  designated cost           0                    hold timer     0.00
  flags


TIA

Bernhard 'Gustl' Bauer

