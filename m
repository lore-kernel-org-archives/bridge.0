Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Feb 2019 16:42:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550590943; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=xvezpWSCgqFskYnwbHM8EIJ30mvWO61W7gRaDmJ0YPk=;
	b=R8Q42LjWMMPhEyiZmGwL9liBUYleLXOdYY7dpi3N7dis5MwjVSn6xv884OLDrRv3OQaMJE
	CzdpT7AwT47dVqmNk/yCXJm/VLw1GR03ryVjsPoBG7eopCU2L0nxQ1Hj55UaSSqjK/cnsE
	JT4OgB7N3ANLDxbww6JQg7+NZxQKqbkyWO6BH7Mn6UrWE5zAcbJpCiqRYFEbIxnST2zDsZ
	kBBD52Rc0r48rl6Q3Upu8ZHF889tyQD2Oo5EKB7ix/9xvZn2T7IQeiOnH+J6PiynrXl2/N
	+WITSHPFhJ/y5Vkn2Kb4hnnd40l6JgpmutVQNz/orpOLHbIIHm9lg3hq2bmSWg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190219154219.GG10191@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190218122107.10097-1-nikolay@cumulusnetworks.com>
	<20190219085716.GD10191@otheros> <20190219092125.GE10191@otheros>
	<7a95e759-12dd-7e7b-f2ce-f9e7f3d473f2@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a95e759-12dd-7e7b-f2ce-f9e7f3d473f2@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, f.fainelli@gmail.com, idosch@idosch.org

On Tue, Feb 19, 2019 at 03:31:42PM +0200, Nikolay Aleksandrov wrote:
> On 19/02/2019 11:21, Linus Lüssing wrote:
> > On Tue, Feb 19, 2019 at 09:57:16AM +0100, Linus Lüssing wrote:
> >> On Mon, Feb 18, 2019 at 02:21:07PM +0200, Nikolay Aleksandrov wrote:
> >>> This is v2 of the RFC patch which aims to forward packets to known
> >>> mdsts' ports only (the no querier case). After v1 I've kept
> >>> the previous behaviour when it comes to unregistered traffic or when
> >>> a querier is present. All of this is of course only with snooping
> >>> enabled. So with this patch the following changes should occur:
> >>>  - No querier: forward known mdst traffic to its registered ports,
> >>>                no change about unknown mcast (flood)
> >>>  - Querier present: no change
> >>>
> >>> The reason to do this is simple - we want to respect the user's mdb
> >>> configuration in both cases, that is if the user adds static mdb entries
> >>> manually then we should use that information about forwarding traffic.
> >>>
> >>> What do you think ?
> >>>
> >>> * Notes
> >>> Traffic that is currently marked as mrouters_only:
> >>>  - IPv4: non-local mcast traffic, igmp reports
> >>>  - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports
> >>>
> >>> Simple use case:
> >>>  $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
> >>>  $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
> >>>  - without a querier currently traffic for 239.0.0.1 will still be flooded,
> >>>    with this change it will be forwarded only to swp1
> >>
> >> There is still the issue with unsolicited reports adding mdst
> >> entries here, too. Leading to unwanted packet loss and connectivity issues.
> > 
> > Or in other words, an unsolicited report will turn a previously
> > unregistered multicast group into a registered one. However in the
> > absence of a querier the knowledge about this newly registered multicast group
> > will be incomplete. And therefore still needs to be flooded to avoid packet
> > loss.
> > 
> 
> Right, this is expected. If the user has enabled igmp snooping and doesn't have
> a querier present then such behaviour is to be expected.

IGMP snooping is currently enabled by default. And IGMP/MLD
querier is disabled by default. I wouldn't want packet loss to be
the expected behaviour in a default setup.

This default setup currently works. However with this change it
will introduce packet loss, as you acknowledged (if I understood
you correctly?).

> What is surprising is
> the user explicitly enabling igmp snooping, adding an mdst and then still
> getting it flooded. :)

Hm, for me that does not seem surprising. I would not expect igmp
snooping to work without a querier on the link. Why don't you just
add/enable a querier in your setups then if you want to avoid
flooding?


> An alternative is to drop all unregistered traffic when a querier is not present.
> But that will surely break setups and at best should be a configurable option that
> is disabled by default.

Absolutely right. Always dropping with no querier is no option. That's why I'd say
you should always flood multicast packets if there is no querier.


> So in effect and to try and make everybody happy we can add an option to control
> this behaviour with keeping the current as default and adding the following options:
>  - no querier: flood all (default, current)

ACK

For the other options maybe I do not understand your scenario yet.
Wouldn't these two options result in eratic behaviour?

>  - no querier: flood unregistered, forward registered
>  - no querier: drop unregistered, forward registered

Let's call these two cases A) - flood unregistered, forward
registered and B) - drop unregistered, forward registered.


Let's say you have a bridge with two ports:
(1)<-[br]->(2). And no querier.

Behind (2) there is a listener for group M. M is not
registered by the bridge because either that listener joined
before the bridge came up or the entry was registered once but had
timed out. Or there was packet loss and the report did not arrive
at the bridge (for instance bc. listener is behind a wireless
connection).

For case B) we can immediately see that the listener at (2) will
not receive the traffic it signed up for. And this is a permanent
issue as the listener will not send any further reports.

Case A) is ok, the listener behind port (2) receives its traffic.


Now, a listener for M joins at (1). It sends an unsolicited
report. Group M becomes registered by the bridge. Both for
cases (A) and (B) this new listener at (1) will receive its
traffic. However, not only in case B) now, but in case A), too,
the listener at (2) will rceive no more traffic for M.


Now 260 seconds pass (multicast_membership_interval). The entry
for M times out and is deleted on the bridge. It becomes
unregistered.

Now for case (A) things would be ok again, both listeners at (1)
and (2) would receive traffic. For now - as long as no new listener
joins again.

For case (B), both the listener at port (1) and (2) will fail to
receive the traffic they signed up for.


---

I hope this illustrates a bit what I'm afraid of? If you have any
measures to prevent such behavior in your setup, I'd be curious to
know.

Regards, Linus
