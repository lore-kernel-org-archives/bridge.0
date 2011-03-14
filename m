Date: Mon, 14 Mar 2011 14:29:08 -0700 (PDT)
Message-Id: <20110314.142908.179940791.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110307103406.27330529@nehalam>
References: <1649722795.14144.1299480074110.JavaMail.root@tahiti.vyatta.com>
	<4D748CC3.8060603@gmail.com> <20110307103406.27330529@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: control carrier based on ports online
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: fubar@us.ibm.com, pekkas@netcore.fi, nicolas.2p.debian@gmail.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, kuznet@ms2.inr.ac.ru, adamm@zombino.com

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Mon, 7 Mar 2011 10:34:06 -0800

> This makes the bridge device behave like a physical device.
> In earlier releases the bridge always asserted carrier. This
> changes the behavior so that bridge device carrier is on only
> if one or more ports are in the forwarding state. This
> should help IPv6 autoconfiguration, DHCP, and routing daemons.
> 
> I did brief testing with Network and Virt manager and they
> seem fine, but since this changes behavior of bridge, it should
> wait until net-next (2.6.39).
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

Applied to net-next-2.6, thanks Stephen.
