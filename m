Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65B07400F8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA65E400EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKWM/hOY4e/8/uwaVsn+F8mbxE/F7u8TOpJ6D+Eyfto=;
 b=mqQCSiQdFtMCNNqeFBxMdMnBXJ5osOTs/FP/G6jcc/iv5DcHcbLE7pyAN2RoyNh6QyJx36UyDnuMZ5XeE+WfBu8AVPzG2pkZXxbK1rxR8CyMb46nNSJGsw79gvdKFpNil15bzlw6r9bQTRfKVhJhL8412ePl5Se52M7LjEhUYPQGYx3oV+lJAe+lljLQB8MPfnPTqwDWOacb8TG5zBG1Pufx+M8o+BP40vjUxRw8U+Da8RMmgQVok2gRPrmEeXEHrvVqEAGNWzWoVW+8tEygd3z8tdykCIxw/lpefAL/6Y3z816Wmj+q3ljSytwiK+6Q7Bt/djcIhUg9PEWN+8pAnA==
Date: Wed, 15 Mar 2023 09:58:35 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <ZBF6q8zKx1nyW3TE@shredder>
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-10-idosch@nvidia.com>
 <e695257a-58e2-c676-95cd-77df5c2b68cf@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e695257a-58e2-c676-95cd-77df5c2b68cf@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 09/11] vxlan: Add MDB data path support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Tue, Mar 14, 2023 at 02:35:08PM +0200, Nikolay Aleksandrov wrote:
> On 13/03/2023 16:53, Ido Schimmel wrote:
> > +struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
> > +						struct sk_buff *skb,
> > +						__be32 src_vni)
> > +{
> > +	struct vxlan_mdb_entry *mdb_entry;
> > +	struct vxlan_mdb_entry_key group;
> > +
> > +	if (!is_multicast_ether_addr(eth_hdr(skb)->h_dest) ||
> > +	    is_broadcast_ether_addr(eth_hdr(skb)->h_dest))
> > +		return NULL;
> > +
> > +	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
> > +	 * entries are stored with the VNI of the VXLAN device.
> > +	 */
> > +	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
> > +		src_vni = vxlan->default_dst.remote_vni;
> > +
> > +	memset(&group, 0, sizeof(group));
> > +	group.vni = src_vni;
> > +
> > +	switch (ntohs(skb->protocol)) {
> 
> drop the ntohs and..
> 
> > +	case ETH_P_IP:
> 
> htons(ETH_P_IP)

Done. Thanks a lot for the review!
