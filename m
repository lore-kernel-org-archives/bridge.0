Date: Wed, 1 Oct 2003 21:24:10 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
Subject: Re: [Bridge] bridge breaks loopback on 2.4.22
Message-ID: <20031001192410.GA736@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
	<20030929090804.038abf2b.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929090804.038abf2b.shemminger@osdl.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, bridge@lists.osdl.org


> What kind of hardware do you have? what are the ethernet's you are trying
> to bridge?  

I think this doesn't matter, but right now on the machines I'm seing this
I'm bridging a 100Mb segment (8139too driver) with a 10Mb segment (ne.c
driver), the 10Mb segment carries no trafic at all and is only there for
some old machines (turned off all the time) and in case something happens to
the 100Mb switch.

However, I have some other cards around, I could test with them if you think
that could matter.

> There haven't been a many changes at all to the bridging code, and you could
> try building the 2.4.21 bridge code into a 2.4.22 kernel.

The changes weren't a lot, but something broke, I could not test to build
2.4.21 bridge into 2.4.22 till today, I have just done it and 2.4.22 works
ok like that. What I did is replace net/bridge from 2.4.22 with the one from
2.4.21, works like a charm.

> When cpu goes 100% could you get a backtrace (with sysrq-t)? 

This is ok, I mean, cpu must go 100%, there is nothing wrong with that, if
I'm doing a netcat from /dev/zero into the loopback and out to another
netcat and then to /dev/null a full cpu load is expected, what was not
expected was the 0% cpu load I get when the loopback looses packages and the
netcats start to wait for the kernel to deliver the packages.

I believe anybody can test this, just compile a 2.4.22 with the bridge code
into a box with two network cards, setup a bridge on the two cards and
enable stp, then plug the two cards into the same switch and that should do
it.

Well, I hope this clarifies the thing a bit, if you need any other tests
just ask for them.
-- 
Manty/BestiaTester -> http://manty.net
