Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Ye3yd8bgdIkq+SC6Q05DOdjpk3FqlBkZBdt9NNak82A=;
	b=PGSGbNq58cfDCBRxU6NLSQ6Psx45eMq10WvlAY4E6S5+kQ6Fo4IlCZT+FY5q6SyGYi
	wRxUec1+7r2jPs+8rpc5rPvtP3BgbDkP7THGRBqteBZx1bk2iVZSBrO1oZZ6llfJN+E5
	GkLBJuJNW0JnJVqHA9whAba4pjndERNW7gS2g=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 23 Jul 2018 11:16:57 +0300
Message-Id: <20180723081659.21986-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 0/2] net: bridge: add support for
	backup port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

Hi,
This set introduces a new bridge port option that allows any port to have
any other port (in the same bridge of course) as its backup and traffic
will be forwarded to the backup port when the primary goes down. This is
mainly used in MLAG and EVPN setups where we have peerlink path which is
a backup of many (or even all) ports and is a participating bridge port
itself. There's more detailed information in patch 02. Patch 01 just
prepares the port sysfs code for options that take raw value. The main
issues that this set solves are scalability and fallback latency.

We have used similar code for over 6 months now to bring the fallback
latency of the backup peerlink down and avoid fdb notification storms.
Also due to the nature of master devices such setup is currently not
possible, and last but not least having tens of thousands of fdbs require
thousands of calls to switch.

I've also CCed our MLAG experts that have been using similar option.

Roopa also adds:

"Two switches acting in a MLAG pair are connected by the peerlink
interface which is a bridge port.

the config on one of the switches looks like the below. The other
switch also has a similar config.
eth0 is connected to one port on the server. And the server is
connected to both switches.

br0 -- team0---eth0
      |
      -- switch-peerlink

switch-peerlink becomes the failover/backport port when say team0 to
the server goes down.
Today, when team0 goes down, control plane has to withdraw all the fdb
entries pointing to team0
and re-install the fdb entries pointing to switch-peerlink...and
restore the fdb entries when team0 comes back up again.
and  this is the problem we are trying to solve.

This also becomes necessary when multihoming is implemented by a
standard like E-VPN https://tools.ietf.org/html/rfc8365#section-8
where the 'switch-peerlink' is an overlay vxlan port (like nikolay
mentions in his patch commit). In these implementations, the fdb scale
can be much larger.

On why bond failover cannot be used here ?: the point that nikolay was
alluding to is, switch-peerlink in the above example is a bridge port
and is a failover/backport port for more than one or all ports in the
bridge br0. And you cannot enslave switch-peerlink into a second level
team
with other bridge ports. Hence a multi layered team device is not an
option (FWIW, switch-peerlink is also a teamed interface to the peer
switch)."

v3: Added Roopa's explanation and diagram
v2: In patch 01 use kstrdup/kfree to avoid casting the const buf. In order
to avoid using GFP_ATOMIC or always allocating I kept the spinlock inside
each branch.

Thanks,
 Nik


Nikolay Aleksandrov (2):
  net: bridge: add support for raw sysfs port options
  net: bridge: add support for backup port

 include/uapi/linux/if_link.h |  1 +
 net/bridge/br_forward.c      | 16 +++++++-
 net/bridge/br_if.c           | 53 ++++++++++++++++++++++++++
 net/bridge/br_netlink.c      | 30 ++++++++++++++-
 net/bridge/br_private.h      |  3 ++
 net/bridge/br_sysfs_if.c     | 89 +++++++++++++++++++++++++++++++++++++-------
 6 files changed, 176 insertions(+), 16 deletions(-)

-- 
2.11.0

