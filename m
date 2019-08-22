Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:references:message-id:date:user-agent:mime-version
	:in-reply-to:content-language:content-transfer-encoding;
	bh=tl0f02UPpp3QSnTEonqbC2evIwlfUUJ6tMhF98nlrXY=;
	b=T+4E4T3+BvqIxVHuiB70tNqFlTbRn6cEaa91bPZ4FRi3yJDAbv87VEoDtPgsRahlZG
	GNmis1OL1anAfBZjbf/64jQuoykB2tOpum/BojewUCKcD/o9ZpBLai+c/kAiZSf0ziTN
	/e/xpWHwwMXhHiTJjFIHJM9lke90Rvq3yyySg=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
Message-ID: <b2c52206-82d1-ef28-aeec-a5dcdbe9df6c@cumulusnetworks.com>
Date: Fri, 23 Aug 2019 01:26:12 +0300
MIME-Version: 1.0
In-Reply-To: <1e16da88-08c5-abd5-0a3e-b8e6c3db134a@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, roopa@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 8/23/19 1:09 AM, Nikolay Aleksandrov wrote:
> On 22/08/2019 22:07, Horatiu Vultur wrote:
>> Current implementation of the SW bridge is setting the interfaces in
>> promisc mode when they are added to bridge if learning of the frames is
>> enabled.
>> In case of Ocelot which has HW capabilities to switch frames, it is not
>> needed to set the ports in promisc mode because the HW already capable of
>> doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
>> HW has bridge capabilities. Therefore the SW bridge doesn't need to set
>> the ports in promisc mode to do the switching.
>> This optimization takes places only if all the interfaces that are part
>> of the bridge have this flag and have the same network driver.
>>
>> If the bridge interfaces is added in promisc mode then also the ports part
>> of the bridge are set in promisc mode.
>>
>> Horatiu Vultur (3):
>>   net: Add HW_BRIDGE offload feature
>>   net: mscc: Use NETIF_F_HW_BRIDGE
>>   net: mscc: Implement promisc mode.
>>
>>  drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
>>  include/linux/netdev_features.h    |  3 +++
>>  net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
>>  net/core/ethtool.c                 |  1 +
>>  4 files changed, 56 insertions(+), 3 deletions(-)
>>
> 

Just to clarify:
> IMO the name is misleading.
- that's not mandatory or anything, just saying people might get confused when they see it

> Why do the devices have to be from the same driver ? This is too specific targeting some
> devices. The bridge should not care what's the port device, it should be the other way
That was mostly a rhetorical question, it's obvious why but please add an explanation
at least in the commit message and please fix the typos in the comment. Also HW
is capable of doing switching, this needs some clarification that the whole process
stays in HW IIUC. More details here would be great.

> around, so adding device-specific code to the bridge is not ok. Isn't there a solution
> where you can use NETDEV_JOIN and handle it all from your driver ?
> Would all HW-learned entries be hidden from user-space in this case ?
> 
I.e. isn't there a way to do this without introducing a new feature flag ?
 

