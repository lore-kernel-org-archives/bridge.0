Sender: seniorr@aracnet.com
From: seniorr@aracnet.com (Russell S. Senior)
Message-ID: <s4m1x1bubch.fsf@onyx.spiritone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] 802.11 bridging problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Sun, 20 Nov 2005 05:39:29 -0000
To: bridge@lists.osdl.org


I've got a problem with 802.11 bridging (they radios involved are in
WDS mode).  Basically the problem is managed (i.e. client) radio
interfaces that are part of a bridge see their sent packets twice
(once when they send and again when the master radio rebroadcasts).
In /var/log/messages I see:

  ath0: received packet with  own address as source address

It appears that perhaps these packets are confusing the bridge about
which MAC lives on which port and results in a failure to deliver
packets in the correct direction.  For example:

    A            B            C              D
 bridge:      bridge:      bridge:        host:
   eth0         eth0         eth0 --------- eth1
   ath0(cl)     ath0(ma)     ath0(cl)

Pings from D to A disappear in the ICMP reply direction when they get
to C.  They appear there but never show up at D.  Likewise, pings from
A to D disappear in the ICMP request direction when they get to C, and
never appear at D.  I say never, but actually they do sometimes, about
2% of the time.  Pings from D to B and vice versa are fine.  Even
pings from D to other hosts hanging off of B's eth0 are fine.

I'd like to figure out if I can somehow disregard the rebroadcasts or
at least not let them booger the bridge tables, if that's what they
are
doing.

Ideas how to better diagnose the problem are welcome.

Thanks!


-- 
Russell Senior         ``I have nine fingers; you have ten.''
seniorr@aracnet.com

