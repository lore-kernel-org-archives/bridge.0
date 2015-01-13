Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Jan 2015 22:33:48 +0100
Message-ID: <4681500.x6CYopasp1@wuerfel>
In-Reply-To: <54B58AAC.7090001@gmail.com>
References: <56868207.rHBDZL3pbk@wuerfel>
	<20150113.155740.1237959632603319909.davem@davemloft.net>
	<54B58AAC.7090001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Bridge] [PATCH] bridge: only provide proxy ARP when
	CONFIG_INET is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>
Cc: cwang@twopensource.com, bridge@lists.linux-foundation.org, kyeyoonp@codeaurora.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>

On Tuesday 13 January 2015 14:14:20 David Ahern wrote:
> 
> Rather than connect CONFIG_BRIDGE to CONFIG_INET, why not make 
> br_do_proxy_arp (and setting BR_PROXYARP flag) a no-op if CONFIG_INET is 
> not set?
> 
> #ifdef CONFIG_INET
> #else
> static inline void br_do_proxy_arp(...args...)
> {
> }
> #endif
> 
> That covers both arp_tbl and arp_send.

The effect is very similar to my patch (probably same object code), the
only difference should be that it would add an ugly #ifdef instead of
the preferred IS_ENABLED() check, so you don't get any compile-time
coverage of the function. It's not really important because everybody
has CONFIG_INET enabled in practice and it does get more than enough
compile-time coverage.

	Arnd
