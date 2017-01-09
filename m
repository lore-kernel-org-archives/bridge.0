Return-Path: <michael-dev@fami-braun.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1483975594;
	l=533; s=domk; d=fami-braun.de;
	h=References:In-Reply-To:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-Type:MIME-Version;
	bh=W7HqhB3iY200vGo80MMpgmxZWcuJCkMxjraKAuXbabk=;
	b=EuFgJZRa7up4GJkgQifP8Pn+/ZO8zrRm5hdpc5IZomcMtTn6AJdADzziKCINt/gNkx
	Th5nfPe58TcHt8ReETmuy7JDDAqVm4E8T6B8N+XGpPxuMdhP40+YFb0zQ5Z/XdsXrLEt
	ufaB3uQVPwOqhSTMaapKeiAS5KUvYpH97J6CU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2017 16:25:54 +0100
From: michael-dev <michael-dev@fami-braun.de>
In-Reply-To: <1483964159.17582.34.camel@sipsolutions.net>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<8836daaa-9638-4502-d079-fd428595f822@nbd.name>
	<1483710841.12677.1.camel@sipsolutions.net>
	<22fad045-57c6-7789-d19f-f47bd0faf441@fami-braun.de>
	<20170107145516.GE3134@otheros>
	<1483949336.17582.3.camel@sipsolutions.net>
	<6f5ec9f1-800a-2bc4-2f41-9d803343bb22@fami-braun.de>
	<1483964159.17582.34.camel@sipsolutions.net>
Message-ID: <ebc5050e12c04273fa518e35d7f0b8bc@fami-braun.de>
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

Am 09.01.2017 13:15, schrieb Johannes Berg:
>> That is bridge fdb entries (need to) expire so the bridge might
>> "forget" a still-connected station not sending but only consuming
>> broadcast traffic.
> 
> Ok, that I don't know. Somehow if you address a unicast packet there
> the bridge has to make a decision - so it really should know?

If the bridge has not learned the unicast destination mac address on any 
port, it will flood the packet on all ports except the port it received 
the packet on.

Regards,
M. Braun
