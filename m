Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=hQiPzWxvnpkWNbMqkCMWGKGOuScBFYwQeSI9ij30x08=;
	b=GhCwRnvdds8KBtN4iFv2W3DVlt3DWvoYZRd/CsXZllkwiS8Nhzt1yCo6ymxP0u7xBh
	eCYZ/u7NHnDg9jnRKv3rB7lxPOhTkEeS7FVlmosef9csr8tAiic9tJ3WmSAnRFUo21Yz
	Nz5tT3MEbQbpRDbX/ILlyihRmA3QPla26sthk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <1564663840-27721-1-git-send-email-horatiu.vultur@microchip.com>
	<f758fdbf-4e0a-57b3-f13d-23e893ba7458@cumulusnetworks.com>
	<1db865a6-9deb-fbd2-dee6-83609fcc2d95@cumulusnetworks.com>
Message-ID: <696c9bcc-f7e3-3d22-69c4-cdf4f37280a9@cumulusnetworks.com>
Date: Thu, 1 Aug 2019 17:15:46 +0300
MIME-Version: 1.0
In-Reply-To: <1db865a6-9deb-fbd2-dee6-83609fcc2d95@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [net-next,
	rfc] net: bridge: mdb: Extend with multicast LLADDR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, idosch@mellanox.com, andrew@lunn.ch, allan.nielsen@microchip.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, tglx@linutronix.de, davem@davemloft.net

On 01/08/2019 17:11, Nikolay Aleksandrov wrote:
> On 01/08/2019 17:07, Nikolay Aleksandrov wrote:
>> Hi Horatiu,
>> Overall I think MDB is the right way, we'd like to contain the multicast code.
>> A few comments below.
>>
>> On 01/08/2019 15:50, Horatiu Vultur wrote:
> [snip]
>>>
>>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>>> Co-developed-by: Allan W. Nielsen <allan.nielsen@microchip.com>
>>> Signed-off-by: Allan W. Nielsen <allan.nielsen@microchip.com>
>>> ---
>>>  include/linux/if_bridge.h      |  1 +
>>>  include/uapi/linux/if_bridge.h |  1 +
>>>  net/bridge/br_device.c         |  7 +++++--
>>>  net/bridge/br_forward.c        |  3 ++-
>>>  net/bridge/br_input.c          | 13 ++++++++++--
>>>  net/bridge/br_mdb.c            | 47 +++++++++++++++++++++++++++++++++++-------
>>>  net/bridge/br_multicast.c      |  4 +++-
>>>  net/bridge/br_private.h        |  3 ++-
>>>  8 files changed, 64 insertions(+), 15 deletions(-)
>>>
>>
>> Overall I don't think we need this BR_PKT_MULTICAST_L2, we could do the below much
>> easier and without the checks if you use a per-mdb flag that says it's to be treated
>> as a MULTICAST_L2 entry. Then you remove all of the BR_PKT_MULTICAST_L2 code (see the
>> attached patch based on this one for example). and continue processing it as it is processed today.
>> We'll keep the fast-path with minimal number of new conditionals.
>>
>> Something like the patch I've attached to this reply, note that it is not complete
>> just to show the intent, you'll have to re-work br_mdb_notify() to make it proper
>> and there're most probably other details I've missed. If you find even better/less
>> complex way to do it then please do.
>>
>> Cheers,
>>  Nik
> 
> Oops, I sent back your original patch. Here's the actually changed version
> I was talking about.
> 
> Thanks,
>  Nik
> 
> 
> 

The querier exists change is a hack just to get the point, I'd prefer
to re-write that portion in a better way which makes more sense, i.e.
get that check out of there since it doesn't mean that an actual querier
exists. :)

