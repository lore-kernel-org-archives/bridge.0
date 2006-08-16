Date: Wed, 16 Aug 2006 11:03:21 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060816110321.54a7c66d@localhost.localdomain>
In-Reply-To: <003601c6c0e4$72058a40$6514a8c0@home.djasolutions.com>
References: <003601c6c0e4$72058a40$6514a8c0@home.djasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] VLAN handling in br_netfilter.c:br_nf_pre_routing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jon Sjoberg <jsjoberg@djasolutions.com>
Cc: bridge@osdl.org

On Tue, 15 Aug 2006 23:31:21 -0400
"Jon Sjoberg" <jsjoberg@djasolutions.com> wrote:

> Hi all,
> 
> Noticed that br_nf_pre_routing has some code to handle VLANs, but does not
> update the nh header.  This appears to cause the IP validity checks to fail
> (i.e. "if (iph->ihl < 5...").
> 
> There is a check:
> if (skb->protocol == __constant_htons(ETH_P_8021Q)){
> sk_pull(skb, VLAN_HLEN);
> }
> 
> If this was changed to:
> if (skb->protocol == __constant_htons(ETH_P_8021Q)){
> sk_pull(skb, VLAN_HLEN);
> skb->nh.raw += VLAN_HLEN;
> }
> 
> the checks pass.  Note that this updated behavior is already doen elsewhere
> in the code.
> 
> Thanks,
> Jon

You are looking at old code, it was fixed in the current 2.6 tree.
The skb_pull had to be changed to skb_pull_rcsum as well.
