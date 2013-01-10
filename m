Return-Path: <vyasevic@redhat.com>
Message-ID: <50EF0FF7.3080407@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1357751882-8619-1-git-send-email-vyasevic@redhat.com>
	<1357751882-8619-3-git-send-email-vyasevic@redhat.com>
	<20130110103614.23383079@nehalam.linuxnetplumber.net>
In-Reply-To: <20130110103614.23383079@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 02/14] bridge: Add vlan filtering
	infrastructure
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 10 Jan 2013 19:01:30 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, stephen@redhat.com, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, davem@davemloft.net

On 01/10/2013 01:36 PM, Stephen Hemminger wrote:
> This patch has some minor whitespace and spelling errors:
>
> WARNING: line over 80 characters
> #429: FILE: net/bridge/br_private.h:205:
> +static inline struct net_bridge_port *vlans_to_port(struct net_port_vlans *vlans)
>
> ERROR: trailing whitespace
> #432: FILE: net/bridge/br_private.h:208:
> +       $
>
> WARNING: please, no spaces at the start of a line
> #432: FILE: net/bridge/br_private.h:208:
> +       $
>
> +/* Must be protected by RTNL */
> +static void br_vlan_del(struct net_bridge_vlan *vlan)
>
> +	/* Drop the self-ref to trigger descrution. */
>                                          ^^^^^^^^^^
>

sorry, will fix.  I thought I ran everything through checkpatch.  I'll 
re-run them.

> Also, the data structure vlan's seems inverted. Why do you keep a hash list
> of vlan's and then a bitmap of ports. Seems more natural to just put a bitmap
> on each port that has vlan filtering rather than introducing yet another list
> to manage.
>

I originally had it this way.  I found that it wasted space and made 
other things more difficult to do.  For instance, to do egress policy, I 
would have needed another bitmap of vlans... With 4096 vlans, that's
512 bytes per port (1024 with policy).

I could probably remove the per-port list.  It would make 2 things a 
little harder:
   1) detecting if the port has any vlan info at all.
   2) dumping the vlan information

I could pursue this if you think it'll be better.

-vlad
