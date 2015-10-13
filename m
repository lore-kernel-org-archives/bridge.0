Return-Path: <davem@davemloft.net>
Date: Mon, 12 Oct 2015 19:59:33 -0700 (PDT)
Message-Id: <20151012.195933.1620669188577531568.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1444560596-7140-1-git-send-email-razor@blackwall.org>
References: <20151011071208.GA2188@nanopsycho.orion>
	<1444560596-7140-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: vlan: enforce no pvid flag in
 vlan ranges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, eladr@mellanox.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun, 11 Oct 2015 12:49:56 +0200

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Currently it's possible for someone to send a vlan range to the kernel
> with the pvid flag set which will result in the pvid bouncing from a
> vlan to vlan and isn't correct, it also introduces problems for hardware
> where it doesn't make sense having more than 1 pvid. iproute2 already
> enforces this, so let's enforce it on kernel-side as well.
> 
> Reported-by: Elad Raz <eladr@mellanox.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied, thanks.
