Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=CX+W2vODD3zGUj/joWK7YfYg9vtMH4AGLIbP0a3owOM=;
	b=NmKGubUQ61jLeyg5LFUsUxAHzdospAsPZVPSOgfWpOB6Lh8DQv0SyO+dAa4fBn1cxe
	WC97uvjLQUT3tX2qHRzDbAJBnhjdaodWudOAQwGgy29wXvsqmE76NpYns42K4EXnvDvk
	E28nfl6itmpuKBWeM9hKMakSqkjmbHAwaiTKo=
References: <319fda43-195d-2b92-7f62-7e273c084a29@cumulusnetworks.com>
	<20190731224955.10908-1-nikolay@cumulusnetworks.com>
	<20190731155338.15ff34cb@hermes.lan>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c9a68f85-49f6-6d02-e130-a03d540aa0a7@cumulusnetworks.com>
Date: Thu, 1 Aug 2019 02:32:51 +0300
MIME-Version: 1.0
In-Reply-To: <20190731155338.15ff34cb@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: move vlan init/deinit to
 NETDEV_REGISTER/UNREGISTER
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, michael-dev <michael-dev@fami-braun.de>

On 8/1/19 1:53 AM, Stephen Hemminger wrote:
>   
>> -int br_vlan_init(struct net_bridge *br)
>> +static int br_vlan_init(struct net_bridge *br)
>>  {
>>  	struct net_bridge_vlan_group *vg;
>>  	int ret = -ENOMEM;
>> @@ -1083,6 +1085,8 @@ int br_vlan_init(struct net_bridge *br)
>>  	return ret;
>>  
>>  err_vlan_add:
>> +	RCU_INIT_POINTER(br->vlgrp, NULL);
>> +	synchronize_rcu();
> 
> Calling sychronize_rcu is expensive. And the callback for
> notifier is always called with rtnl_head. 
> 
> Why not just keep the pointer initialization back in the
> code where bridge is created, it was safe there.
> 

Because now the device registered and we've published the group, right now
it is not an issue but if we expose an rcu helper we'll have to fix this
because it'd become a bug.
I'd prefer to have the error path correct and future-proof it, since it's
an error path we're not concerned with speed, but rather correctness. Also
these are rarely exercised so the bug might remain for a very long time.


