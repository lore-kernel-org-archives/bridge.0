Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KPx0OJiGKrJJwKH4Oanue1+VQiHgCgvicIxDSNwwyas=;
	b=el2wbGEWFfrARwVmxAbVnqh9L/S8oXAmJSAH8e4K4RU8yQcmErKzURogDleZ6aQ8xg
	+GTzj3opgmwpB8u6yyyVSCu2PmXKnyYVZVQm/XfwFgCCJLvCAdTfQsVu5nBBl3zIuoHr
	NlTuGYLA5sVLr7Tb1MlWipnolWfU7PV0fy1g4=
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
	<20170517212709.6473-6-vivien.didelot@savoirfairelinux.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <ee5d9736-72ec-f4fd-8e9b-2c4179687e16@cumulusnetworks.com>
Date: Thu, 18 May 2017 18:28:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170517212709.6473-6-vivien.didelot@savoirfairelinux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/6] net: bridge: get msgtype from
 nlmsghdr in mdb ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, kernel@savoirfairelinux.com, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On 5/18/17 12:27 AM, Vivien Didelot wrote:
> Retrieve the message type from the nlmsghdr structure instead of
> hardcoding it in both br_mdb_add and br_mdb_del.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
>   net/bridge/br_mdb.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index a72d5e6f339f..d280b20587cb 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -569,6 +569,7 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	struct net_bridge_port *p;
>   	struct net_bridge_vlan *v;
>   	struct net_bridge *br;
> +	int msgtype = nlh->nlmsg_type;

minor nits:
nlmsg_type is a u16, also please keep the order and arrange these from longest 
to shortest

>   	int err;
>   
>   	err = br_mdb_parse(skb, nlh, &dev, &entry);
> @@ -595,12 +596,12 @@ static int br_mdb_add(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
>   		list_for_each_entry(v, &vg->vlan_list, vlist) {
>   			entry->vid = v->vid;
> -			err = __br_mdb_do(p, entry, RTM_NEWMDB);
> +			err = __br_mdb_do(p, entry, msgtype);
>   			if (err)
>   				break;
>   		}
>   	} else {
> -		err = __br_mdb_do(p, entry, RTM_NEWMDB);
> +		err = __br_mdb_do(p, entry, msgtype);
>   	}
>   
>   	return err;
> @@ -677,6 +678,7 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	struct net_bridge_port *p;
>   	struct net_bridge_vlan *v;
>   	struct net_bridge *br;
> +	int msgtype = nlh->nlmsg_type;

same here

>   	int err;
>   
>   	err = br_mdb_parse(skb, nlh, &dev, &entry);
> @@ -703,12 +705,12 @@ static int br_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	if (br_vlan_enabled(br) && vg && entry->vid == 0) {
>   		list_for_each_entry(v, &vg->vlan_list, vlist) {
>   			entry->vid = v->vid;
> -			err = __br_mdb_do(p, entry, RTM_DELMDB);
> +			err = __br_mdb_do(p, entry, msgtype);
>   			if (err)
>   				break;
>   		}
>   	} else {
> -		err = __br_mdb_do(p, entry, RTM_DELMDB);
> +		err = __br_mdb_do(p, entry, msgtype);
>   	}
>   
>   	return err;
> 

