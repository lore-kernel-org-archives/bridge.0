Return-Path: <davem@davemloft.net>
Date: Fri, 05 May 2017 11:22:44 -0400 (EDT)
Message-Id: <20170505.112244.1416767855257763172.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170505143653.8486-1-tklauser@distanz.ch>
References: <20170505143653.8486-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: netlink: account for
 IFLA_BRPORT_{B, M}CAST_FLOOD size and policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: tklauser@distanz.ch
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com, mmanning@brocade.com

From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri,  5 May 2017 16:36:53 +0200

> The attribute sizes for IFLA_BRPORT_MCAST_FLOOD and
> IFLA_BRPORT_BCAST_FLOOD weren't accounted for in br_port_info_size()
> when they were added. Do so now and also add the corresponding policy
> entries:
> 
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: Mike Manning <mmanning@brocade.com>
> Fixes: b6cb5ac8331b ("net: bridge: add per-port multicast flood flag")
> Fixes: 99f906e9ad7b ("bridge: add per-port broadcast flood flag")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied and queued up for -stable, thanks.
