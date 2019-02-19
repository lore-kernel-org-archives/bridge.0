Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=EycVL/yRJf9l/jhEd/DHiUNShu4F20ew7k72y+Oiwcg=;
	b=gn+fKGe90SO0vy/hbXvumClU530kfTDF9lboSmIiQOOq7AShrAd8LYDHXA/HGhV8Iy
	RYXmSLgzzEKHJrjUk4qNif7+kcQ5TjySHuradUyrU02menBiaEaDoTwgd35cNvZMj7NI
	uDP/I3mcZN9KiXNpqwNr+Df3hBlvebhNNiGNM=
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190218122107.10097-1-nikolay@cumulusnetworks.com>
	<20190219085716.GD10191@otheros> <20190219092125.GE10191@otheros>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <7a95e759-12dd-7e7b-f2ce-f9e7f3d473f2@cumulusnetworks.com>
Date: Tue, 19 Feb 2019 15:31:42 +0200
MIME-Version: 1.0
In-Reply-To: <20190219092125.GE10191@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [RFC v2] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, f.fainelli@gmail.com, idosch@idosch.org

On 19/02/2019 11:21, Linus Lüssing wrote:
> On Tue, Feb 19, 2019 at 09:57:16AM +0100, Linus Lüssing wrote:
>> On Mon, Feb 18, 2019 at 02:21:07PM +0200, Nikolay Aleksandrov wrote:
>>> This is v2 of the RFC patch which aims to forward packets to known
>>> mdsts' ports only (the no querier case). After v1 I've kept
>>> the previous behaviour when it comes to unregistered traffic or when
>>> a querier is present. All of this is of course only with snooping
>>> enabled. So with this patch the following changes should occur:
>>>  - No querier: forward known mdst traffic to its registered ports,
>>>                no change about unknown mcast (flood)
>>>  - Querier present: no change
>>>
>>> The reason to do this is simple - we want to respect the user's mdb
>>> configuration in both cases, that is if the user adds static mdb entries
>>> manually then we should use that information about forwarding traffic.
>>>
>>> What do you think ?
>>>
>>> * Notes
>>> Traffic that is currently marked as mrouters_only:
>>>  - IPv4: non-local mcast traffic, igmp reports
>>>  - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports
>>>
>>> Simple use case:
>>>  $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
>>>  $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
>>>  - without a querier currently traffic for 239.0.0.1 will still be flooded,
>>>    with this change it will be forwarded only to swp1
>>
>> There is still the issue with unsolicited reports adding mdst
>> entries here, too. Leading to unwanted packet loss and connectivity issues.
> 
> Or in other words, an unsolicited report will turn a previously
> unregistered multicast group into a registered one. However in the
> absence of a querier the knowledge about this newly registered multicast group
> will be incomplete. And therefore still needs to be flooded to avoid packet
> loss.
> 

Right, this is expected. If the user has enabled igmp snooping and doesn't have
a querier present then such behaviour is to be expected. What is surprising is
the user explicitly enabling igmp snooping, adding an mdst and then still
getting it flooded. :)
An alternative is to drop all unregistered traffic when a querier is not present.
But that will surely break setups and at best should be a configurable option that
is disabled by default.

So in effect and to try and make everybody happy we can add an option to control
this behaviour with keeping the current as default and adding the following options:
 - no querier: flood all (default, current)
 - no querier: flood unregistered, forward registered
 - no querier: drop unregistered, forward registered
