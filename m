Date: Mon, 29 Sep 2003 09:08:04 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge breaks loopback on 2.4.22
Message-Id: <20030929090804.038abf2b.shemminger@osdl.org>
In-Reply-To: <20030927202200.GA612@man.beta.es>
References: <20030927202200.GA612@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: bridge@lists.osdl.org

On Sat, 27 Sep 2003 22:22:01 +0200
Santiago Garcia Mantinan <manty@manty.net> wrote:

> Hi!
> 
> Since the change to 2.4.22 I've been experimenting problems here, after
> many tests I have seen what I think is the problem that is causing this.
> 
> The problem I'm seing is the loopback starts loosing packages, I don't know
> if this could also happen on other interfaces. I'm testing this by starting
> a:
> 	tcpdump -n -i lo port
> then a:
> 	nc -n -l port >/dev/null
> and a:
> 	nc localhost port </dev/zero
> 
> If everything is fine my cpu goes to 100% and I see the packages all the way
> in my tcpdump screen, great. But there are sometimes when this doesn't go
> smooth and the tcpdump starts to show only one or two packages each N
> seconds, till it ends up showing the resend of the last package which is
> never acknowledged, you can even see that the timings of this packages that
> are being repeated match those of tcp backoff, my cpu charge is then really
> really low, nc disconnects after a while, ...
> 
> When does this happen?
> 
> It took me a while to find this out, but it happens when you have a bridge
> interface and one of the ports of the bridge is told to drop packages, like
> when they detect a loop in the net and an interface is set to a blocking
> state.
> 
> Of course that the loopback is not a part of any bridge in any of my setups,
> and I've seen this in a couple of machines, one SMP and the other one single
> micro, 2.4.21 worked ok, at least I could not reproduce this on that one. If
> the interfaces have been in a forwarding state all the time since the bridge
> was setup, without being in a blocking state, then this problem does not
> seem to happen.
> 
> I believe that the changes the bridge went through from 2.4.21 to 2.4.22 are
> to blame on this one, but this is just a guess.
> 
> Hope we can find a fix for this so that it is integrated in 2.4.23 kernel,
> I'll be happy to make any tests you want to track this farther down.


What kind of hardware do you have? what are the ethernet's you are trying
to bridge?  

There haven't been a many changes at all to the bridging code, and you could
try building the 2.4.21 bridge code into a 2.4.22 kernel.

When cpu goes 100% could you get a backtrace (with sysrq-t)? 
