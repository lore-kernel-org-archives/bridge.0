Return-Path: <davem@davemloft.net>
Date: Thu, 27 Aug 2015 16:39:09 -0700 (PDT)
Message-Id: <20150827.163909.1905886152046450354.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1440710360-5390-1-git-send-email-razor@blackwall.org>
References: <1440710360-5390-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: fdb: rearrange
	net_bridge_fdb_entry
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 27 Aug 2015 14:19:20 -0700

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> While looking into fixing the local entries scalability issue I noticed
> that the structure is badly arranged because vlan_id would fall in a
> second cache line while keeping rcu which is used only when deleting
> in the first, so re-arrange the structure and push rcu to the end so we
> can get 16 bytes which can be used for other fields (by pushing rcu
> fully in the second 64 byte chunk). With this change all the core
> necessary information when doing fdb lookups will be available in a
> single cache line.
 ...
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

This looks fine, applied, thanks.
