Date: Fri, 13 May 2011 16:03:37 -0400 (EDT)
Message-Id: <20110513.160337.577278090119895974.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110513125314.66861b31@nehalam>
References: <20110510151100.52a9f8fa@nehalam>
	<20110510233540.GJ6397@morgul.net>
	<20110513125314.66861b31@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: fix forwarding of IPv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: herbert@gondor.hengli.com.au, noahm@debian.org, bridge@lists.linux-foundation.org, ben@decadent.org.uk, netdev@vger.kernel.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Fri, 13 May 2011 12:53:14 -0700

> The commit 6b1e960fdbd75dcd9bcc3ba5ff8898ff1ad30b6e
>     bridge: Reset IPCB when entering IP stack on NF_FORWARD
> broke forwarding of IPV6 packets in bridge because it would
> call bp_parse_ip_options with an IPV6 packet.
> 
> Reported-by: Noah Meyerhans <noahm@debian.org>
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> ---
> Patch against net-next-2.6 but must be applied to net-2.6
> and stable as well

Applied and queued up for -stable, thanks!
