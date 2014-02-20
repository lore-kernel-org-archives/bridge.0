Return-Path: <mcgrof@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=6Pq6i3kvQvSXZ/ZthAL87tb1UoVOiu66agHzyUPH5uw=;
	b=iHZ6oA/wj4HT52ZPL6bYTn9N4/8gYUbrvT54MPxMpt5FBZz+16/aEREjMmydy9qs4R
	YyNdFgj6dxiqIARMIIhiQh5/Q/D0kxN+VjSA/w9lnrTa9Zb8ielIIpJYp4hRfKWlouVx
	jmHnZIBDUBaEJK7D16t1t7/j+aj2ajZ7hFaC6fiTHbdRVALPD/SEiaODOmOOIBELRM4A
	kfmU8TFujJ7BQAwc6uri+I7mWe6XYE8bEFKfViVN4aljorh8/AEllA0xUhwsA0WFzOb6
	2j0DovO2VqmPHAX2TSDCa6fAm0Js+rcu4COUTyJvqry3bL13HLxb9GezCSqh+Y4638ik
	vbQA==
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <5306156B.4070105@citrix.com>
References: <1392433180-16052-1-git-send-email-mcgrof@do-not-panic.com>
	<1392433180-16052-2-git-send-email-mcgrof@do-not-panic.com>
	<53024C58.4010900@citrix.com>
	<CAB=NE6XYjOd2vRpQCZOG-S5ZW4xjam+FOPAYzribNQpb50Q5pg@mail.gmail.com>
	<5306156B.4070105@citrix.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 20 Feb 2014 12:28:37 -0800
Message-ID: <CAB=NE6U7WsN80SOoDrDYvEj9tYYdmcLriCtS-tvLDVeqGmdfwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [Xen-devel] [RFC v2 1/4] bridge: enable interfaces to
 opt out from becoming the root bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Zoltan Kiss <zoltan.kiss@citrix.com>
Cc: kvm@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, xen-devel@lists.xenproject.org

On Thu, Feb 20, 2014 at 6:47 AM, Zoltan Kiss <zoltan.kiss@citrix.com> wrote:
> On 19/02/14 16:45, Luis R. Rodriguez wrote:
>
>> You seem to describe a case whereby it can make sense for xen-netback
>> interfaces to end up becoming the root port of a bridge. Can you
>> elaborate a little more on that as it was unclear the use case.
>
> Well, I might be wrong on that, but the scenario I was thinking: a guest
> (let's say domain 1) can have multiple interfaces on different Dom0 (or
> driver domain) bridges, let's say vif1.0 is plugged into xenbr0 and vif1.1
> is in xenbr1. If the guest wants to make a bridge of this two, then using
> STP makes sense.

The bridging would happen on the front end in that case no?

>  I wanted to bring up CloudStack's virtual router as an
> example, but then I realized it's probably doesn't do such thing. However I
> don't think we should hardcode that a netback interface can't be RP ever.

My patch did allow for this but the root block flag that Stephen
mentioned can always be lifted.

  Luis
