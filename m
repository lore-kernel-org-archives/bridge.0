Return-Path: <vyasevic@redhat.com>
Message-ID: <50F04EDC.9040309@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1357751882-8619-1-git-send-email-vyasevic@redhat.com>
	<1357751882-8619-2-git-send-email-vyasevic@redhat.com>
	<20130110102525.2ff40c12@nehalam.linuxnetplumber.net>
	<50EF0B76.2040503@redhat.com>
	<20130110140749.153023fa@nehalam.linuxnetplumber.net>
	<50EF660B.2090500@redhat.com>
	<20130111092004.2d55ae65@nehalam.linuxnetplumber.net>
In-Reply-To: <20130111092004.2d55ae65@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 01/14] vlan: wrap hw-acceleration
 calls in separate functions.
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 11 Jan 2013 17:41:53 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, stephen@redhat.com, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, davem@davemloft.net

On 01/11/2013 12:20 PM, Stephen Hemminger wrote:
> What I think is the least intrusive and allows for maximum flexibility
> is having the VLAN bridge filtering depend on VLAN support (CONFIG_VLAN_8021Q).
> There already is drivers that depend on that value to enable filtering.
>

The only thing that I see depending on CONFIG_VLAN_8021Q is 
CONFIG_VLAN_8021Q_GVRP which is part of the 8021Q support.
There are currently no other drivers depending on 8021Q functionality
and vlan filtering in drivers doesn't depend on 8021Q support in
the kernel.

I admit that I've thought of having a dependency on 8021Q as it would 
have allowed me to re-use a bit more code, but decided that bridge 
should be able to stand on its own in this regard.  8021Q is not 
necessary to turn on VLAN accelerated filtering on the nics as anyone 
can do it through the ndo_vlan_rx_add_vid() call.

The reason for this patch was to make the nic vlan filter code reusable
and address Jiri Pirko's comment in the V2 series.
(http://marc.info/?l=linux-netdev&m=135590565719164&w=2).  This way,
bridge wouldn't need to make direct ndo_ calls and all call sights will
be consistent.

> And make the support of VLAN filtering in the bridge conditional like
> IGMP snooping is optional

I could certainly make the VLAN filtering conditional, but I am not sure 
what it would buy us other then a lot of ifdefs.

Thanks
-vlad

>
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -46,3 +46,17 @@ config BRIDGE_IGMP_SNOOPING
>            Say N to exclude this support and reduce the binary size.
>
>            If unsure, say Y.
> +
> +config BRIDGE_VLAN_FILTERING
> +       bool "VLAN filtering"
> +       depends on BRIDGE
> +       depends on VLAN_8021Q
> +       default n
> +       ---help---
> +         If you say Y here, then the Ethernet bridge will be able to
> +        selectively filter traffic based on VLAN tag.
> +
> +        Say N to exclude this support and reduce the binary size.
> +
> +        If unsure, say Y.
>

