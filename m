Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ndNg3WtDLIttVFsm3x2TpqdqpBJA/tcuM6+Wyd8nO5o=;
	b=al7hkxUI5AcCMD3vdbRxiV7dzRTuz5R59XPHfkVukDahhdZAEupSoP3ya+39Vel9Kd
	hmHdbR9gUUOjHfATwI3pMdvJJFQC1p8o0BUVQI3B11m7aLO4RS8pfWKfjgHu3HOhlNVm
	AivNQCRN1jm5ONeb0mAjwzfxyt02BfRefujS/yUO7zUhrMcwwzLa6viBrKK5vqo8GsXJ
	zLTq+Jblam2Im116kC3QoeS+wK9UYmSyn7FZrQ5Ootrn/k2PQRE/lgZIAl+1H4L+/ERl
	CJfpdrQf3Sd+eCRJoGruMP7BLRb41IlwZJonOxwkePQR3BpQ5DiRYDjo0l6kh4/ivtfO
	UzRg==
References: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
	<20190826123811.GA13411@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <98230ad4-cf0a-b496-d4de-d3abf77d9741@gmail.com>
Date: Mon, 26 Aug 2019 10:01:33 -0700
MIME-Version: 1.0
In-Reply-To: <20190826123811.GA13411@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 0/3] Add NETIF_F_HW_BR_CAP feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: alexandre.belloni@bootlin.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

On 8/26/19 5:38 AM, Andrew Lunn wrote:
> On Mon, Aug 26, 2019 at 10:11:12AM +0200, Horatiu Vultur wrote:
>> When a network port is added to a bridge then the port is added in
>> promisc mode. Some HW that has bridge capabilities(can learn, forward,
>> flood etc the frames) they are disabling promisc mode in the network
>> driver when the port is added to the SW bridge.
>>
>> This patch adds the feature NETIF_F_HW_BR_CAP so that the network ports
>> that have this feature will not be set in promisc mode when they are
>> added to a SW bridge.
>>
>> In this way the HW that has bridge capabilities don't need to send all the
>> traffic to the CPU and can also implement the promisc mode and toggle it
>> using the command 'ip link set dev swp promisc on'
> 
> Hi Horatiu
> 
> I'm still not convinced this is needed. The model is, the hardware is
> there to accelerate what Linux can do in software. Any peculiarities
> of the accelerator should be hidden in the driver.  If the accelerator
> can do its job without needing promisc mode, do that in the driver.
> 
> So you are trying to differentiate between promisc mode because the
> interface is a member of a bridge, and promisc mode because some
> application, like pcap, has asked for promisc mode.
> 
> dev->promiscuity is a counter. So what you can do it look at its
> value, and how the interface is being used. If the interface is not a
> member of a bridge, and the count > 0, enable promisc mode in the
> accelerator. If the interface is a member of a bridge, and the count >
> 1, enable promisc mode in the accelerator.

That is an excellent suggestion actually.

Horatiu, the other issue with your approach here is that the features
don't propagate to/from lower/upper/real devices, so if e.g.: you have a
VLAN interface enslaved as a part of the bridge, or a bond, or a tunnel
interface, the logic won't make us check NETIF_F_HW_BR_CAP because those
virtual network devices won't inherit it from their real device. I am
not suggesting you fix this with your patch series, but rather, seek a
driver local solution.
-- 
Florian
