Return-Path: <leonardo@linux.ibm.com>
From: Leonardo Bras <leonardo@linux.ibm.com>
Date: Fri, 30 Aug 2019 15:13:52 -0300
Message-Id: <20190830181354.26279-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 0/2] Drop IPV6 packets if IPv6 is disabled on
	boot
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Florian Westphal <fw@strlen.de>, Jozsef Kadlecsik <kadlec@netfilter.org>, Leonardo Bras <leonardo@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

This patchset was prevously a single patch named:
- netfilter: nf_tables: fib: Drop IPV6 packets if IPv6 is disabled on boot

It fixes a bug where a host, with IPv6 disabled on boot, has to deal with
guest IPv6 packets, that comes from a bridge interface.
When these packets reach the host ip6tables they cause a kernel panic.

---
Changes from v3:
- Move drop logic from nft_fib6_eval{,_type} to nft_fib_netdev_eval
- Add another patch to drop ipv6 packets from bridge when ipv6 disabled  

Changes from v2:
- Replace veredict.code from NF_DROP to NFT_BREAK
- Updated commit message (s/package/packet)

Changes from v1:
- Move drop logic from nft_fib_inet_eval() to nft_fib6_eval{,_type}
so it can affect other usages of these functions.

Leonardo Bras (2):
  netfilter: Terminate rule eval if protocol=IPv6 and ipv6 module is
    disabled
  net: br_netfiler_hooks: Drops IPv6 packets if IPv6 module is not
    loaded

 net/bridge/br_netfilter_hooks.c | 2 ++
 net/netfilter/nft_fib_netdev.c  | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.20.1

