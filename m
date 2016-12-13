Return-Path: <sergei.shtylyov@cogentembedded.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=5t/ZfPRq/cZXARG+DokF4GJGmml+qfscvjMvDhbARl8=;
	b=oODSevd87ZUtIpg+uS374oI7NqOG3kSBuDdU1DBZ7OHHRYtp5jBlkHX5/apG96VPia
	aOk7wWoNab8tzgxqR70sqNkMnWU0Dzmr3T8SUPvDPKj4tiYfgcJkyFzzmBwbNX7cT/eQ
	Uqbvq8exPQvFJCKCLWeu+/05PBVT8Fsz635iuA9yXFIw7vVX2uotvrbvHXKChHsL/BGl
	g0QI1SKbEOF2IBhwwT3AhUip38HyL6racCp3QhatmFeqt5mFY1qiR6L2vSHMraiRrVin
	x270hkt6JoTkfvNPut1umOlpmYx9uOKGTncDott/O4O7oIV4WW+yiLoDZFIN6/pDKVXF
	3AiA==
References: <cover.1481586602.git.mirq-linux@rere.qmqm.pl>
	<e6e09a2f745a652382ac7859770ec16c75d8e149.1481586602.git.mirq-linux@rere.qmqm.pl>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f5078470-0fc0-cfcd-36df-3ebb380b547a@cogentembedded.com>
Date: Tue, 13 Dec 2016 15:59:46 +0300
MIME-Version: 1.0
In-Reply-To: <e6e09a2f745a652382ac7859770ec16c75d8e149.1481586602.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 13/27] bridge: use __vlan_hwaccel
	helpers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, "open list:NETFILTER ({IP, IP6, ARP, EB ,
	NF}TABLES)" <netfilter-devel@vger.kernel.org>, "Jozsef Kadlecsik (supporter:NETFILTER ({IP, IP6, ARP, EB,
	NF}TABLES))" <kadlec@blackhole.kfki.hu>, "Patrick McHardy (supporter:NETFILTER ({IP, IP6, ARP , EB,
	NF}TABLES))" <kaber@trash.net>, "Pablo Neira Ayuso (supporter:NETFILTER ({IP , IP6, ARP, EB,
	NF}TABLES))" <pablo@netfilter.org>

Hello!

On 12/13/2016 3:12 AM, Michał Mirosław wrote:

> This removes assumption than vlan_tci != 0 when tag is present.
>
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  net/bridge/br_netfilter_hooks.c | 14 ++++++++------
>  net/bridge/br_private.h         |  2 +-
>  net/bridge/br_vlan.c            |  6 +++---
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
> index b12501a..2cc0747 100644
> --- a/net/bridge/br_netfilter_hooks.c
> +++ b/net/bridge/br_netfilter_hooks.c
[...]
> @@ -749,8 +747,12 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
>
>  		data = this_cpu_ptr(&brnf_frag_data_storage);
>
> -		data->vlan_tci = skb->vlan_tci;
> -		data->vlan_proto = skb->vlan_proto;
> +		if (skb_vlan_tag_present(skb)) {
> +			data->vlan_tci = skb->vlan_tci;
> +			data->vlan_proto = skb->vlan_proto;
> +		} else
> +			data->vlan_proto = 0;

    CodingStyle: should use {} in all branches of *if* if at least one branch 
has {}.

[...]
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index b6de4f4..ef94664 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c

> @@ -444,8 +444,8 @@ static bool __allowed_ingress(const struct net_bridge *br,
>  			__vlan_hwaccel_put_tag(skb, br->vlan_proto, pvid);
>  		else
>  			/* Priority-tagged Frame.
> -			 * At this point, We know that skb->vlan_tci had
> -			 * VLAN_TAG_PRESENT bit and its VID field was 0x000.
> +			 * At this point, We know that skb->vlan_tci VID

    s/We/we/.

> +			 * field was 0x000.

    Simply 0, maybe?

[...]

MBR, Sergei

