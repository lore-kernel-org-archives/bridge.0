Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=r3ZtV6/3p8+1zZTRGIE7ARCZeIbcdQoYiizKfuD75Jk=;
	b=MO4LbbBbq4JzbydvtrYTcQtiwwYiG8Ic8e/iV/5DQ1g48PQ9YvG7ZHSuBXTjJB3yur
	IRNgONxFFNCl2z44BLosagqSDwWWTrNUNE+OVYntZJCuxSlKRHmtmVaN9zQ3ZCitaVHG
	vOXKZVQrakuW4bozhtZfnLFOnzMelorZZYJ98=
References: <20181217094623.32668-1-yuehaibing@huawei.com>
	<e9b1e56e-4c37-aff4-b855-2523eae1ef49@cumulusnetworks.com>
	<d0c9ac6a-5c23-84dc-f45f-28bc2a3d20fe@huawei.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1ea956e2-ea17-2fb4-30c4-194e438514a6@cumulusnetworks.com>
Date: Mon, 17 Dec 2018 13:21:08 +0200
MIME-Version: 1.0
In-Reply-To: <d0c9ac6a-5c23-84dc-f45f-28bc2a3d20fe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: remove unneeded variable
	'err'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, roopa@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

On 17/12/2018 13:16, YueHaibing wrote:
> On 2018/12/17 17:51, Nikolay Aleksandrov wrote:
>> On 17/12/2018 11:46, YueHaibing wrote:
>>> function br_multicast_toggle now always return 0,
>>> so the variable 'err' is unneeded.
>>> Also cleanup dead branch in br_changelink.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  net/bridge/br_multicast.c | 3 +--
>>>  net/bridge/br_netlink.c   | 4 +---
>>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>>
>>
>> That is correct, but in such case just make it void.
> 
> In net/bridge/br_sysfs_br.c:
> 
> static ssize_t multicast_snooping_store(struct device *d,
>                                         struct device_attribute *attr,
>                                         const char *buf, size_t len)
> {
>         return store_bridge_parm(d, buf, len, br_multicast_toggle);
> }
> 
> and store_bridge_parm need the returned err.
> 

That can be worked-around with a set option that returns 0 but it's not that
important.

Fair enough,
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

