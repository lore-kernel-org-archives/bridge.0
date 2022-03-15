Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=AckR/coIxOb10tv+spqnXBr+Bpips1bwCHH84e6FTSM=;
 b=FCVeUrS472oDWiDqhyo4Ws4t2jUTRUzskbKDGjh1i4yV9sGjgTDZPif753HOrdYB1v
 +IoBKY5p+5LMXn4pzvHYzgUjCG9MlulNyimV9n4tTkdI41HZLW2Lm/nJZOEBpiyk1ZnQ
 lNPJNIavokMhsayNWMImIfqVk/j9xYgjjg2sUwwdLZC57cPqPPeD8LE9MO3aBqnIDS+X
 pihRjdSJFuj4TE/JRq4fZvSUQiM10UijL305ffL1EfHnSbTlbe7FI8MmSfxhveFUBzCJ
 OXx1sZbUrYln41S3aDx+/5r793aunkI+XLWkywP+v8/X+e7U0haSNfobmO7oekIDfqtu
 yNUw==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220315224205.jzz3m2mroytanesh@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-10-tobias@waldekranz.com>
 <20220315163349.k2rmfdzrd3jvzbor@skbuf> <87ee32lumk.fsf@waldekranz.com>
 <20220315224205.jzz3m2mroytanesh@skbuf>
Date: Tue, 15 Mar 2022 23:57:01 +0100
Message-ID: <875yoelt8i.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 00:42, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 15, 2022 at 11:26:59PM +0100, Tobias Waldekranz wrote:
>> On Tue, Mar 15, 2022 at 18:33, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Tue, Mar 15, 2022 at 01:25:37AM +0100, Tobias Waldekranz wrote:
>> >> If a port joins a bridge that it can't offload, it will fallback to
>> >> standalone mode and software bridging. In this case, we never want to
>> >> offload any FDB entries to hardware either.
>> >> 
>> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> >> ---
>> >
>> > When you resend, please send this patch separately, unless something
>> > breaks really ugly with your MST series in place.
>> 
>> Sure. I found this while testing the software fallback. It prevents a
>> segfault in dsa_port_bridge_host_fdb_add, which (rightly, I think)
>> assumes that dp->bridge is valid. I feel like this should have a Fixes:
>> tag, but I'm not sure which commit to blame. Any suggestions?
>
> Ok, makes sense. So far, unoffloaded bridge ports meant that the DSA
> switch driver didn't have a ->port_bridge_join() implementation.
> Presumably that also came along with a missing ->port_fdb_add()
> implementation. So probably no NPD for the existing code paths, it is
> just your unoffloaded MST support that opens up new possibilities.
>
> Anyway, the dereference of dp->bridge first appeared in commit
> c26933639b54 ("net: dsa: request drivers to perform FDB isolation")
> which is still just in net-next.

Thanks, I just sent it separately:

https://lore.kernel.org/netdev/20220315225018.1399269-1-tobias@waldekranz.com

>> >>  net/dsa/slave.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >> 
>> >> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> >> index a61a7c54af20..647adee97f7f 100644
>> >> --- a/net/dsa/slave.c
>> >> +++ b/net/dsa/slave.c
>> >> @@ -2624,6 +2624,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>> >>  	if (ctx && ctx != dp)
>> >>  		return 0;
>> >>  
>> >> +	if (!dp->bridge)
>> >> +		return 0;
>> >> +
>> >>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>> >>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
>> >>  			return 0;
>> >> -- 
>> >> 2.25.1
>> >> 
