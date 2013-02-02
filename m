Return-Path: <mirqus@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type:content-transfer-encoding;
	bh=8tfEOSsXWKqjOLASkXlBG5byFKQ3AsxfrzpOw7c5/sA=;
	b=KwOwQlcMz82yYrf1GNBvpDlclO8jXtwnJH6UFrqKsyhdOZIC4rCn+Z4sw60x8Oh6Y+
	QjEiYmYYM3/j2CeAoVhZT/zsc3wsFsMxqzIwKVVF1WPvWEZOjVviUnxBWoErXwbyzfyH
	LxKM0pds2SNrjtXvUT/MKAPj9YBAhMzxUN3sarPPPfyWN+UGCgkvypiKEBeMuPkq9pQ1
	GP1VneuExyRvXz0zQWCQlMcQONaKCTGUEW8zI84WfB9amH9ETxHMIQ+PUYwIRWcixW2r
	W1SYOI69e5G6GKGRuwblYnKFvGAkkufMjnoek+s7dIZKFNKEV8Az7bFQtCYeMvx8fZ8I
	wBBQ==
MIME-Version: 1.0
In-Reply-To: <CAHXqBFKXEHjghyDe4UQs4inH55UzWcsz+eWAXR4qFiM7+4yVxw@mail.gmail.com>
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-6-git-send-email-vyasevic@redhat.com>
	<CAHXqBFKXEHjghyDe4UQs4inH55UzWcsz+eWAXR4qFiM7+4yVxw@mail.gmail.com>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 2 Feb 2013 02:15:54 +0100
Message-ID: <CAHXqBFJ3FutyBGNAXPueWLqJncvzNqd69nTJc0nLgUqzFMTWjw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v9 net-next 05/12] bridge: Add the ability to
	configure pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

2013/2/2 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
> 2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
>> A user may designate a certain vlan as PVID.  This means that
>> any ingress frame that does not contain a vlan tag is assigned to
>> this vlan and any forwarding decisions are made with this vlan in mind.
> [...]
>>  struct net_port_vlans {
>>         u16                             port_idx;
>> +       u16                             pvid;
>
> I'm confused about the implementation. I would expect pvid field in
> net_bridge_port and adding a tag if it isn't there on ingress path.
> The rest would be just like without PVIDs. But here you pvid field to
> net_port_vlans, and don't do anything with it in receive nor transmit
> path. Does it work? What am I missing?

Found the answer in next patch (you should merge #5 and #6). Still,
the implementation looks overly complicated. If you force the packet
to canonical form on ingress (keeping outer tag in skb->vlan_tci, and
setting skb->vlan_tci =3D pvid if there is no tag) the code should get
simpler.

Best Regards,
Micha=B3 Miros=B3aw
