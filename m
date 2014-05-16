Return-Path: <jmaxwell@redhat.com>
Date: Fri, 16 May 2014 04:54:30 -0400 (EDT)
From: Jon Maxwell <jmaxwell@redhat.com>
Message-ID: <1635112974.7420478.1400230470472.JavaMail.zimbra@redhat.com>
In-Reply-To: <255115023.7295678.1400227971937.JavaMail.zimbra@redhat.com>
References: <1400227719-18403-1-git-send-email-jmaxwell@redhat.com>
	<255115023.7295678.1400227971937.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: notify user space of fdb port
	change
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: vyasevic@redhat.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net



----- Original Message -----
> From: "Jon Maxwell" <jmaxwell@redhat.com>
> To: stephen@networkplumber.org
> Cc: davem@davemloft.net, "makita toshiaki" <makita.toshiaki@lab.ntt.co.jp>, vyasevic@redhat.com,
> bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jpirko@redhat.com
> Sent: Friday, May 16, 2014 6:12:51 PM
> Subject: Re: [PATCH net] bridge: notify user space of fdb port change
> 
> Please use this patch. My bad, the previous one
> incorrectly did the notify before fdb->added_by_user = 1.
> 

I just realized I did the port compare after fdb->dst = source;
So the notify will never trigger. It's been a long
day, I'll rewrite this tomorrow and resubmit after 
testing it on my reproducer. Please ignore this one
too.

> ----- Original Message -----
> > From: "Jon Maxwell" <jmaxwell37@gmail.com>
> > To: stephen@networkplumber.org
> > Cc: davem@davemloft.net, "makita toshiaki" <makita.toshiaki@lab.ntt.co.jp>,
> > vyasevic@redhat.com,
> > bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
> > linux-kernel@vger.kernel.org, jpirko@redhat.com,
> > jmaxwell@redhat.com, "Jon Maxwell" <jmaxwell37@gmail.com>
> > Sent: Friday, May 16, 2014 6:08:39 PM
> > Subject: [PATCH net] bridge: notify user space of fdb port change
> > 
> > From: Jon Maxwell <jmaxwell37@gmail.com>
> > 
> > There has been a number incidents recently where customers running KVM have
> > reported that VM hosts on different Hypervisors are unreachable. Based on
> > pcap traces we found that the bridge was broadcasting the ARP request out
> > onto the network. However some NICs have an inbuilt switch which on
> > occasions
> > were broadcasting the VMs ARP request back through the physical NIC on the
> > Hypervisor. This resulted in the bridge changing ports and incorrectly
> > learning
> > that the VMs mac address was external. As a result the ARP reply was
> > directed
> > back onto the external network and VM never updated it's ARP cache. This
> > patch
> > will notify the bridge command to identify such port toggling.
> > 
> > Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> > ---
> >  net/bridge/br_fdb.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index 9203d5a..67480c2 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -511,6 +511,8 @@ void br_fdb_update(struct net_bridge *br, struct
> > net_bridge_port *source,
> >  			fdb->updated = jiffies;
> >  			if (unlikely(added_by_user))
> >  				fdb->added_by_user = 1;
> > +			if (unlikely(source->port_no != fdb->dst->port_no))
> > +				fdb_notify(br, fdb, RTM_NEWNEIGH);
> >  		}
> >  	} else {
> >  		spin_lock(&br->hash_lock);
> > --
> > 1.8.3.1
> > 
> > 
> 
