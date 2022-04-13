Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1649853307; x=
 1649939707; bh=XMgjqSu330j537uTdk8vlBBLcfWargGjanG7gxBvZyg=; b=z
 QW+9E/xJjz5557ZQvJmGoLEHCR3PqDZ2OV/fW+wKGV6shPhL4bVwe1NBK+Jat8ma
 pQvzsOsB1KmRlIWTz3jcroigAiEuugm4PYzgEleksi1wxXqn1Fu9yE+xMSeQIuS0
 XYV4uIrGhKHdZeWAfEnUsZMfJepRIDUBQAVq9rNRjTZlmKxtN11gnr7upi6ZnLIE
 7TKPk4+SCnoO3if3V37TCxXGeIdFn/H34kGCWoq6XTvk9S76Q1pjXBdRtMs59azj
 pFf+M16rLDQSaplMhimuWD82QnPtrowWq3U9KXY24OHZq9ZMApinbxH3iLUwzMe3
 UyxL7qSAru56LPfXn9XHw==
Date: Wed, 13 Apr 2022 15:35:04 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YlbDeNh7D+BHRscg@shredder>
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-8-razor@blackwall.org>
 <YlbABWs3ICeeiKsq@shredder>
 <e22bd42c-f257-82d6-f550-6e174c74b500@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22bd42c-f257-82d6-f550-6e174c74b500@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 07/12] net: rtnetlink: add
 NLM_F_BULK support to rtnl_fdb_del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, Apr 13, 2022 at 03:21:54PM +0300, Nikolay Aleksandrov wrote:
> On 13/04/2022 15:20, Ido Schimmel wrote:
> > On Wed, Apr 13, 2022 at 01:51:57PM +0300, Nikolay Aleksandrov wrote:
> >> When NLM_F_BULK is specified in a fdb del message we need to handle it
> >> differently. First since this is a new call we can strictly validate the
> >> passed attributes, at first only ifindex and vlan are allowed as these
> >> will be the initially supported filter attributes, any other attribute
> >> is rejected. The mac address is no longer mandatory, but we use it
> >> to error out in older kernels because it cannot be specified with bulk
> >> request (the attribute is not allowed) and then we have to dispatch
> >> the call to ndo_fdb_del_bulk if the device supports it. The del bulk
> >> callback can do further validation of the attributes if necessary.
> >>
> >> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> >> ---
> >> v4: mark PF_BRIDGE/RTM_DELNEIGH with RTNL_FLAG_BULK_DEL_SUPPORTED
> >>
> >>  net/core/rtnetlink.c | 67 +++++++++++++++++++++++++++++++-------------
> >>  1 file changed, 48 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >> index 63c7df52a667..520d50fcaaea 100644
> >> --- a/net/core/rtnetlink.c
> >> +++ b/net/core/rtnetlink.c
> >> @@ -4169,22 +4169,34 @@ int ndo_dflt_fdb_del(struct ndmsg *ndm,
> >>  }
> >>  EXPORT_SYMBOL(ndo_dflt_fdb_del);
> >>  
> >> +static const struct nla_policy fdb_del_bulk_policy[NDA_MAX + 1] = {
> >> +	[NDA_VLAN]	= { .type = NLA_U16 },
> > 
> > In earlier versions br_vlan_valid_id() was used to validate the VLAN,
> > but I don't see it anymore. Maybe use 
> > 
> > NLA_POLICY_RANGE(1, VLAN_N_VID - 2)
> > 
> > ?
> > 
> > I realize that invalid values won't do anything, but I think it's better
> > to only allow valid ranges.
> > 
> 
> It's already validated below, see fdb_vid_parse().

Sorry, missed it :)
