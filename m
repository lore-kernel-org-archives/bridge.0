Date: Sat, 4 Oct 2003 17:54:35 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Message-ID: <20031004155435.GB1174@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
	<p05111b00bba2061773df@[10.96.96.13]>
	<20031002160041.47053537.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002160041.47053537.shemminger@osdl.org>
Subject: [Bridge] Re: bridge breaks loopback on 2.4.22
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-net@vger.kernel.org, Hannes Schulz <schulz@schwaar.com>, marcelo.tosatti@cyclades.com, bridge@osdl.org

On Oct 02 2003, Stephen Hemminger wrote:
> When it fails are there any errors in the TCP stats or loopback driver?
> Look at 'netstat -s -p tcp' and 'netstat -i lo'

As you may have read in the message I have just replied to, the problem
seems solved in 1.4.23pre6 with the small patch to the bridge code that has
been applied, I'm commenting this at the end, first I'm pasting all the info
that I have recovered to try to find an explanation for this, I still search
an answer to how can this bug in the bridge affect the loopback :-?

First what drove me to say that packages were being lost in the loopback,
this is the output of a "tcpdump -n -i lo port 6000" when doing the netcat
to port 6000 where the other netcat is listening:

....
13:44:13.512372 127.0.0.1.6000 > 127.0.0.1.1028: . ack 3760129 win 32768 <nop,nop,timestamp 35089 35089> (DF)
13:44:13.720021 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 35110 35089> (DF)
13:44:14.140045 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 35152 35089> (DF)
13:44:14.980036 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 35236 35089> (DF)
13:44:16.660039 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 35404 35089> (DF)
13:44:20.020063 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 35740 35089> (DF)
13:44:26.740037 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 36412 35089> (DF)
13:44:40.180042 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 37756 35089> (DF)
13:45:07.060042 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 40444 35089> (DF)
13:46:00.820051 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 45820 35089> (DF)
13:47:48.340031 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 56572 35089> (DF)
13:49:48.340022 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 68572 35089> (DF)
13:51:48.340030 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 80572 35089> (DF)
13:53:48.340022 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 92572 35089> (DF)
13:55:48.340070 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 104572 35089> (DF)
13:57:48.340021 127.0.0.1.1028 > 127.0.0.1.6000: P 3801089:3817473(16384) ack 1 win 32767 <nop,nop,timestamp 116572 35089> (DF)

The one that is sending the info is the one on port 1028, he has already
sent some packages, then he receives an ack of his last package and tries to
send the next one, but it seems like the package never gets to the listener,
as there is no ack and the package is repeated all the time for more than 13
minutes.

This is what you asked for, the netstat info for tcp:
Tcp:
    9 active connections openings
    2 passive connection openings
    0 failed connection attempts
    1 connection resets received
    3 connections established
    4081 segments received
    5553 segments send out
    15 segments retransmited
    0 bad segments received.
    0 resets sent
TcpExt:
    6 TCP sockets finished time wait in fast timer
    82 delayed acks sent
    1 delayed acks further delayed because of locked socket
    65 packets directly queued to recvmsg prequeue.
    1294 of bytes directly received from prequeue
    3363 packet headers predicted
    1 packets header predicted and directly queued to user
    33 acknowledgments not containing data received
    2283 predicted acknowledgments
    0 TCP data loss events
    1 other TCP timeouts
    1 times receiver scheduled too late for direct processing
    1 connections aborted due to timeout

And this is the netstat info for the loopback:
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
lo    16436 0       909      0      0      0     909      0      0      0 LRU

The problem went away when I replaced the bridge code in 2.4.22 with the one
from 2.4.23-test6, so, after seing that this fixed the problem I did a diff
and found that the only diffs were just two lines:

diff -ru bridge.2422/br_forward.c bridge/br_forward.c
--- bridge.2422/br_forward.c	2002-08-03 02:39:46.000000000 +0200
+++ bridge/br_forward.c	2003-10-03 19:46:35.000000000 +0200
@@ -59,6 +59,7 @@
 
 	indev = skb->dev;
 	skb->dev = to->dev;
+	skb->ip_summed = CHECKSUM_NONE;
 
 	NF_HOOK(PF_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
 			__br_forward_finish);
diff -ru bridge.2422/br_stp_bpdu.c bridge/br_stp_bpdu.c
--- bridge.2422/br_stp_bpdu.c	2003-08-25 13:44:44.000000000 +0200
+++ bridge/br_stp_bpdu.c	2003-10-03 19:46:35.000000000 +0200
@@ -194,6 +194,6 @@
 	}
 
  err:
-	kfree(skb);
+	kfree_skb(skb);
 	return 0;
 }

So, now I'm asking myself, how can this bug that is fixed by these two lines
in the bridge code, be affecting my loopback?

Anybody can explain this, please?

Thanks in advance and thanks for all your help as well.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
