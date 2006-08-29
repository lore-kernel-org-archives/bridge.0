Message-ID: <82b0add70608291601h20af4d9eic66bed1ba4c0d856@mail.gmail.com>
Date: Tue, 29 Aug 2006 19:01:37 -0400
From: "Joubert Berger" <joubertb@gmail.com>
Sender: joubert@berger-family.org
In-Reply-To: <20060827211912.57f45ee8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <82b0add70608270705t7dc2bb67h108317b34cdc12f3@mail.gmail.com>
	<20060827211912.57f45ee8@localhost.localdomain>
Subject: Re: [Bridge] SMP vs UNP performance
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Thanks Stephen,

I will go back and see what happens happens in a bi-directional test.

And yes, we plan on using the firewall capabilities, so I will spend
some time looking at what happens when I am running with all the
firewall rules loaded.

--joubert

On 8/28/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Sun, 27 Aug 2006 10:05:01 -0400
> "Joubert Berger" <joubertb@gmail.com> wrote:
>
> > I was running a frame loss test the other day against an rhel4 smp
> > kernel and a non-smp kernel.  I noticed I was getting better numbers
> > when I ran the non-smp kernel.  I was surprised by that.  Anyone have
> > any insight into this?  I am running this with e1000 dirvers.
>
> Turning NAPI on/off might change the numbers slightly.
>
> > I also ran a test where I ran the smp kernel with hyper threading
> > turned on and off.  There, the frame loss numbers were worse when
> > hyper threading was turned off.  I would not have thought that having
> > hyperthreading turned off would make such a big difference.
> >
> > Just trying to make sense of these numbers :-)
> >
> > --joubert
>
> Forwarding packets is inherently single threaded, the additional CPU's
> can't really make it any faster. They can only cause additional cache
> misses and locking overhead. The additional CPU's might help if you
> performed a bidirectional or multiple interface test. Forwarding packets
> shouldn't normally CPU bound, it is limited by the bus and interrupt rate.
> If you are doing lots of firewalling that can change.
>
