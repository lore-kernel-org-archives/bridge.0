Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=+7QYUGPUJGV7sAchppxshMOtZinPJnPqBas5RxkhQiA=;
 b=JBs6VYGA92rPbFqrd6OxMJkb4R8GLOe+Xpwa5oFbRmVd82ki7mxCsJWIBzPm+JULZh
 9B0lLCPVeGKpryB9BI+w5qKvmrzH2YA7wvAUEZqLGZMj+Jg9c4AcrGninr0PWy55NywR
 5xjZXsTsP2Th+S3Ff31kLVt190cEwtZbOTJN9y92RW7OrX+FqaeA7U7JNa8IK4Fje0hS
 0tn3lIHEDsO8TDQOxr/95Ps+dXmFShPpMYXBuVsQD4NSC/l2KfdliVs6vsNdj676nCxd
 UwnIpZnn+arFt5WnzRSKXrA7i697mjWJXs5+Pg+x0RI2lYrGKbDbQ7bBV2oaHD9wXdVN
 7I4Q==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220314145854.shtnvetounjfnu4e@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-4-tobias@waldekranz.com>
 <20220314145854.shtnvetounjfnu4e@skbuf>
Date: Mon, 14 Mar 2022 16:42:01 +0100
Message-ID: <87y21clewm.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v3 net-next 03/14] net: bridge: mst: Support
 setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 16:58, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Mar 14, 2022 at 10:52:20AM +0100, Tobias Waldekranz wrote:
>> +int br_mst_fill_info(struct sk_buff *skb, struct net_bridge_vlan_group *vg)
>> +{
>> +	struct net_bridge_vlan *v;
>> +	struct nlattr *nest;
>> +	unsigned long *seen;
>> +	int err = 0;
>> +
>> +	seen = bitmap_zalloc(VLAN_N_VID, 0);
>
> I see there is precedent in the bridge driver for using dynamic
> allocation as opposed to on-stack declaration using DECLARE_BITMAP().
> I imagine this isn't just to be "heapsters", but why?
>
> I don't have a very good sense of how much on-stack memory is too much
> (a lot probably depends on the expected depth of the call stack too, and here it
> doesn't appear to be too deep), but I see that mlxsw_sp_bridge_vxlan_vlan_is_valid()
> has a DECLARE_BITMAP(vlans, VLAN_N_VID) too.
>
> The comment applies for callers of br_mst_get_info() too.

In v4, things become even worse, as I need to allocate the bitmap in a
context where I can't return an error. So if it's ok to keep it on the
stack, then that would be great.

Here's the code in question:

size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
{
	const struct net_bridge_vlan *v;
	unsigned long *seen;
	size_t sz;

	seen = bitmap_zalloc(VLAN_N_VID, 0);
	if (WARN_ON(!seen))
		return 0;

	/* IFLA_BRIDGE_MST */
	sz = nla_total_size(0);

	list_for_each_entry(v, &vg->vlan_list, vlist) {
		if (test_bit(v->brvlan->msti, seen))
			continue;

		/* IFLA_BRIDGE_MST_ENTRY */
		sz += nla_total_size(0) +
			/* IFLA_BRIDGE_MST_ENTRY_MSTI */
			nla_total_size(sizeof(u16)) +
			/* IFLA_BRIDGE_MST_ENTRY_STATE */
			nla_total_size(sizeof(u8));

		__set_bit(v->brvlan->msti, seen);
	}

	kfree(seen);
	return sz;
}
