From: Butorina Lilya <lilybox@yandex.ru>
MIME-Version: 1.0
Message-Id: <28201263284132@webmail50.yandex.ru>
Date: Tue, 12 Jan 2010 11:15:32 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Bridge] Time of topology change in root bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi.

I have two bridges with RSTP:

     hdlc0------hdlc0
br0 |                | br1
     hdlc1------hdlc1

br0 is root bridge.

And my initial tree topology:
#rstpctl showport br0
*    hdlc0 8001 Fwd  8000-00ee10022202 8000-00ee10022202 8001 D
*    hdlc1 8002 Fwd  8000-00ee10022202 8000-00ee10022202 8002 D

#rstpctl showport br1
*    hdlc0 8001 Blk  8000-00ee10022202 8000-00ee10022202 8002 R
*    hdlc1 8002 Fwd  8000-00ee10022202 8000-00ee10022202 8001 A


Next I break link on br1 on root port hdlc0 and get new three topology immedatly:
#rstpctl showport br0
*    hdlc0 8001 Dis  8000-00ee10022202 8000-00ee10022202 8001
*    hdlc1 8002 Fwd  8000-00ee10022202 8000-00ee10022202 8002 D

#rstpctl showport br1
*    hdlc0 8001 Dis  8000-00ee10022202 8000-00ee10022202 8002 
*    hdlc1 8002 Fwd  8000-00ee10022202 8000-00ee10022202 8001 R


Next I restore link. 
Here I expect that bouth bridges calculate new (initial) tree topology in 4sec.

I see expected on br1:
*    hdlc0 8001 Blk  8000-00ee10022202 8000-00ee10022202 8002 R
*    hdlc1 8002 Fwd  8000-00ee10022202 8000-00ee10022202 8001 A

But on root bridge br0 I see new tree topology in 30sec.
This time interval looks like STP value.

Is this correct behavior of RSTP or bug?


Thanks. 
Lilya.
