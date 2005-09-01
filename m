Message-ID: <431750BD.2030505@trash.net>
Date: Thu, 01 Sep 2005 21:04:29 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: [Bridge] unregister_netdevice: waiting for br0 to become free.
	Usage count = 1 (2.6.12.3)
References: <8189B9F5-DF6E-4032-8D2D-D5301A02A081@axentra.net>
	<20050831213749.6bc8dd50@localhost.localdomain>
In-Reply-To: <20050831213749.6bc8dd50@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Robert Scott <rbscott@axentra.net>, bridge@lists.osdl.org

Stephen Hemminger wrote:
> Two other recent reports are:
> 1. Buggy applications that hold packets in their input queue forever,
>    and/or netfilters.  The socket buffer's contain a reference for
>    packets in flight.

skb->dev doesn't take a reference and is reset before packets are queued
to sockets. dst->dev however does hold a reference and is not reset,
perhaps we should change that.
