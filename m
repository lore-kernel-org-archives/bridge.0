Return-Path: <davem@davemloft.net>
Date: Sun, 03 Feb 2019 11:40:05 -0800 (PST)
Message-Id: <20190203.114005.1068563409105929462.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190202042055.27202-1-f.fainelli@gmail.com>
References: <20190202042055.27202-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: Fix ip_mc_{dec,
 inc}_group allocation context
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: andrew@lunn.ch, sbrivio@redhat.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org, liuhangbin@gmail.com, kuznet@ms2.inr.ac.ru

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  1 Feb 2019 20:20:52 -0800

> After 4effd28c1245 ("bridge: join all-snoopers multicast address"), I
> started seeing the following sleep in atomic warnings:
 ...
> while toggling the bridge's multicast_snooping attribute dynamically.
> 
> Pass a gfp_t down to igmpv3_add_delrec(), introduce
> __igmp_group_dropped() and introduce __ip_mc_dec_group() to take a gfp_t
> argument.
> 
> Similarly introduce ____ip_mc_inc_group() and __ip_mc_inc_group() to
> allow caller to specify gfp_t.
> 
> IPv6 part of the patch appears fine.
> 
> Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

Maybe you could submit a quick test case since you had a reproducer?
