Return-Path: <prvs=550bf2f19=kuniyu@amazon.co.jp>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33E59611E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26571611E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1689173897; x=1720709897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zcW5kz8PrZMlxYxJAbQQUtUE+T2XGM7/jXVNUV8g9aM=;
 b=Uo670bUUj+6UKEwBrbteAwQpkYMO7mt8hISttAu2VhJWXt0CzKKtvBbj
 5yi50IkoWjsITAn1Bn80xM1rJqISFFIwuuNeGB10oz1ynN7yVwLdJO+yg
 seZS+JY+C5aRWC3m93JoR+JMsNi4yqv1p9SfEnyYDHL6PgvjQIn9+s4fH E=;
From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 12 Jul 2023 07:58:02 -0700
Message-ID: <20230712145802.726-1-kuniyu@amazon.com>
In-Reply-To: <ZK69NDM60+N0TTFh@shredder>
References: <ZK69NDM60+N0TTFh@shredder>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v1 net] bridge: Return an error when enabling
	STP in netns.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: idosch@idosch.org
Cc: netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuni1840@gmail.com, edumazet@google.com, kuniyu@amazon.com, ebiederm@xmission.com, kuba@kernel.org, hcoin@quietfountain.com, pabeni@redhat.com, davem@davemloft.net

From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 12 Jul 2023 17:48:20 +0300
> On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
> > When we create an L2 loop on a bridge in netns, we will see packets storm
> > even if STP is enabled.
> > 
> >   # unshare -n
> >   # ip link add br0 type bridge
> >   # ip link add veth0 type veth peer name veth1
> >   # ip link set veth0 master br0 up
> >   # ip link set veth1 master br0 up
> >   # ip link set br0 type bridge stp_state 1
> >   # ip link set br0 up
> >   # sleep 30
> >   # ip -s link show br0
> >   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
> >       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
> >       RX: bytes  packets  errors  dropped missed  mcast
> >       956553768  12861249 0       0       0       12861249  <-. Keep
> >       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
> >       1027834    11951    0       0       0       0         <-'   rapidly
> > 
> > This is because llc_rcv() drops all packets in non-root netns and BPDU
> > is dropped.
> > 
> > Let's show an error when enabling STP in netns.
> > 
> >   # unshare -n
> >   # ip link add br0 type bridge
> >   # ip link set br0 type bridge stp_state 1
> >   Error: bridge: STP can't be enabled in non-root netns.
> > 
> > Note this commit will be reverted later when we namespacify the whole LLC
> > infra.
> > 
> > Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> > Suggested-by: Harry Coin <hcoin@quietfountain.com>
> 
> I'm not sure that's accurate. I read his response in the link below and
> he says "I'd rather be warned than blocked" and "But better warned and
> awaiting a fix than blocked", which I agree with. The patch has the
> potential to cause a lot of regressions, but without actually fixing the
> problem.
> 
> How about simply removing the error [1]? Since iproute2 commit
> 844c37b42373 ("libnetlink: Handle extack messages for non-error case"),
> it can print extack warnings and not only errors. With the diff below:

This is good to know and I also prefer this approach!
I'll post v2.

Thanks!


> 
>  # unshare -n 
>  # ip link add name br0 type bridge
>  # ip link set dev br0 type bridge stp_state 1
>  Warning: bridge: STP can't be enabled in non-root netns.
>  # echo $?
>  0
> 
> [1]
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index a807996ac56b..b5143de37938 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>         ASSERT_RTNL();
>  
> -       if (!net_eq(dev_net(br->dev), &init_net)) {
> +       if (!net_eq(dev_net(br->dev), &init_net))
>                 NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> -               return -EINVAL;
> -       }
>  
>         if (br_mrp_enabled(br)) {
>                 NL_SET_ERR_MSG_MOD(extack,
> 
> > Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/bridge/br_stp_if.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> > index 75204d36d7f9..a807996ac56b 100644
> > --- a/net/bridge/br_stp_if.c
> > +++ b/net/bridge/br_stp_if.c
> > @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
> >  {
> >  	ASSERT_RTNL();
> >  
> > +	if (!net_eq(dev_net(br->dev), &init_net)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (br_mrp_enabled(br)) {
> >  		NL_SET_ERR_MSG_MOD(extack,
> >  				   "STP can't be enabled if MRP is already enabled");
> > -- 
> > 2.30.2
