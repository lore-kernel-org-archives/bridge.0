Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=5ZKbS5mFW0wYcfmERfQx2D+wsG6WIRzsydtnS1G3otA=;
 b=kTRmGMVKJL4Lbotut2iU3K6cxKxnhKkntNjNs4zGWHEPXgAvf8m3/8Dh71lAvt0U7+
 9Un3v9b12rqAPg7D5UjNmQ9hAavvbtdb+ck9bL/6NWkkcG49ak7BtkfDBKiz2mhOfNCZ
 xiUeBctyZ+97hKJwS3BkUDRag/+M+bIhPpOEYXRLVRCGMJOHEztwsRRBuPHlnSsHlLIW
 dbEKlU8WUQK69mt1WdQXpOXo5OGTMMtJu9mH8N2/I9U5Elyn9whK3zDZ3Zg7HFqNHRsT
 ZzpCyOgFhznESvKXnABLIJLPaUM8/AVHhtS9KtjfXeKMJOxDDiRi54brFA5N96UURMZ5
 Xrdg==
Message-ID: <586b97b3-0882-b42c-20f8-275a05b51beb@blackwall.org>
Date: Wed, 13 Apr 2022 12:00:40 +0300
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-9-troglobit@gmail.com>
 <ebd182a2-20bc-471c-e649-a2689ea5a5d1@blackwall.org>
 <87v8ve9ppr.fsf@gmail.com>
 <5d597756-2fe1-e7cc-9ef3-c0323e2274f2@blackwall.org>
 <87pmll9xj1.fsf@gmail.com>
 <96bb8ff0-26d8-e9d3-e7c8-78f2abd28126@blackwall.org>
In-Reply-To: <96bb8ff0-26d8-e9d3-e7c8-78f2abd28126@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 08/13] net: bridge: avoid
 classifying unknown multicast as mrouters_only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On 13/04/2022 11:55, Nikolay Aleksandrov wrote:
> On 13/04/2022 11:51, Joachim Wiberg wrote:
>> On Tue, Apr 12, 2022 at 20:37, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>> On 12/04/2022 20:27, Joachim Wiberg wrote:
>>>> [snip]
>>>> From this I'd like to argue that our current behavior in the bridge is
>>>> wrong.  To me it's clear that, since we have a confiugration option, we
>>>> should forward unknown IP multicast to all MCAST_FLOOD ports (as well as
>>>> the router ports).
>>> Definitely not wrong. In fact:
>>> "Switches that do not forward unregistered packets to all ports must
>>>  include a configuration option to force the flooding of unregistered
>>>  packets on specified ports. [..]"
>>> is already implemented because the admin can mark any port as a router and
>>> enable flooding to it.
>>
>> Hmm, I understand your point (here and below), and won't drive this
>> point further.  Instead I'll pick up on what you said in your first
>> reply ... (below, last)
>>
>> Btw, thank you for taking the time to reply and explain your standpoint,
>> really helps my understanding of how we can develop the bridge further,
>> without breaking userspace! :)
>>
>>>> [1]: https://www.rfc-editor.org/rfc/rfc4541.html#section-2.1.2
>>> RFC4541 is only recommending, it's not a mandatory behaviour. This
>>> default has been placed for a very long time and a lot of users and
>>> tests take it into consideration.
>>
>> Noted.
>>
>>> We cannot break such assumptions and start suddenly flooding packets,
>>> but we can leave it up to the admin or distribution/network software
>>> to configure it as default.
>>
>> So, if I add a bridge flag, default off as you mentioned out earlier,
>> which changes the default behavior of MCAST_FLOOD, then you'd be OK with
>> that?  Something cheeky like this perhaps:
>>
>>     if (!ipv4_is_local_multicast(ip_hdr(skb)->daddr))
>>        	BR_INPUT_SKB_CB(skb)->mrouters_only = !br_opt_get(br, BROPT_MCAST_FLOOD_RFC4541);
> 
> Exactly! And that is exactly what I had in mind when I wrote it. :)
> 

Just please use a different option name that better suggests what it does.

> Thanks,
>  Nik
> 
>>
>>
>> Best regards
>>  /Joachim
> 

