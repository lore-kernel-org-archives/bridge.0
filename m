Date: Sun, 22 Feb 2009 13:32:49 +0100
From: Udo Hortian <udo_hortian@web.de>
Message-ID: <20090222123249.GA21690@an>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: udo_hortian@web.de
Subject: [Bridge] Bridging problems after Upgrade to Debian Lenny
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello all,

I subscribed newly to this list, since I got an bridging problem after an
upgrade from Debian etch to Debian lenny (before everything worked fine).

The situation is as follows:

# brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.000347729835       no              eth0
                                                        tap0

tap0 is associated with an OpenVPN tunnel.

The strange thing now is the following:

Packets from eth0 to IP addresses within tap0 pass the bridge and reach
the destination (the other side of an OpenVPN tunnel).

But packets from the other side of the OpenVPN tunnel do not reach
destinations behind eth0. I think this is not an OpenVPN problem, since
I can see packets, as described here, using "tcpdump -i tap0" and also
using "tcpdump -i br0". But I do not see them using "tcpdump -i eth0".

The only thing which happens is that there are sometimes packets like
this on eth0: "igmp v3 report, 1 group record(s)" (from tcpdump) with
source address the one from the OpenVPN client. I do now know where
these packets come from.

There is now firewall activated.

Here are a few informations about my system:
Debian lenny
Linux 2.6.18-6-686 (Debian Kernel)
bridge-utils 1.4-5 (Debian packet)

Any ideas what might be the reason for this and how to solve it?

Best regards
Udo
