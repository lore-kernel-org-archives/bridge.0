Date: Sun, 1 Aug 2004 14:46:30 +0200
From: Matthias Andree <matthias.andree@gmx.de>
Message-ID: <20040801124629.GA11603@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] Bridge not bridging NFS fragments?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: Matthias Andree <matthias.andree@gmx.de>

Hi,

please Cc: all replies, I'm not subscribed

I seem to have troubles with my Linux bridge (2.6.8-rc2), which is
apparently not bridging UDP fragments (NFS) when passing packets through
iptables, but I do not see in the iptables stats where the packets are
dropped. Policies for INPUT, FORWARD, OUTPUT are all "ACCEPT", and I
grepped for all REJECT and DROP rules in iptables -nvL, their counters
are constant, i. e. they aren't rejecting or dropping packets.

Setup:

FreeBSD5                 Linux Bridge                   FreeBSD4
    xl0  ----10base2---- eth2    eth0 ----100baseTx---- fxp0

The FreeBSD machines are attempting to talk NFS with each other, the
machine on the left sends a read request, which is bridged, and the
machine on the right sends a fragmented UDP packet of 8K, this is as
observed on eth0:

14:33:59.320397 192.168.0.49.1749359354 > 192.168.0.2.2049: 108 read fh 985,985790/5042 8192 bytes @ 0x000000000
14:33:59.321676 192.168.0.2.2049 > 192.168.0.49.1749359354: reply ok 1472 read (frag 8235:1480@0+)
14:33:59.321798 192.168.0.2 > 192.168.0.49: (frag 8235:1480@1480+)
14:33:59.321922 192.168.0.2 > 192.168.0.49: (frag 8235:1480@2960+)
14:33:59.322044 192.168.0.2 > 192.168.0.49: (frag 8235:1480@4440+)
14:33:59.322169 192.168.0.2 > 192.168.0.49: (frag 8235:1480@5920+)
14:33:59.322215 192.168.0.2 > 192.168.0.49: (frag 8235:928@7400)

This traffic will only appear on the other interface when
bridge-nf-call-iptables is 0.

Am I missing something in my setup; what kernel options should I check,
or is there some incompatibility between bridge-nf-call-iptables and
fragmented traffic?

.config options containing BRIDGE are:

CONFIG_BRIDGE_NETFILTER=y
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_BRIDGE=y

Thanks in advance,

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
