Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 16 Feb 2019 21:37:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550349441; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=UxWsVdh1RQTLB/rfMkJdIEIqlQdnMEJqYNcC+p8+wDY=;
	b=LIKgJa8Y/sRCeuWBebpJTgkgO+o41JryaxIot1s76oZSK1z6fDNsrTngwKrjX5F9664X1h
	UdrXdeGhLIWpIRU7znXZd3LwaCnZ+Aj2YqwbVovS7oWaxsSPuHFXPb8ynJhihJ6fhWQ55v
	NqkaiMVdC8KehrQPrQVZVhSYA80pGMFSlkh+1O8K3yThPG60RkXQtqya096wJGt+lDaxy8
	4TsCau/ti8DFHrWp1F+cJO/M1Fx5ERt176wcKHDz8aw8ZZNAcEpGXCvDb46U1MoaTdmqH+
	Q9Pe5AB3JR604XRSp395Uf0iB5A/i4xYJittTB5ZndNFz/xEm4VebTp/hyOzWg==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190216203719.GC25057@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190215171332.GA1472@otheros>
	<479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
	<20190216184353.GA10888@splinter>
	<0FE44F84-AD68-4FC0-8FEB-D033CF6159D2@cumulusnetworks.com>
	<E8A29F94-091F-44CA-9E33-481BF21C359D@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E8A29F94-091F-44CA-9E33-481BF21C359D@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, Ido Schimmel <idosch@idosch.org>, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Sat, Feb 16, 2019 at 09:27:26PM +0200, nikolay@cumulusnetworks.com wrote:
> >>The no querier condition is not currently reflected via switchdev, so
> >>the behavior you're proposing in your patch is what actually happens
> >in
> >>the data plane.
> >>
> >>We already hit the problem Linus mentioned in commit b00589af3b04
> >>("bridge: disable snooping if there is no querier"). Namely, IPv6 ND
> >>broke because a port joined before the bridge was created.
> >>
> >>I introduced a workaround in commit 9d45deb04c59 ("mlxsw: spectrum:
> >>Treat IPv6 unregistered multicast as broadcast"). I'm interested to
> >>know
> >>what other vendors are doing. Can you elaborate?
> >>
> >
> >Exactly like your fix. :) Flood it, this patch unfortunately breaks it 
> >because of mrouters flag, but we can retain the behaviour
> >by forwarding only known mdsts to their ports and flooding
> >unregistered mcast when there is no querier. I think that is 
> >what others do by default too, actually I think they flood with querier
> >as well. Maybe unknown mcast flooding should be controlled by a flag
> >when a querier is present
> >because we've had this behaviour for a long time, personally I'd have
> >it on
> >by default. 
> 
> Ugh, mispoke please read the above statement to be only about no querier. 
> I meant flooding v6 link-local always. 

And for routable IPv6 multicast, how would you detect multicast
listeners on the local link in absence of a querier?
