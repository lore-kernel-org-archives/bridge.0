Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=SyZ0OnaiZxTBRVMhjHHgMsFegnhPy0MogSls5tEiHGc=;
	b=PCbMZkclPJadTAOOHSEcUTF06VCwXWf6a9bM3v0a3BGXaVhqGf/g6hwbDWYFtBhLiH
	KzFhjJrq7C7AQMcY4dYhlrHNGeTIvDH4v2c8xdYIGg61mAj/ZFkQzOAtN1pajDd5eytQ
	DcP9hitP2lqkZAJKlnvA5x9h3Pwrg7cfZJzgsY2u3X2msITFOX3iz9zKGOpOL70RpG8G
	wTfEmcpldaaLLbwQOvAWk7EOiq+Ahq/SUo4MeVtojb+MAliLDqk3bGWSFNVTGNryIla9
	PtwhUMDbbdi3JDaF8ahi2WBdQk8ktFQc8ObiGP3eumjd/nV2c9mwcnXFmG+3zPNGnJw5
	1IiQ==
References: <20190902181000.25638-1-zahari.doychev@linux.com>
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
Message-ID: <76b7723b-68dd-0efc-9a93-0597e9d9b827@gmail.com>
Date: Tue, 3 Sep 2019 20:37:36 +0900
MIME-Version: 1.0
In-Reply-To: <20190902181000.25638-1-zahari.doychev@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 1/2] net: bridge: use mac_len in bridge
 forwarding
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zahari Doychev <zahari.doychev@linux.com>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, simon.horman@netronome.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, makita.toshiaki@lab.ntt.co.jp, xiyou.wangcong@gmail.com, johannes@sipsolutions.net, alexei.starovoitov@gmail.com

Hi Zahari,

Sorry for reviewing this late.

On 2019/09/03 3:09, Zahari Doychev wrote:
...
> @@ -466,13 +466,14 @@ static bool __allowed_ingress(const struct net_bridge *br,
>   		/* Tagged frame */
>   		if (skb->vlan_proto != br->vlan_proto) {
>   			/* Protocol-mismatch, empty out vlan_tci for new tag */
> -			skb_push(skb, ETH_HLEN);
> +			skb_push(skb, skb->mac_len);
>   			skb = vlan_insert_tag_set_proto(skb, skb->vlan_proto,
>   							skb_vlan_tag_get(skb));

I think we should insert vlan at skb->data, i.e. mac_header + mac_len, while this
function inserts the tag at mac_header + ETH_HLEN which is not always the correct
offset.

>   			if (unlikely(!skb))
>   				return false;
>   
>   			skb_pull(skb, ETH_HLEN);

Now skb->data is mac_header + ETH_HLEN which would be broken when mac_len is not
ETH_HLEN?

> +			skb_reset_network_header(skb);
>   			skb_reset_mac_len(skb);
>   			*vid = 0;
>   			tagged = false;
> 

Toshiaki Makita
