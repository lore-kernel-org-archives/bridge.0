Message-ID: <002101c3f5c2$cdd191b0$1910a8c0@Christy>
From: "AJM" <ameader@corp.Lcom.net>
Date: Tue, 17 Feb 2004 19:59:11 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Fedora 2.4.22-1.2166.nptl
Reply-To: AJM <ameader@corp.Lcom.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I'm having trouble applying ebtables-brnf-3_vs_2.4.22.diff to
2.4.22-1.2166.nptl. Applying the patch did not go well. Can anyone help me
with this? TIA.

Andy

Here is the output:

[root@specwall linux-2.4.22-1.2166.nptl]# patch -p1 <
../ebtables-brnf-3_vs_2.4.22.diff
patching file net/bridge/br_private.h
Reversed (or previously applied) patch detected!  Assume -R? [n] n
Apply anyway? [n] n
Skipping patch.
3 out of 3 hunks ignored -- saving rejects to file
net/bridge/br_private.h.rej
patching file include/linux/if_bridge.h
patching file net/core/dev.c
Hunk #1 succeeded at 1433 (offset 7 lines).
Hunk #3 FAILED at 1502.
1 out of 3 hunks FAILED -- saving rejects to file net/core/dev.c.rej
patching file net/bridge/br_input.c
Hunk #2 FAILED at 49.
1 out of 4 hunks FAILED -- saving rejects to file net/bridge/br_input.c.rej
patching file net/bridge/br_forward.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 52.
Hunk #3 FAILED at 67.
3 out of 3 hunks FAILED -- saving rejects to file
net/bridge/br_forward.c.rej
patching file net/bridge/br.c
Hunk #2 succeeded at 48 with fuzz 2 (offset 3 lines).
Hunk #3 FAILED at 70.
Hunk #4 succeeded at 85 (offset 2 lines).
1 out of 4 hunks FAILED -- saving rejects to file net/bridge/br.c.rej
patching file net/bridge/Makefile
Hunk #1 FAILED at 7.
1 out of 1 hunk FAILED -- saving rejects to file net/bridge/Makefile.rej
patching file include/linux/netfilter_bridge.h
patching file net/Makefile
Hunk #1 FAILED at 7.
Hunk #2 FAILED at 27.
2 out of 2 hunks FAILED -- saving rejects to file net/Makefile.rej
patching file net/Config.in
Hunk #1 succeeded at 66 with fuzz 1 (offset 1 line).
patching file net/bridge/netfilter/Makefile
patching file net/bridge/netfilter/Config.in
patching file net/bridge/netfilter/ebtable_filter.c
patching file net/bridge/netfilter/ebtable_nat.c
patching file net/bridge/netfilter/ebtable_broute.c
patching file net/bridge/netfilter/ebt_among.c
patching file net/bridge/netfilter/ebt_limit.c
patching file net/bridge/netfilter/ebt_arpreply.c
patching file net/bridge/netfilter/ebt_802_3.c
patching file net/bridge/netfilter/ebt_mark.c
patching file net/bridge/netfilter/ebt_mark_m.c
patching file net/bridge/netfilter/ebt_pkttype.c
patching file net/bridge/netfilter/ebt_stp.c
patching file net/bridge/netfilter/ebt_redirect.c
patching file net/bridge/netfilter/ebt_arp.c
patching file net/bridge/netfilter/ebt_ip.c
patching file net/bridge/netfilter/ebt_vlan.c
patching file net/bridge/netfilter/ebt_log.c
patching file net/bridge/netfilter/ebt_snat.c
patching file net/bridge/netfilter/ebt_dnat.c
patching file net/bridge/netfilter/ebtables.c
patching file include/linux/netfilter_bridge/ebtables.h
patching file include/linux/netfilter_bridge/ebt_among.h
patching file include/linux/netfilter_bridge/ebt_limit.h
patching file include/linux/netfilter_bridge/ebt_arpreply.h
patching file include/linux/netfilter_bridge/ebt_802_3.h
patching file include/linux/netfilter_bridge/ebt_arp.h
patching file include/linux/netfilter_bridge/ebt_ip.h
patching file include/linux/netfilter_bridge/ebt_pkttype.h
patching file include/linux/netfilter_bridge/ebt_stp.h
patching file include/linux/netfilter_bridge/ebt_vlan.h
patching file include/linux/netfilter_bridge/ebt_log.h
patching file include/linux/netfilter_bridge/ebt_nat.h
patching file include/linux/netfilter_bridge/ebt_redirect.h
patching file include/linux/netfilter_bridge/ebt_mark_m.h
patching file include/linux/netfilter_bridge/ebt_mark_t.h
patching file include/linux/netfilter.h
Hunk #1 FAILED at 118.
1 out of 1 hunk FAILED -- saving rejects to file
include/linux/netfilter.h.rej
patching file include/linux/netfilter_ipv4.h
Hunk #1 FAILED at 52.
1 out of 1 hunk FAILED -- saving rejects to file
include/linux/netfilter_ipv4.h.rej
patching file include/linux/skbuff.h
Hunk #3 succeeded at 1188 (offset 2 lines).
patching file net/core/netfilter.c
Reversed (or previously applied) patch detected!  Assume -R? [n] n
Apply anyway? [n] n
Skipping patch.
7 out of 7 hunks ignored -- saving rejects to file net/core/netfilter.c.rej
patching file net/core/skbuff.c
patching file net/ipv4/netfilter/ip_tables.c
Hunk #1 FAILED at 121.
Hunk #2 FAILED at 163.
Hunk #3 FAILED at 184.
Hunk #4 FAILED at 291.
Hunk #5 FAILED at 303.
Hunk #6 FAILED at 345.
6 out of 6 hunks FAILED -- saving rejects to file
net/ipv4/netfilter/ip_tables.c.rej
patching file net/ipv4/ip_output.c
Hunk #1 succeeded at 884 (offset 2 lines).
patching file net/ipv4/netfilter/ipt_LOG.c
Hunk #1 FAILED at 289.
1 out of 1 hunk FAILED -- saving rejects to file
net/ipv4/netfilter/ipt_LOG.c.rej
patching file net/ipv4/netfilter/Makefile
patching file net/ipv4/netfilter/Config.in
The next patch would create the file net/bridge/br_netfilter.c,
which already exists!  Assume -R? [n] n
Apply anyway? [n] n
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file
net/bridge/br_netfilter.c.rej
patching file net/ipv4/netfilter/ipt_physdev.c
patching file include/linux/netfilter_ipv4/ipt_physdev.h
patching file net/8021q/vlan_dev.c
Hunk #1 succeeded at 507 (offset 4 lines).
[root@specwall linux-2.4.22-1.2166.nptl]#

