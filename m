Return-Path: <nbd@nbd.name>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; 
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
	bh=xhUYK1WCu5bMTp68mku7EPs8+PDpappjytxwOYm2Qa0=; 
	b=JOmLuPWD5mOLkZBrvtenKV6t1aJGe7QbeHfo2RBt8Ex0JTL7pUqYChOOg06zmDmv/Ey0Egcu0k0z70KZyoJjE6PBk1kaxLhSTKCIRmIbaGgYBd9kLb8JboC9EpTbmBkZRwohYDFYxQ8+zx3adu4IfvoLSnAGdneoD+7f4z2j5PQ=;
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<8836daaa-9638-4502-d079-fd428595f822@nbd.name>
	<1483710841.12677.1.camel@sipsolutions.net>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <21c1c361-eef0-aa53-ecd5-b5154c51462d@nbd.name>
Date: Fri, 6 Jan 2017 14:54:55 +0100
MIME-Version: 1.0
In-Reply-To: <1483710841.12677.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Michael Braun <michael-dev@fami-braun.de>

On 2017-01-06 14:54, Johannes Berg wrote:
> 
>> The bridge layer can use IGMP snooping to ensure that the multicast
>> stream is only transmitted to clients that are actually a member of
>> the group. Can the mac80211 feature do the same?
> 
> No, it'll convert the packet for all clients that are behind that
> netdev. But that's an argument for dropping the mac80211 feature, which
> hasn't been merged upstream yet, no?
Right.

- Felix

