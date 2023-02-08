Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A5CE40BE6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C43440B48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ8VsW5k0fXq/kPqrk4b2Cw97DUVFjfQPGMT2odxsPs=;
 b=W0JOqurhJ6EJdG7cb4INXauErb49/lkhyfmFrUDVpbkB0y8/pJ0ikUnt42ykgIVP6igKsZTMHvudJsPz1akJ3WsRAScuiuBMWz7DL5FvXu1EvG1bZoJvqBZW5qtdug52u/ImxILpVXKUGuH0mtZqiBedrUjkqvmuPhZFA/jBokc=
Date: Wed, 8 Feb 2023 14:44:53 +0100
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <Y+OnVfu/3ot3Rk7f@corigine.com>
References: <20230208005626.56847-1-yang.lee@linux.alibaba.com>
 <Y+OdyiQpz7lIBfh3@corigine.com>
 <1a71f6f8-09f6-9208-7368-6b2e3bb4af87@blackwall.org>
 <4e9705d5-c6f7-0b08-6e45-b19bae1d248d@blackwall.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e9705d5-c6f7-0b08-6e45-b19bae1d248d@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH -next] net: bridge: clean up one inconsistent
	indenting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org, edumazet@google.com, Yang Li <yang.lee@linux.alibaba.com>, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Feb 08, 2023 at 02:31:39PM +0100, Nikolay Aleksandrov wrote:
> On 2/8/23 15:30, Nikolay Aleksandrov wrote:
> > On 2/8/23 15:04, Simon Horman wrote:
> > > On Wed, Feb 08, 2023 at 08:56:26AM +0800, Yang Li wrote:
> > > > ./net/bridge/br_netlink_tunnel.c:317:4-27: code aligned with
> > > > following code on line 318
> > > > 
> > > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3977
> > > > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> > > 
> > > As you may need to respin this:
> > > 
> > > Assuming this is targeting net-next, which seems likely to me,
> > > the subject should denote that. Something like this:
> > > 
> > > [PATCH net-next] net: bridge: clean up one inconsistent indenting
> > > 
> > > > ---
> > > >   net/bridge/br_netlink_tunnel.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/bridge/br_netlink_tunnel.c
> > > > b/net/bridge/br_netlink_tunnel.c
> > > > index 17abf092f7ca..eff949bfdd83 100644
> > > > --- a/net/bridge/br_netlink_tunnel.c
> > > > +++ b/net/bridge/br_netlink_tunnel.c
> > > > @@ -315,7 +315,7 @@ int br_process_vlan_tunnel_info(const struct
> > > > net_bridge *br,
> > > >               if (curr_change)
> > > >                   *changed = curr_change;
> > > > -             __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> > > > +            __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> > > >                               curr_change);
> > > 
> > > I think you also need to adjust the line immediately above.
> > 
> > You meant below, right? :) i.e. "curr_change)", that seems to get
> > misaligned after the change and needs to be adjusted as well.
> > 
> 
> Oh I need coffee, I somehow was thinking about the line being changed
> instead of literally the line above your statement. :))

No problem. We are talking about the same line :)

> Anyway, ack.
