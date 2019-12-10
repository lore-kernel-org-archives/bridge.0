Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mh1MDhoccZ8LcGj7No6Pp5Z8k1gtAci1d0+A5gGxl1E=;
 b=eXFdChDloDkEyFWlQ+kb/rD3xmn4wMBfccyqSQplXrWA9vQHvu59MGI5/jck3JYQms
 hlnBt7+yDu3vS2w3tH9wqyAEvXEUG9uDyW0lwjzbmdynzznqx5UaflGPOhWygHzAApMI
 7QnlL2qtXQNxiVoy2xtO6Rma2PeITxY3tGsdg=
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
 <20191210143931.GF1344570@t480s.localdomain>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2f4e351c-158a-4f00-629f-237a63742f66@cumulusnetworks.com>
Date: Tue, 10 Dec 2019 21:50:10 +0200
MIME-Version: 1.0
In-Reply-To: <20191210143931.GF1344570@t480s.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On 10/12/2019 21:39, Vivien Didelot wrote:
> Hi Nikolay,
> 
> On Tue, 10 Dec 2019 09:49:59 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Why did you send the bridge patch again ? Does it have any changes ?
> 
> The second iproute2 patch does not include the include guards update, but
> I kept the bridge_stp_stats structure and the BRIDGE_XSTATS_STP definition
> otherwise iproute2 wouldn't compile.
> >>
>> Why do you need percpu ? All of these seem to be incremented with the
>> bridge lock held. A few more comments below.
> 
> All other xstats are incremented percpu, I simply followed the pattern.
> 

We have already a lock, we can use it and avoid the whole per-cpu memory handling.
It seems to be acquired in all cases where these counters need to be changed.

>>>  	struct net_bridge_port *p
>>>  		= container_of(kobj, struct net_bridge_port, kobj);
>>> +	free_percpu(p->stp_stats);
>>
>> Please leave a new line between local var declaration and the code. I know
>> it was missing, but you can add it now. :)
> 
> OK.
> 
>>> +	if (p) {
>>> +		struct bridge_stp_xstats xstats;
>>
>> Please rename the local var here, using just xstats is misleading.
>> Maybe stp_xstats ?
> 
> This isn't misleading to me since its scope is limited to the current block
> and not the entire function. The block above dumping the VLAN xstats is
> using a local "struct br_vlan_stats stats" variable for example.
> 

Yep, as I answered to myself earlier, with the below change this goes away.

>>
>>> +
>>> +		br_stp_get_xstats(p, &xstats);
>>> +
>>> +		if (nla_put(skb, BRIDGE_XSTATS_STP, sizeof(xstats), &xstats))
>>> +			goto nla_put_failure;
>>
>> Could you please follow how mcast xstats are dumped and do something similar ?
>> It'd be nice to have similar code to audit.
> 
> Sure. I would also love to have easily auditable code in net/bridge. For
> the bridge STP xstats I followed the VLAN xstats code above, which does:
> 
>     if (nla_put(skb, BRIDGE_XSTATS_VLAN, sizeof(vxi), &vxi))
>         goto nla_put_failure;
> 

Yeah, we can move that to a vlan-specific helper too, but that is an unrelated change.

> But I can change the STP xstats code to the following:
> 
>     if (p) {
>         nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_STP,
>                                 sizeof(struct bridge_stp_xstats),
>                                 BRIDGE_XSTATS_PAD);
>         if (!nla)
>             goto nla_put_failure;
> 
>         br_stp_get_xstats(p, nla_data(nla));
>     }
> 
> Would that be preferred?
> 
> 

Perfect, thanks!

> Thanks,
> 
> 	Vivien
> 

