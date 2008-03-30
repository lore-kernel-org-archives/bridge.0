From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <1206879595.7589.403.camel@gentoo-jocke.transmode.se>
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<1206873828.7589.394.camel@gentoo-jocke.transmode.se>
	<fed120860803300435j6c0b11f7g5956265392513876@mail.gmail.com>
	<1206878590.7589.399.camel@gentoo-jocke.transmode.se>
	<1206879595.7589.403.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Mar 2008 17:06:45 +0200
Message-Id: <1206889605.7589.406.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Subject: Re: [Bridge] RSTP
	in	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary	problems
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Srinivas M.A." <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org


On Sun, 2008-03-30 at 14:19 +0200, Joakim Tjernlund wrote:
> On Sun, 2008-03-30 at 14:03 +0200, Joakim Tjernlund wrote:
> > On Sun, 2008-03-30 at 17:05 +0530, Srinivas M.A. wrote:
> > > >  > My updates have not yet made it to Stephen Hemminger's git repo, but I
> > > >  > am attaching a
> > > >
> > > >  Any time frame when this will hit Hemminger's repo?
> > > 
> > > I sent the patches to him some time back, but perhaps he hasn't had
> > > time to look over them. It is a large set of changes anyway.
> > > 
> > > >
> > > >  :) lets see, the lab here tends to create some really funny loops, often
> > > >  by mistake.
> > > 
> > > Once the rstp has started fine, things should generally be okay.
> > > Please try it out and let me know.
> > > 
> > > Srinivas
> > 
> > With my cross gcc, 3.4.6 I get:
> > rstp.c: In function `txConfig':
> > rstp.c:1185: warning: implicit declaration of function
> > `__builtin_offsetof'
> > rstp.c:1185: error: syntax error before "RawBPDU"
> > rstp.c: In function `txRstp':
> > rstp.c:1221: error: syntax error before "RawBPDU"
> > rstp.c: In function `txTcn':
> > rstp.c:1234: error: syntax error before "RawBPDU"
> > 
> > Seems like __builtin_offsetof isn't defined in gcc 3.4.6,
> > can do something about that?
> 
> ehh, that was easy to fix.
> 
> I do this
> ./rstpd
> brctl addbr br0
> brctl addif br0 eth0
> brctl stp br0 on
> ifconfig eth0 0.0.0.0 up
> ifconfig br0  0.0.0.0 up
> ./rstpctl showbridge
> 
> br0
>  enabled                  no
>  bridge id              8000.002234567778
>  designated root        0000.000000000000
>  root port                 0                    path cost                  0
>  max age                   0                    bridge max age            20
>  hello time                0                    bridge hello time          2
>  forward delay             0                    bridge forward delay      15
>  tx hold count             6
>  protocol version          2
>  time since topology change      354
>  toplogy change count              0
>  topology change                  no
> 
> It does not get enabled and 
> #> cat /sys/class/net/br0/bridge/stp_state
> 1

Have this code been tested on a big endian CPU?

 Jocke
