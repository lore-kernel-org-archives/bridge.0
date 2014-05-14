Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <5373D5C3.60807@cogentembedded.com>
Date: Thu, 15 May 2014 00:44:51 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
	<1400080168-16625-6-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1400080168-16625-6-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/8] bridge: Add addresses from static
 fdbs to non-promisc ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>, netdev@vger.kernel.org
Cc: john.r.fastabend@intel.com, shemminger@vyatta.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, mst@redhat.com

On 05/14/2014 07:09 PM, Vlad Yasevich wrote:

> When a static fdb entry is created, add the mac address
> from this fdb entry to any ports that are currently running
> in non-promiscuous mode.  These ports need this data so that
> they can receive traffic destined to these addresses.
> By default ports start in promiscuous mode, so this feature
> is disabled.

> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> ---
>   net/bridge/br_fdb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 70 insertions(+), 6 deletions(-)

> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index 9759b61..958b68a 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -85,8 +85,58 @@ static void fdb_rcu_free(struct rcu_head *head)
>   	kmem_cache_free(br_fdb_cache, ent);
>   }
>
> +/* When a static FDB entry is added, the mac address from the entry is
> + * added to the bridge private HW address list and all required ports
> + * are then updated with the new information.
> + * Called under RTNL.
> + */
> +static void fdb_add_hw(struct net_bridge *br, const unsigned char *addr)
> +{
> +	int err;
> +	struct net_bridge_port *p, *tmp = NULL;

    Initializer doesn't seem to be needed.

[...]

WBR, Sergei

