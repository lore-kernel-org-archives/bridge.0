Return-Path: <pablo@netfilter.org>
Date: Fri, 5 Jul 2019 22:45:21 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190705204521.u2mq22wt5h2u6nnr@salvia>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
	<1562332598-17415-4-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562332598-17415-4-git-send-email-wenxu@ucloud.cn>
Subject: Re: [Bridge] [PATCH 4/7 nf-next v2] netfilter: nft_meta_bridge: add
 NFT_META_BRI_IIFPVID support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn
Cc: nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:16:35PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> nft add table bridge firewall
> nft add chain bridge firewall zones { type filter hook prerouting priority - 300 \; }
> nft add rule bridge firewall zones counter ct zone set vlan id map { 100 : 1, 200 : 2 }
> 
> As above set the bridge port with pvid, the received packet don't contain
> the vlan tag which means the packet should belong to vlan 200 through pvid.
> With this pacth user can get the pvid of bridge ports.
> 
> So add the following rule for as the first rule in the chain of zones.
> 
> nft add rule bridge firewall zones counter meta vlan set meta briifpvid

Applied, thanks.
