Date: Fri, 8 May 2009 16:29:49 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090508162949.4e76abd6@nehalam>
In-Reply-To: <20090508.162555.193731410.davem@davemloft.net>
References: <20090508153842.65ce3bed@s6510>
	<20090508.160008.127530143.davem@davemloft.net>
	<20090508161204.134668b9@nehalam>
	<20090508.162555.193731410.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: introduce a list of device addresses
 dev_addr_list (v6)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

On Fri, 08 May 2009 16:25:55 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@vyatta.com>
> Date: Fri, 8 May 2009 16:12:04 -0700
> 
> > But the other infrastructure may have same issues (netfilter, etc).
> > Just seems like it would be either to have multiple network devices
> > so that upper layers could disambiguate easier.
> 
> That's quite a heavyweight solution to what is purely
> an addressing issue, don't you think?
> 
> We can just revert all of that netdev_ops stuff if you
> think per-netdev cost doesn't matter :-)

I am just concerned that is a fundamental change (like MQ) was and
it will take a couple of releases to shake out all the inter-relationships.
When an architectural change is made, would like to see more analysis done.
Netdev-ops was more of a refactoring than a change to what protocols
and qdisc/filters/... see.

-- 
