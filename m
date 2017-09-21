Return-Path: <vincent@bernat.im>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bernat.im; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=postfix; bh=gKK/tv+Cv+zIkxg4hJoYnE4q3lE=; b=oMU
	hpZTqK6dpT0KCMhMeQE6xAumNZu/ruLF6QkcpGKs7hN8CH4ebMbPFsmOOHyLx0mQ
	t9sff8SzGgW9f3a+knca3cTLDJMP0yKvoa/RDXTUlt3pTvL0B15EcuV60S+aRkGx
	43bf7S4ShC12hMigRJ0E+2S81kG7BFjEHHi1eHtQ=
From: Vincent Bernat <vincent@bernat.im>
References: <m3zi9vbrfp.fsf@luffy.cx>
	<20170916141833.28344-1-vincent@bernat.im>
	<20170920.140956.781667692297467325.davem@davemloft.net>
	<16e5566a-909d-ba83-7637-1fb6c93126bc@gmail.com>
	<20170920162140.369bb198@xeon-e3>
In-Reply-To: <20170920162140.369bb198@xeon-e3> (Stephen Hemminger's message of
	"Wed, 20 Sep 2017 16:21:40 -0700")
Message-ID: <87h8vw5pwg.fsf@luffy.cx>
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
Date: Thu, 21 Sep 2017 10:04:24 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, David Ahern <dsahern@gmail.com>

 =E2=9D=A6 20 septembre 2017 16:21 -0700, Stephen Hemminger <stephen@networ=
kplumber.org>=C2=A0:

> The one concern is that ports added or removed through ioctl should
> cause same events as doing the same thing via netlink. Some users use
> brctl (ioctl) and others use newer bridge (netlink) API.

I'll make a third iteration to have the same notifications when using
ioctl() with details in the commit message.
--=20
When in doubt, tell the truth.
		-- Mark Twain
