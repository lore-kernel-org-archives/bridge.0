Return-Path: <stephen@networkplumber.org>
Date: Sun, 4 May 2014 15:53:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20140504155331.13862a85@nehalam.linuxnetplumber.net>
In-Reply-To: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
References: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Add port flap detection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jon Maxwell <jmaxwell37@gmail.com>
Cc: vyasevic@redhat.com, netdev@vger.kernel.org, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pirko@redhat.com, davem@davemloft.net

On Mon,  5 May 2014 07:29:34 +1000
Jon Maxwell <jmaxwell37@gmail.com> wrote:

> There has been a number incidents recently where customers running KVM have reported that VM hosts on different Hypervisors are unreachable. Based on pcap traces we found that the bridge was broadcasting the ARP request out onto the network. However some NICs have an inbuilt switch which on occasions were broadcasting the VMs ARP request back through the physical NIC on the Hypervisor. This resulted in the bridge flapping ports and incorrectly learning that the VMs mac address was external. As a result the ARP reply was directed back onto the external network and VM never updated it's ARP cache. This patch will detect port flapping and log a message so that this condition can be detected earlier.
> 
> Signed-off-by: Jon Maxwell <jmaxwell@redhat.com>
> ---
>  net/bridge/br_fdb.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 9203d5a..c08607b 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -507,6 +507,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>  					source->dev->name);
>  		} else {
>  			/* fastpath: update of existing entry */
> +			if (source->port_no != fdb->dst->port_no &&
> +				net_ratelimit())
> +				br_warn(br, "Port flapping detected source entry dev = %s mac = %pM, port_no = %d\n existing entry dev = %s mac = %pM, port_no = %d\n",
> +					source->dev->name,
> +					addr, source->port_no,
> +					fdb->dst->dev->name, addr,
> +					fdb->dst->port_no);
>  			fdb->dst = source;
>  			fdb->updated = jiffies;
>  			if (unlikely(added_by_user))

Ok, but please shorten the message to a single line without excess wordage.
Plus flapping to mean means link going up and down. Maybe use same message
as BSD?

