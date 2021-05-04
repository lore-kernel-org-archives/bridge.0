Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=uliylMPA3scQqPaauQbVrIOixvG300bg8trmMivqpf0=;
 b=KFS/nGi1eolFwtYT6NELDRAushYNsu4vIKv4FZrf5JKt3IoYJpFAKmQ5N2iEM8luNG
 ceizYfDegDgvfioz0FPWRlwC+BT5vAMxYunFnXn2LhPKuPlM1tYcMOeR0dZjdQe8Z15u
 gy7rBvCZNqyYja5VimuxEyBvGWat3pHV3Jf1IRCYOmiAE9bRmKijSHtakap5UPWv2vau
 38Wy4IkGaSyt1i4MVG4A0ZWLai8LpQAujiWkwux58NTsnUu8hy3zNs0DetSbMUXm1sLR
 LTVd6+KiS3JofDeIFk1c+wTrLdb8XNBPo0W5ZwqHnmXSXmrD5LU91i23TYmoWNw1HulN
 lp6w==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <YJGvkJBKPj2WloXf@lunn.ch>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-7-tobias@waldekranz.com>
 <20210427101747.n3y6w6o7thl5cz3r@skbuf> <878s4uo8xc.fsf@waldekranz.com>
 <20210504152106.oppawchuruapg4sb@skbuf> <874kfintzh.fsf@waldekranz.com>
 <YJGvkJBKPj2WloXf@lunn.ch>
Date: Tue, 04 May 2021 23:24:52 +0200
Message-ID: <871ramnqe3.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 6/9] net: dsa: Forward offloading
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Tue, May 04, 2021 at 22:33, Andrew Lunn <andrew@lunn.ch> wrote:
>> There is really no need to recompute the static parts of the tags on
>> each skb. It would mean moving some knowledge of the tagging format to
>> the driver. But that boundary is pretty artificial for
>> mv88e6xxx. tag_dsa has no use outside of mv88e6xxx, and mv88e6xxx does
>> not work with any other tagger. I suppose you could even move the whole
>> tagger to drivers/net/dsa/mv88e6xxx/?
>> 
>> What do you think?
>> 
>> Andrew?
>
> We have resisted this before.
>
> What information do you actually need to share between the tagger and
> the driver?

So far:

- Trunk/LAG ID to netdev mappings (this is stored on the dst now, but I
  think I have seen the light and agree with Vladimir that it really has
  no business there).

- DSA dev/port to bridge netdev mappings for the forwarding offloading
  in this RFC (or preferably the actual tag templates to use on egress
  since that would probably give you better performance)

In the future:

- Completions for in-flight remote management operations.

- FlowID to TC rule mappings (from the "Switch Egress header" when we
  enable that)

- In-band signaling between firmware running on the IMP and the driver
  for things like MRP and CFM offloading.

> Both tag_lan9303.c and tag_ocelot_8021q.c do reference
> their switch driver data structures, so some sharing is allowed. But
> please try to keep the surface areas down.

If you have a surface area keep it small, yes, agreed. I guess my
question is more why we should have any surface area at all? What do we
gain by the tagger/driver separation in the case of mv88e6xxx?

>        Andrew
