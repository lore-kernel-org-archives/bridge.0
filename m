Return-Path: <vincent@bernat.im>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bernat.im; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=postfix; bh=1MMynOeKAlkFtU4tn12pxDqWyOk=; b=oRT
	iuhmxiTvtPsZqN/sVsCW9uLIMIayry3p7vMgDB2vbtr3AIxr0KQ1zLJZK1wf4Zmn
	QjNrfle0qheFIHybhJJaGzmT8ZtyDZlypS9pMjWTKq5pbsQ+SJJl6GDX9mF60UqY
	hTAGTC+/kw677YiBPDpk8j95AqIZ/u8BFbYPuk+k=
From: Vincent Bernat <vincent@bernat.im>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
In-Reply-To: <16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com> (David Ahern's
	message of "Wed, 20 Sep 2017 15:57:16 -0600")
Message-ID: <87bmm56mu2.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v2] bridge: also trigger RTM_NEWLINK
	when interface is released from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 20 Sep 2017 22:13:00 -0000
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

 =E2=9D=A6 20 septembre 2017 15:57 -0600, David Ahern <dsahern@gmail.com>=
=C2=A0:

> The DELLINK is for AF_BRIDGE family (ifi_family). Adding family to
> print_linkinfo and running the monitor I get:
>
>
> [LINK]family 0: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc
> noqueue master br0 state UNKNOWN group default
>     link/ether d6:c3:73:86:3c:73 brd ff:ff:ff:ff:ff:ff
>
> [LINK]family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500
> master br0 state UNKNOWN
>     link/ether d6:c3:73:86:3c:73
>
> [LINK]Deleted family 7: 35: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu
> 1500 master br0 state UNKNOWN
>     link/ether d6:c3:73:86:3c:73

I didn't know about the family. We can drop the patch.
--=20
One of the most striking differences between a cat and a lie is that a cat =
has
only nine lives.
		-- Mark Twain, "Pudd'nhead Wilson's Calendar"
