Return-Path: <pablo@netfilter.org>
Date: Thu, 18 Jul 2019 21:01:10 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190718190110.akn54iwb2mui72cd@salvia>
References: <20190710080835.296696-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710080835.296696-1-arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] [net-next] netfilter: bridge: make
 NF_TABLES_BRIDGE tristate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: wenxu <wenxu@ucloud.cn>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 10, 2019 at 10:08:20AM +0200, Arnd Bergmann wrote:
> The new nft_meta_bridge code fails to link as built-in when NF_TABLES
> is a loadable module.
> 
> net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_eval':
> nft_meta_bridge.c:(.text+0x1e8): undefined reference to `nft_meta_get_eval'
> net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_get_init':
> nft_meta_bridge.c:(.text+0x468): undefined reference to `nft_meta_get_init'
> nft_meta_bridge.c:(.text+0x49c): undefined reference to `nft_parse_register'
> nft_meta_bridge.c:(.text+0x4cc): undefined reference to `nft_validate_register_store'
> net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_module_exit':
> nft_meta_bridge.c:(.exit.text+0x14): undefined reference to `nft_unregister_expr'
> net/bridge/netfilter/nft_meta_bridge.o: In function `nft_meta_bridge_module_init':
> nft_meta_bridge.c:(.init.text+0x14): undefined reference to `nft_register_expr'
> net/bridge/netfilter/nft_meta_bridge.o:(.rodata+0x60): undefined reference to `nft_meta_get_dump'
> net/bridge/netfilter/nft_meta_bridge.o:(.rodata+0x88): undefined reference to `nft_meta_set_eval'
> 
> This can happen because the NF_TABLES_BRIDGE dependency itself is just a
> 'bool'.  Make the symbol a 'tristate' instead so Kconfig can propagate the
> dependencies correctly.

Hm. Something breaks here. Investigating. Looks like bridge support is
gone after this, nft fails to register the filter chain type:

# nft add table bridge x
# nft add chain bridge x y { type filter hook input priority 0\; }
Error: Could not process rule: No such file or directory
