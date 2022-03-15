Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QwK4SCTHESWH9opGqBpp4sqUaushZIwW8QXUMdBftVo=;
 b=ESShF7zVcCseeQJQL5/QUswiIDZA0RkSF/Mz/5ZlrdvpAPx3bb9w3stSHYXfSfz4Wb
 KKfwZRCzYv341ZNom9QXqC3iWs/ISy2yeKhyjxgxEDEUuTBnbAeu8wObNKLlOnwlA8V1
 JYjauXCU7JAl1mVlW5xLg2n55+qoj0W/NGI1icJKpmp598LMGBZQS5bGfU5pdX4UWQkc
 G+gb1tV8zSFItGNLH0QxEdseVK8fGj1g79QBRT9Px5KG/+lyGLezcd2QshqV0RlEe34g
 5kCWpPeZtVUNhlObG5x0SelyY4WcZfznWK0C7lJr5BRrorRDkjJgfDaAfoDjnscWhBtm
 fkew==
Date: Wed, 16 Mar 2022 00:42:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220315224205.jzz3m2mroytanesh@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-10-tobias@waldekranz.com>
 <20220315163349.k2rmfdzrd3jvzbor@skbuf>
 <87ee32lumk.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee32lumk.fsf@waldekranz.com>
Subject: Re: [Bridge] [PATCH v4 net-next 09/15] net: dsa: Never offload FDB
 entries on standalone ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:26:59PM +0100, Tobias Waldekranz wrote:
> On Tue, Mar 15, 2022 at 18:33, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Tue, Mar 15, 2022 at 01:25:37AM +0100, Tobias Waldekranz wrote:
> >> If a port joins a bridge that it can't offload, it will fallback to
> >> standalone mode and software bridging. In this case, we never want to
> >> offload any FDB entries to hardware either.
> >> 
> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> >> ---
> >
> > When you resend, please send this patch separately, unless something
> > breaks really ugly with your MST series in place.
> 
> Sure. I found this while testing the software fallback. It prevents a
> segfault in dsa_port_bridge_host_fdb_add, which (rightly, I think)
> assumes that dp->bridge is valid. I feel like this should have a Fixes:
> tag, but I'm not sure which commit to blame. Any suggestions?

Ok, makes sense. So far, unoffloaded bridge ports meant that the DSA
switch driver didn't have a ->port_bridge_join() implementation.
Presumably that also came along with a missing ->port_fdb_add()
implementation. So probably no NPD for the existing code paths, it is
just your unoffloaded MST support that opens up new possibilities.

Anyway, the dereference of dp->bridge first appeared in commit
c26933639b54 ("net: dsa: request drivers to perform FDB isolation")
which is still just in net-next.

> >>  net/dsa/slave.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> >> index a61a7c54af20..647adee97f7f 100644
> >> --- a/net/dsa/slave.c
> >> +++ b/net/dsa/slave.c
> >> @@ -2624,6 +2624,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
> >>  	if (ctx && ctx != dp)
> >>  		return 0;
> >>  
> >> +	if (!dp->bridge)
> >> +		return 0;
> >> +
> >>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
> >>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
> >>  			return 0;
> >> -- 
> >> 2.25.1
> >> 
