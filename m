Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <53678887.1070006@cogentembedded.com>
Date: Mon, 05 May 2014 16:48:07 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
In-Reply-To: <1399238974-6210-1-git-send-email-jmaxwell@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jon Maxwell <jmaxwell37@gmail.com>, netdev@vger.kernel.org
Cc: vyasevic@redhat.com, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, pirko@redhat.com, davem@davemloft.net

Hello.

On 05/05/2014 01:29 AM, Jon Maxwell wrote:

> There has been a number incidents recently where customers running KVM have reported that VM hosts on different Hypervisors are unreachable. Based on pcap traces we found that the bridge was broadcasting the ARP request out onto the network. However some NICs have an inbuilt switch which on occasions were broadcasting the VMs ARP request back through the physical NIC on the Hypervisor. This resulted in the bridge flapping ports and incorrectly learning that the VMs mac address was external. As a result the ARP reply was directed back onto the external network and VM never updated it's ARP cache. This patch will detect port flapping and log a message so that this condition can be detected earlier.

    Please wrap your changelog at 80 columns or less.

> Signed-off-by: Jon Maxwell <jmaxwell@redhat.com>

    You probably want the same RedHat email in the patch autorhship record, so 
you need to insert the below line before the changelog:

From: Jon Maxwell <jmaxwell@redhat.com>

> ---
>   net/bridge/br_fdb.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 9203d5a..c08607b 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -507,6 +507,13 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
>   					source->dev->name);
>   		} else {
>   			/* fastpath: update of existing entry */
> +			if (source->port_no != fdb->dst->port_no &&
> +				net_ratelimit())
> +				br_warn(br, "Port flapping detected source entry dev = %s mac = %pM, port_no = %d\n existing entry dev = %s mac = %pM, port_no = %d\n",
> +					source->dev->name,
> +					addr, source->port_no,
> +					fdb->dst->dev->name, addr,

    Why print the same MAC address twice?

> +					fdb->dst->port_no);
>   			fdb->dst = source;
>   			fdb->updated = jiffies;
>   			if (unlikely(added_by_user))

WBR, Sergei

