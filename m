Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 13 Dec 2018 17:10:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1544717430; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=NChedHAY7RfbZMvpl5MyAe6ezYMgKos1We3sKt1vX90=;
	b=mERyG1SHiPf80rUL24BrtB/lXuJwpiNTHgzAdQSuvZr+sGuUvbGnQ1h4LRrDJYC0Mh+SAe
	hpTALnEWvR2mAT+8O6Ws7HxwE2hsnDcELAmblr9J4ScYBjz8HaD4Kk1a8NHMmsnfzdYj91
	G8IhqRK7XQuybVfjikCohUk+J6BQuzzmp2Mb23Tm1MchAfz9zXj2/GdG8zZGVTheDW9RpY
	cDYW+AA+FMhtC5aRWZ6S3PfkmCMCEdeo+2NhnNKGfD0cvWa0+k5bQHw5CcrlRs23g/HBgL
	tz+F45EENwK/t6SOqrjyTNC7AisggfkJifXSCY/Sl2j4KLUebpdnD49j0EAQmA==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181213161027.GC1713@otheros>
References: <90c5f2fe-1743-6b17-2e44-eba58cdbbb35@cumulusnetworks.com>
	<20181027090747.22104-1-nikolay@cumulusnetworks.com>
	<20181029013316.GK24677@leo.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029013316.GK24677@leo.usersys.redhat.com>
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yinxu@redhat.com, davem@davemloft.net

Even though RFC4541 recommends this, I'm not quite sure whether
this works... even for IGMP.

I think this would lead to multicast packet loss in a scenario
like this:

----------

     [Switch A] -------------- [Switch B]
        /                          /
       /                          /
      /                          /
 (Host A)                   (Host B)


- Snooping Switches: Switch A + Switch B
- Selected Querier: Switch A, with 0.0.0.0 query source
- Multicast Listener: Host A
- Multicast Data Sender: Host B

1) Host A sends IGMP report to Switch A
2) Switch A refrains from forwarding it to Switch B
   (reports are only forwarded to multicast routers according to
    RFC4541)
   => Switch B does not learn about listeners on Host A

Now, with this patch and recommendation in RFC4541 to not add queries
with a 0.0.0.0 source address to the multicast router port list:

3) Host B sends multicast data to Switch B
   => Switch B does not forward it to Switch A as it neither
      detected a multicast listener nor multicast router on
      the according port.
   => Host A does not receive the multicast data it signed up for

(Or with colors:
https://metameute.de/~tux/linux/bridge/query-zero-source-no-mcrouter-port.png)

----------

Alternatively we would need to ignore 0.0.0.0 for the querier
election and "querier present" detection. And by that disable
multicast snooping if there are no queries from a non-zero source
address.

But I'm a little hesitant whether ignoring is a reliable way as
IGMPv3 (RFC3376) and IGMPv2 (RFC2236) make no such restrictions
regarding the query source address.

With no such restrictions according to RFC3376/RFC2236 a 0.0.0.0
would always win the querier election. Meaning any potential
querier with a non-zero source address would remain silent.
Meaning we would always disable multicast snooping then?


Adding queriers with a 0.0.0.0 source address to the multicast
router list, too, seems like a less harmful way then disabling multicast
snooping completely?

----------

However, one of the two options seems to be necessary. Either
reverting the patch for the IGMP part, too. Or Ignoring 0.0.0.0
sources for querier eletcion and presence detection.

The current state seems broken to me unless I'm missing something.
