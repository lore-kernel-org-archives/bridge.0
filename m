Date: Fri, 11 Sep 2009 08:11:14 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090911081114.77969b3a@nehalam>
In-Reply-To: <cfeab66d0909110722v504f13ccv230309e2599ab723@mail.gmail.com>
References: <cfeab66d0909110722v504f13ccv230309e2599ab723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] qos queue on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 11 Sep 2009 19:52:02 +0530
ratheesh k <ratheesh.ksz@gmail.com> wrote:

> i bridged eth0 (ethernet ) and ap0 (wireless )  using  brctl command .
> The bridge interface is br0 . i connected a linux desktop (Machine A
> ) to eth0 and  Machine B to ap0 .
> 
> I have ingress qdisc and egress qdisc on br0 .
> 
> if i ping MAchine A from Machine B , will the icmp pkts will go thru
> any of the qdisc ( egress or ingress ) ??????
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

The bridge pseudo-device (br0) is only used for packets
arriving at the host, not for packets transiting through
the bridge.

If you apply QoS on br0 (output), then it will only apply
to locally generated packets. Likewise ingress will only
apply to packets whose final destination is the bridge machine.

To do QoS on packets going through the bridge, apply
QoS to the underlying devices (eth0, ap0).

-- 
