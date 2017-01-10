Return-Path: <nbd@nbd.name>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; 
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
	bh=KjVTWGh4rO0uECwfxUN6K0EqlMuPEvxbvyWr9UgCtVg=; 
	b=pEAGa8atniyITLWQkjxXWUFVGV2S/SPggRUppEJSmA5KqlfU3Z3JikhKiivNRG7rDI1q4sbnTdFmoqZ9uXDDmPVYh81gG2mhRx6HjSS0+1oVffOnnFB23z+1gnOJCnc9bIFRjqexN0rQdwrQQbsIjWW/L6bvtWSk1eI4gwFv7ik=;
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<8836daaa-9638-4502-d079-fd428595f822@nbd.name>
	<1483710841.12677.1.camel@sipsolutions.net>
	<22fad045-57c6-7789-d19f-f47bd0faf441@fami-braun.de>
	<20170107145516.GE3134@otheros>
	<1483949336.17582.3.camel@sipsolutions.net>
	<6f5ec9f1-800a-2bc4-2f41-9d803343bb22@fami-braun.de>
	<20170109212345.GA5513@otheros> <20170109133032.221f8669@xeon-e3>
	<20170110041816.GJ5513@otheros>
	<1484045763.1014.0.camel@sipsolutions.net>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <73f29777-cf95-de99-f7a9-9d82e94c298d@nbd.name>
Date: Tue, 10 Jan 2017 22:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <1484045763.1014.0.camel@sipsolutions.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, "M. Braun" <michael-dev@fami-braun.de>

On 2017-01-10 11:56, Johannes Berg wrote:
> On Tue, 2017-01-10 at 05:18 +0100, Linus Lüssing wrote:
>> On Mon, Jan 09, 2017 at 01:30:32PM -0800, Stephen Hemminger wrote:
>> > I wonder if MAC80211 should be doing IGMP snooping and not bridge
>> > in this environment.
>> 
>> In the long term, yes. For now, not quite sure.
> 
> There's no "for now" in the kernel. Code added now will have to be
> maintained essentially forever.
I'm not sure that putting the IGMP snooping code in mac80211 is a good
idea, that would be quite a bit of code duplication.
This implementation works, it's very simple, and it's quite flexible for
a number of use cases.

Is there any remaining objection to merging this in principle (aside
from potential issues with the code)?

- Felix
