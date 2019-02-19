Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Feb 2019 10:21:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1550568087; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=4Zi+FUXRDVZR22UMs1vreXsU4Q1SNFLfFgj4BQXsYDE=;
	b=PnuXhwoXiT4tmITPF7VMmr736qb6uUZcj4s7b1Qxx5UZvLHiKN/7xlGkirZ4rxISUUqJQD
	eOKmZK2nampBsL3lsg7mU1YyQik7KoehU6LD116m4jF+cz7Yn6tf6JqOUKe4faX6guZKM0
	jFnhVNjyJsjbLLYFByB0gZTnqQnWOgqFUme6jlf+b2uFUl/8X1fR3s3lKm3UnO9csPqBor
	cP5laA/c0+kTfG7qPGzmRaGJ6KtXnFrHPq5O1TFJAUtvElwLsiuNIoQ7NpO2GEOLzvLr6x
	jbJy0Ganp9NPRvGc4+6ETxjgMnJE8dsr5ehq4x9Oq9qxxQFKrCJY4dwBDGQuug==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190219092125.GE10191@otheros>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190218122107.10097-1-nikolay@cumulusnetworks.com>
	<20190219085716.GD10191@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190219085716.GD10191@otheros>
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

On Tue, Feb 19, 2019 at 09:57:16AM +0100, Linus Lüssing wrote:
> On Mon, Feb 18, 2019 at 02:21:07PM +0200, Nikolay Aleksandrov wrote:
> > This is v2 of the RFC patch which aims to forward packets to known
> > mdsts' ports only (the no querier case). After v1 I've kept
> > the previous behaviour when it comes to unregistered traffic or when
> > a querier is present. All of this is of course only with snooping
> > enabled. So with this patch the following changes should occur:
> >  - No querier: forward known mdst traffic to its registered ports,
> >                no change about unknown mcast (flood)
> >  - Querier present: no change
> > 
> > The reason to do this is simple - we want to respect the user's mdb
> > configuration in both cases, that is if the user adds static mdb entries
> > manually then we should use that information about forwarding traffic.
> > 
> > What do you think ?
> > 
> > * Notes
> > Traffic that is currently marked as mrouters_only:
> >  - IPv4: non-local mcast traffic, igmp reports
> >  - IPv6: non-all-nodes-dst mcast traffic, mldv1 reports
> > 
> > Simple use case:
> >  $ echo 1 > /sys/class/net/bridge/bridge/multicast_snooping
> >  $ bridge mdb add dev bridge port swp1 grp 239.0.0.1
> >  - without a querier currently traffic for 239.0.0.1 will still be flooded,
> >    with this change it will be forwarded only to swp1
> 
> There is still the issue with unsolicited reports adding mdst
> entries here, too. Leading to unwanted packet loss and connectivity issues.

Or in other words, an unsolicited report will turn a previously
unregistered multicast group into a registered one. However in the
absence of a querier the knowledge about this newly registered multicast group
will be incomplete. And therefore still needs to be flooded to avoid packet
loss.
