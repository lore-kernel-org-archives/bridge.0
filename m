Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0BE1408AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B84B5408A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ozl2+3CNbOGcFgir3rEQ41Ac/ijTRZdlB8u+sHLq/PU=;
 b=q26NSJL3gz3bQkxp9t5GOIbI1B65qBaA4F8ov68W9DczLzoPzO9DY+3slzVvSPMCT/
 nrqt8Go4OQ1zJE9Mv5eBhQLGs8/NRIqim0vDW/cZSkIlarBF8dHxwJ5aGHBjSP7s9Dik
 oTTQ1mrmPQoaFHgycujHEu/he05ymJraISQm5s+yR2koTXX6OCfnWNTipdrhuyBIB1IX
 U7xOtjuoL613xYIITDwipJGCFqnAC3hpJU3XICBkq308qnjSHnyOZ5q9IoERCu06kDu1
 U8LZLFHLxVHBUP7wysgQJpR1Ykbzv5arkJyfI8RXKMIIfdvm/M4m6gi16ArzJUVQR0Tc
 jWVA==
Message-ID: <95f8b774-0b00-88dd-b890-2737d8a70592@blackwall.org>
Date: Mon, 9 Jan 2023 13:51:41 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com> <Y7vK4T18pOZ9KAKE@shredder>
 <20230109100236.euq7iaaorqxrun7u@skbuf> <Y7v98s8lC1WUvsSO@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Y7v98s8lC1WUvsSO@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 01/15] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

On 09/01/2023 13:43, Ido Schimmel wrote:
> On Mon, Jan 09, 2023 at 12:02:36PM +0200, Vladimir Oltean wrote:
>> On Mon, Jan 09, 2023 at 10:05:53AM +0200, Ido Schimmel wrote:
>>>> +	if (on)
>>>> +		static_branch_enable(&br_mst_used);
>>>> +	else
>>>> +		static_branch_disable(&br_mst_used);
>>>
>>> Hi,
>>>
>>> I'm not actually using MST, but I ran into this code and was wondering
>>> if the static key usage is correct. The static key is global (not
>>> per-bridge), so what happens when two bridges have MST enabled and then
>>> it is disabled on one? I believe it would be disabled for both. If so,
>>> maybe use static_branch_inc() / static_branch_dec() instead?
>>
>> Sounds about right. FWIW, br_switchdev_tx_fwd_offload does use
>> static_branch_inc() / static_branch_dec().
> 
> OK, thanks for confirming. Will send a patch later this week if Tobias
> won't take care of it by then. First patch will probably be [1] to make
> sure we dump the correct MST state to user space. It will also make it
> easier to show the problem and validate the fix.
> 
> [1]
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 4f5098d33a46..f02a1ad589de 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -286,7 +286,7 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
>  	case BR_BOOLOPT_MCAST_VLAN_SNOOPING:
>  		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
>  	case BR_BOOLOPT_MST_ENABLE:
> -		return br_opt_get(br, BROPT_MST_ENABLED);
> +		return br_mst_is_enabled(br);
>  	default:
>  		/* shouldn't be called with unsupported options */
>  		WARN_ON(1);
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 75aff9bbf17e..7f0475f62d45 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1827,7 +1827,7 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
>  /* br_mst.c */
>  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>  DECLARE_STATIC_KEY_FALSE(br_mst_used);
> -static inline bool br_mst_is_enabled(struct net_bridge *br)
> +static inline bool br_mst_is_enabled(const struct net_bridge *br)
>  {
>  	return static_branch_unlikely(&br_mst_used) &&
>  		br_opt_get(br, BROPT_MST_ENABLED);
> @@ -1845,7 +1845,7 @@ int br_mst_fill_info(struct sk_buff *skb,
>  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
>  		   struct netlink_ext_ack *extack);
>  #else
> -static inline bool br_mst_is_enabled(struct net_bridge *br)
> +static inline bool br_mst_is_enabled(const struct net_bridge *br)
>  {
>  	return false;
>  }

Ack, good catch. This should've been _inc/_dec indeed.

Thanks,
 Nik

