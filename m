Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FaAv73c7/caKA+SdXX+K+mh6Cm/86re9CSFJB7tkoPQ=;
	b=KW0x3QFgAkbJtmPiI15VrDGcIK27GRcEgALtT7jEwcEraGN0NVvEz0pwJrsydt95ER
	Gscowby0iaA/F56RCBP3ZeYqmxbBk0IT8HWNux4xxYpbZXYyoOy5qSmYe11ZL7x4A70k
	GOuwSowPaBiPvlK5jU1gZjN8I57ndtLQhpu2M=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
	<20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
	<b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
	<e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
	<20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
	<b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
	<20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
	<95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
Message-ID: <f4347439-0b96-f7f6-db34-4c7afbeba141@cumulusnetworks.com>
Date: Mon, 29 Jul 2019 15:50:18 +0300
MIME-Version: 1.0
In-Reply-To: <95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, Horatiu Vultur <horatiu.vultur@microchip.com>

On 29/07/2019 15:22, Nikolay Aleksandrov wrote:
> Hi Allan,
> On 29/07/2019 15:14, Allan W. Nielsen wrote:
>> Hi Nikolay,
>>
>> First of all, as mentioned further down in this thread, I realized that our
>> implementation of the multicast floodmasks does not align with the existing SW
>> implementation. We will change this, such that all multicast packets goes to the
>> SW bridge.
>>
>> This changes things a bit, not that much.
>>
>> I actually think you summarized the issue we have (after changing to multicast
>> flood-masks) right here:
>>
>> The 07/26/2019 12:26, Nikolay Aleksandrov wrote:
>>>>> Actually you mentioned non-IP traffic, so the querier stuff is not a problem. This
>>>>> traffic will always be flooded by the bridge (and also a copy will be locally sent up).
>>>>> Thus only the flooding may need to be controlled.
>>
>> This seems to be exactly what we need.
>>
>> Assuming we have a SW bridge (br0) with 4 slave interfaces (eth0-3). We use this
>> on a network where we want to limit the flooding of frames with dmac
>> 01:21:6C:00:00:01 (which is non IP traffic) to eth0 and eth1.
>>
>> One way of doing this could potentially be to support the following command:
>>
>> bridge fdb add    01:21:6C:00:00:01 port eth0
>> bridge fdb append 01:21:6C:00:00:01 port eth1
>>

And the fdbs become linked lists ? So we'll increase the complexity for something
that is already supported by ACLs (e.g. tc) and also bridge per-port multicast
flood flag ?

I'm sorry but that doesn't sound good to me for a case which is very rare and
there are existing ways to solve without incurring performance hits or increasing
code complexity.

>> On 25/07/2019 16:06, Nikolay Aleksandrov wrote:
>>>>>>>>>  In general NLM_F_APPEND is only used in vxlan, the bridge does not
>>>>>>>>>  handle that flag at all.  FDB is only for *unicast*, nothing is joined
>>>>>>>>>  and no multicast should be used with fdbs. MDB is used for multicast
>>>>>>>>>  handling, but both of these are used for forwarding.
>> This is true, and this should have been addressed in the patch, we were too
>> focused on setting up the offload patch in the driver, and forgot to do the SW
>> implementation.
>>
>> Do you see any issues in supporting this flag, and updating the SW
>> forwarding in br_handle_frame_finish such that it can support/allow a FDB entry
>> to be a multicast?
>>
> 
> Yes, all of the multicast code is handled differently, it doesn't go through the fdb
> lookup or code at all. I don't see how you'll do a lookup in the fdb table with a
> multicast mac address, take a look at br_handle_frame_finish() and you'll notice
> that when a multicast dmac is detected then we use the bridge mcast code for lookups
> and forwarding. If you're trying to achieve Rx only on the bridge of these then
> why not just use Ido's tc suggestion or even the ip maddr add offload for each port ?
> 
> If you add a multicast mac in the fdb (currently allowed, but has no effect) and you
> use dev_mc_add() as suggested that'd just be a hack to pass it down and it is already
> possible to achieve via other methods, no need to go through the bridge.
> 
>> /Allan
>>
> 

