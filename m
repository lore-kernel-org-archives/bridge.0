Date: Thu, 16 Sep 2004 14:06:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Setting the interfaces in promiscuous mode
Message-Id: <20040916140615.3aee9580@dell_ss3.pdx.osdl.net>
In-Reply-To: <5f3f2c61040916134370cc8897@mail.gmail.com>
References: <5f3f2c610409160928252d34b1@mail.gmail.com>
	<20040916110955.6347a4e9@dell_ss3.pdx.osdl.net>
	<5f3f2c61040916134370cc8897@mail.gmail.com>
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
To: Lionel Litty <llitty@gmail.com>
Cc: bridge@lists.osdl.org

On Thu, 16 Sep 2004 16:43:40 -0400
Lionel Litty <llitty@gmail.com> wrote:

> > promiscuous mode is tracked in the kernel with a counter, the kernel
> > won't change the actual hardware until the counter goes to zero. This is
> > why running something like tcpdump which changes interface to promiscuous mode
> > will have no effect on the bridge.  How did you
> > force the interface out of non-promiscious mode?  You may not changed anything.
> > 
> 
> I simply did "ifconfig eth0 -promisc" and "ifconfig tap0 -promisc".
> "ifconfig" then no longer indicates that the interfaces are in
> promiscuous mode. Are you saying that the output of ifconfig is not
> reliable and that the interfaces may in fact still be in promiscuous
> mode? This would make sense, but then how come the performance seems
> to be affected by the change?

Because when the stack thinks it is in promiscious mode then all the packets
have to be processed.


> > Also promiscuous on tap means nothing really since there is no hardware
> > filtering.
> 
> OK. I thought there might have been some software simulation of the
> promiscuous mode.
> 
> Thanks, Lionel.
