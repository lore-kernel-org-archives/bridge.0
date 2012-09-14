Return-Path: <auto75914331@hushmail.com>
MIME-Version: 1.0
Date: Fri, 14 Sep 2012 21:03:24 +0300
From: auto75914331@hushmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"
Message-Id: <20120914180324.E51B26F448@smtp.hushmail.com>
Subject: Re: [Bridge] [PATCH V2] netfilter/iptables: Fix log-level processing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bart De Schuymer <bart.de.schuymer@pandora.be>, netfilter-devel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, Patrick McHardy <kaber@trash.net>, Pablo Neira Ayuso <pablo@netfilter.org>

thanks, propably works, will not test



On 12.09.2012 at 3:05 PM, Joe Perches <joe@perches.com> wrote:
>
>auto75914331@hushmail.com reports that iptables does not correctly
>output the KERN_<level>.
>
>$IPTABLES -A RULE_0_in  -j LOG  --log-level notice --log-prefix 
>"DENY  in: "
>
>result with linux 3.6-rc5
>Sep 12 06:37:29 xxxxx kernel: <5>DENY  in: IN=eth0 OUT= MAC=.......
>
>result with linux 3.5.3 and older:
>Sep  9 10:43:01 xxxxx kernel: DENY  in: IN=eth0 OUT= MAC......
>
>commit 04d2c8c83d0
>("printk: convert the format for KERN_<LEVEL> to a 2 byte pattern")
>updated the syslog header style but did not update netfilter uses.
>
>Do so.
>
>Signed-off-by: Joe Perches <joe@perches.com>
>cc: auto75914331@hushmail.com
>---
>v2: Use KERN_SOH and string concatenation instead of "%c" 
>KERN_SOH_ASCII
>as suggested by Eric Dumazet.
>
> net/bridge/netfilter/ebt_log.c |    2 +-
> net/netfilter/xt_LOG.c         |    4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/bridge/netfilter/ebt_log.c 
>b/net/bridge/netfilter/ebt_log.c
>index f88ee53..92de5e5 100644
>--- a/net/bridge/netfilter/ebt_log.c
>+++ b/net/bridge/netfilter/ebt_log.c
>@@ -80,7 +80,7 @@ ebt_log_packet(u_int8_t pf, unsigned int hooknum,
> 	unsigned int bitmask;
> 
> 	spin_lock_bh(&ebt_log_lock);
>-	printk("<%c>%s IN=%s OUT=%s MAC source = %pM MAC dest = %pM 
>proto = 0x%04x",
>+	printk(KERN_SOH "%c%s IN=%s OUT=%s MAC source = %pM MAC dest = 
>%pM proto = 0x%04x",
> 	       '0' + loginfo->u.log.level, prefix,
> 	       in ? in->name : "", out ? out->name : "",
> 	       eth_hdr(skb)->h_source, eth_hdr(skb)->h_dest,
>diff --git a/net/netfilter/xt_LOG.c b/net/netfilter/xt_LOG.c
>index ff5f75f..d1609dd 100644
>--- a/net/netfilter/xt_LOG.c
>+++ b/net/netfilter/xt_LOG.c
>@@ -436,8 +436,8 @@ log_packet_common(struct sbuff *m,
> 		  const struct nf_loginfo *loginfo,
> 		  const char *prefix)
> {
>-	sb_add(m, "<%d>%sIN=%s OUT=%s ", loginfo->u.log.level,
>-	       prefix,
>+	sb_add(m, KERN_SOH "%c%sIN=%s OUT=%s ",
>+	       '0' + loginfo->u.log.level, prefix,
> 	       in ? in->name : "",
> 	       out ? out->name : "");
> #ifdef CONFIG_BRIDGE_NETFILTER

