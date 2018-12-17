Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 17 Dec 2018 14:15:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1545052553; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=mJGarG4tMUacjbnlXsm9zVEtrABr67AJTeSTyGx+0k0=;
	b=IAuV1Q2tDI/rHkHwkBwnBUHfPMXFaQT2AnWc0ycGVepNBMTYii6LJSYmq39WH5hBLDG6b3
	ynklp2Uwg30mX+05i6Q/YkPb29nEZAzr9u/NOzajSEXon0E/zq2Gch3S1Xp1KYN+/LUoVv
	mI2SGggXEUWFfs56FuaeCLBUkDNUUdsdvhClCQd/oCCAFI8gTPCLTnaNJ4AFpAKYM4ndWy
	pxG6lhTBo+yD0JXa6XqEV7CyFHbsIW8cCPLPJHKJ+3n50Myw8wLvHD0X7NVEyYPDPCVG0j
	GUcXwU6DLC+wXkNq60QeQrcbSxEihVLfz3WX2T6kPv1gzbimcftWjoXOxJyxfg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181217131550.GP1713@otheros>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
	<20181213161027.GC1713@otheros>
	<CALRz_Py6ogxQsnR-5w-92At1z51M76bgMAeO9A9xqhCFy1pApA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALRz_Py6ogxQsnR-5w-92At1z51M76bgMAeO9A9xqhCFy1pApA@mail.gmail.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: remove ipv6 zero address
 check in mcast queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ying Xu <yinxu@redhat.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, liuhangbin@gmail.com, davem@davemloft.net

Hi and thanks for your reply!

On Fri, Dec 14, 2018 at 10:32:16AM +0800, Ying Xu wrote:
>  I think the scenario mentioned above is abnormal.

Can we agree, that this scenario, if switch A and B were using the
current bridge code, has issues right now which it did
not have before that patch?

I also do not quite understand what you mean with "abnormal". Do
you think that it is unlikely to have two snooping switches and
general queries with a 0.0.0.0 source?

Note that with the current bridge code and according to RFC3376
and RFC2236, as soon as a query with a 0.0.0.0 source is sent somewhere
in the broadcast domain, it will become the selected querier [*].


> The source of query indicats that is a real router or only a switch.(0.0.0.0
> means switch,non-zero means router).
> In the scenario above,the switch A was selected to be a querier that means A
> performs as a router,
> so switch A should config its query source address to non-zero,and then Host A
> can recieve the traffic from B.

Even if in the described scenario switch A were configured to use a a non-zero source
address to become a router, so that switch B would mark the port
to switch A as a multicast router port, switch A would still loose
in the querier election right now, as 0.0.0.0 is lower (RFC3376, RFC2236). So switch
B would then become the selected querier with its 0.0.0.0 source
and switch A would become silent even though it had a non-zero
source address.

And then we would have the same issue again, only swapped between
host+switch A and host+switch B.

Would you agree, does that make sense?

Regards, Linus


[*]: Looking at br_ip4_multicast_select_querier():

If previously selected querier were 0.0.0.0, it would accept any
source as a new querier ("!br->ip4_querier.addr.u.ip4"). However,
if the previously selected querier were non-zero, a query with
0.0.0.0 would win, too
("ntohl(saddr) <= ntohl(br->ip4_querier.addr.u.ip4)").
