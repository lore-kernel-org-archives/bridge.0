Return-Path: <davem@davemloft.net>
Date: Mon, 24 Feb 2020 11:13:55 -0800 (PST)
Message-Id: <20200224.111355.456289899614012541.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200224164622.1472051-1-nikolay@cumulusnetworks.com>
References: <83cadec7-d659-cf2a-c0c0-a85d2f6503bc@cumulusnetworks.com>
 <20200224164622.1472051-1-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: fix stale eth hdr pointer
 in br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 24 Feb 2020 18:46:22 +0200

> In br_dev_xmit() we perform vlan filtering in br_allowed_ingress() but
> if the packet has the vlan header inside (e.g. bridge with disabled
> tx-vlan-offload) then the vlan filtering code will use skb_vlan_untag()
> to extract the vid before filtering which in turn calls pskb_may_pull()
> and we may end up with a stale eth pointer. Moreover the cached eth header
> pointer will generally be wrong after that operation. Remove the eth header
> caching and just use eth_hdr() directly, the compiler does the right thing
> and calculates it only once so we don't lose anything.
> 
> Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
> v2: remove syzbot's reported-by tag, this seems to be a different bug

Applied and queued up for -stable, thanks Nikolay.
