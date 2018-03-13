Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=4NtTKFVfxj4Fh67NhSze7EjqxA1MxJV6LIpUCQcotfE=;
	b=EClsWm5rsRxdQL8GgeDH6RqnWj2wt7TxCqGJqiDrUORT2awvow3L/SSiV5lG+TY9tA
	oD5MEtZ2ZxI3RAX6TZHhdRUFB+W07geXrxTfK0IHpEpgc4J7Qw8LLDJpHwRyVWJB6AAk
	EWNuFqKspL+5CjZNA064jyp63u7v4HPdMtLTo=
MIME-Version: 1.0
In-Reply-To: <20180313011140.GA5778@lunn.ch>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-4-igor.mitsyanko.os@quantenna.com>
	<20180310165540.GH29174@lunn.ch>
	<c22c1758-e383-2930-34c8-8c8c7b8455c1@quantenna.com>
	<20180313011140.GA5778@lunn.ch>
From: Roopa Prabhu <roopa@cumulusnetworks.com>
Date: Tue, 13 Mar 2018 07:41:42 -0700
Message-ID: <CAJieiUiQeQR9YJhowk-YuRzQ1U9JP8Gz7jhZs6rkUxmqd-3i3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [RFC PATCH net-next 3/5] bridge: allow switchdev port
 to handle flooding by itself
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On Mon, Mar 12, 2018 at 6:11 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> The flag was introduced to enable hardware switch capabilities of
>> drivers/net/wireless/quantenna/qtnfmac wifi driver. It does not have any
>> switchdev functionality in upstream tree at this moment, and this patchset
>> was intended as a preparatory change.
>
> O.K. But i suggest you add basic switchdev support first. Then think
> about adding new functionality. That way you can learn more about
> switchdev, and we can learn more about your hardware.
>
>> qtnfmac driver provides several physical radios (5 GHz and 2.4 GHz), each
>> can have up to 8 virtual network interfaces. These interfaces can be bridged
>> together in various configurations, and I'm trying to figure out what is the
>> most efficient way to handle it from bridging perspective.
>
> I think the first thing to do is get this part correctly represented
> by switchdev. I don't think any of us maintainers have thought about
> how wireless and switchdev can be combined. The wifi model seems to be
> one phy device, with multiple MACs running on top of it, with each MAC
> being a single SSID.  So is it one SSID per virtual interface?  Or are
> your virtual network interfaces actually virtual phys in the wireless
> model, and you can have multiple MACs on top of each virtual phy?
>
>> My assumption was that software FDB and hardware FDB should always
>> be in sync with each other. I guess it is a safe assumption if
>> handled correctly?  Hardware should send a notification for each new
>> FDB it has learned, and switchdev driver should process FDB
>> notifications from software bridge.
>
> No, you cannot make this assumption. Take the example of DSA
> switches. They are generally connected over an MDIO bus, or an SPI
> bus. The bandwidth is small. How long do you think it takes the
> hardware to learn 8K MAC addresses with 5x 1Gbps ports receiving 64
> byte packets? DSA drivers have no way of keeping up with the
> hardware. And there is no need to. Everything works fine with the SW
> and the HW bridge having different dynamic FDB entries.
>
> I don't even think your hardware will have the hardware and software
> in sync. How fast can your hardware learn new addresses? 'Line' rate?
> Or do you prevent the hardware learning a new address until the
> software bridge has confirmed it has learnt the previous new address?
>
>> qtnfmac hardware has its own memory and maintains FWT table, so for the best
>> efficiency forwarding between virtual interfaces should be handled locally.
>> Qtnfmac can handle all the mentioned flooding by itself:
>> - unknown unicasts
>> - broadcast and unknown multicast
>> - known multicasts (does have IGMP snooping)
>> - can do multicast-to-unicast translation if required.
>>
>> The most important usecase IMO is a muticast transmission, specific example
>> being:
>> - 2.4GHz x 8 and 5GHz x 8 virtual wifi interfaces, bridged with backbone
>> ethernet interface in Linux
>> - multicast video streaming from a server behind ethernet
>> - multicast clients connected to some wifi interfaces
>
> I agree this makes sense. But we need to ensure the solution is
> generic, not something which just works for your hardware/firmware.  I
> know somebody who would love to be able to do something like this with
> DSA drivers. They would probably sacrifice IGMP snooping and just
> flood everywhere, if that is all the hardware could do. But so far,
> i've not been able to figure out a way to do this.
>


I concur with Andrews thoughts here: We already have enough switchdev
learning and flooding control.
More fine tuning can be handled at the driver layer. This solution
tries to bypass some of that and adds a new
infrastructure to control flooding in hw. And I am also afraid that
the use of this flag will propagate to
more places in the bridge driver. If none of the existing mechanisms
work, then yes, we can probably revise this
series into something generic for other switchdev users to use as well.
