Return-Path: <pablo@netfilter.org>
Date: Thu, 18 Jul 2019 20:24:30 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190718182430.6gqvhm6sjxta3p7s@salvia>
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

Applied, thanks Arnd.
