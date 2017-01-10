Return-Path: <dave.taht@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=NH/tfrMOCB6pUY8CmQS8dFsusfW5klKMmWTf3H8Fq74=;
	b=IqyEQ0It8jgwnCsdvY7by63ixAnn691Pe2L7Vla5toeP3b6GI48aKCl1hy6BYywkr4
	jh6I3x6Ihoq5Art0yIDIJ/XcD90we8jkp3/79Yye0ukHsX0YxtOFN6X1cVnv/7jCFmfV
	oXcMMYDS7yiTzFE1f8SuMlh9akwLkRw8ZNEAg0HcxPHnZupR7G5UTayRtTh9jeLMfh0I
	uGm2na9152b58fsuWqe6RbSjweGC8RMF5LbGpcDGYn9nTKkHuxAD9Z6pL5sUZkFR0aJb
	ZsJJsh1ZioKsSCtOoQP7PVQAUZmRfLkpgSOnuHWXkEVef3GWe6BxpoYXpsdhfbzBCqCA
	EWOw==
MIME-Version: 1.0
In-Reply-To: <1484045763.1014.0.camel@sipsolutions.net>
References: <20170102193214.31723-1-linus.luessing@c0d3.blue>
	<1483706872.4089.8.camel@sipsolutions.net>
	<8836daaa-9638-4502-d079-fd428595f822@nbd.name>
	<1483710841.12677.1.camel@sipsolutions.net>
	<22fad045-57c6-7789-d19f-f47bd0faf441@fami-braun.de>
	<20170107145516.GE3134@otheros>
	<1483949336.17582.3.camel@sipsolutions.net>
	<6f5ec9f1-800a-2bc4-2f41-9d803343bb22@fami-braun.de>
	<20170109212345.GA5513@otheros>
	<20170109133032.221f8669@xeon-e3> <20170110041816.GJ5513@otheros>
	<1484045763.1014.0.camel@sipsolutions.net>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 10 Jan 2017 09:17:14 -0800
Message-ID: <CAA93jw6+P8um7TxDCYgJ=SJfFzpskboR7njgudMb3NR4JZ34BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH net-next] bridge: multicast to unicast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "M. Braun" <michael-dev@fami-braun.de>, "David S . Miller" <davem@davemloft.net>, Felix Fietkau <nbd@nbd.name>

In the case of wifi I have 3 issues with this line of thought.

multicast in wifi has generally supposed to be unreliable. This makes
it reliable. reliability comes at a cost -

multicast is typically set at a fixed low rate today. unicast is
retried at different rates until it succeeds - for every station
listening. If one station is already at the lowest rate, the total
cost of the transmit increases, rather than decreases.

unicast gets block acks until it succeeds. Again, more delay.

I think there is something like 31 soft-retries in the ath9k driver....

what happens to diffserv markings here? for unicast CS1 goes into the
BE queue, CS6, the VO queue. Do we go from one flat queue for all of
multicast to punching it through one of the hardware queues based on
the diffserv mark now with this patch?

I would like it if there was a way to preserve the unreliability
(which multiple mesh protocols depend on), send stuff with QoSNoack,
etc - or dynamically choose (based on the rates of the stations)
between conventional multicast and unicast.

Or - better, IMHO, keep sending multicast as is but pick the best of
the rates available to all the listening stations for it.

Has anyone actually looked at the effects of this with, say, 5-10
stations at middlin to poor quality (longer distance)? using something
to measure the real effect of the multicast conversion? (uftp, mdns?)
