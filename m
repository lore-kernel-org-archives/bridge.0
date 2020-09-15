Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1600165631; x=1631701631;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6pj42hcpmKOUyMQ9MhDbUOl6HOtbIojY8r2/GLfcYBk=;
 b=cAI6zxY48uUIZKfOkoAgTqTHMvUJuLOZgJIoeviH6e5s1RlOZ+L6TCaB
 eZlYrjHwsPb720R1E6Ha9XWnb6oxKOttBh4Mx4T18KzcBNJDkHH4knOIB
 ITEG/QIyHyl7gctWlLh1Z1LTT8BB/0uUlwpAIVvZUecu9bQCR72fWJsyV
 nNabZHNMLXfgkCQrt8Yv8IEMwq3oh4/mvfjPY41eDbxdptSnlE8dLijgB
 VePo863cuP1jg3TySt1IrTVCOLJ7P5m7wxMAUTycTQ9tQJljI5t1Zoj0Q
 1k89KohnB1+WhGlMP35nXn06LZNPx8woPgkqXzRy9/40T9B77AKgnEt6j g==;
Date: Tue, 15 Sep 2020 10:24:22 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20200915102422.ronvnumdu4lk3l4b@soft-test08>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
 <20200904091527.669109-7-henrik.bjoernlund@microchip.com>
 <cbb516e37457ef1875f99001ec72624c49ab51ed.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cbb516e37457ef1875f99001ec72624c49ab51ed.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH RFC 6/7] bridge: cfm: Netlink Notifications.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "idosch@mellanox.com" <idosch@mellanox.com>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Thanks for the review. Comments below.

The 09/08/2020 13:54, Nikolay Aleksandrov wrote:
> 
> On Fri, 2020-09-04 at 09:15 +0000, Henrik Bjoernlund wrote:
> > This is the implementation of Netlink notifications out of CFM.
> >
> > Notifications are initiated whenever a state change happens in CFM.
> >
> [snip]
> > +     *count = 0;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(mep, &br->mep_list, head)
> > +             * count += 1;
> 
> please remove the extra space
> 
I have removed the extra space.
This space was added to satify checkpatch as without this space it gives
this error:
CHECK: spaces preferred around that '*' (ctx:ExV)
#136: FILE: net/bridge/br_cfm.c:883:
+               *count += 1;
                ^

> > +     rcu_read_unlock();
> > +
> > +     return 0;
> > +}
> > +
> 
> 

-- 
/Henrik
