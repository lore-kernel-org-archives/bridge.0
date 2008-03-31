From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
References: <8571495929364495836@unknownmsgid>	
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>	
	<7423344835968003573@unknownmsgid>	
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>	
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>	
	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>	
	<1206964119.7589.456.camel@gentoo-jocke.transmode.se>
	<fed120860803311010o54a44f16hf86225c81e5ae837@mail.gmail.com>
In-Reply-To: <fed120860803311010o54a44f16hf86225c81e5ae837@mail.gmail.com>
Date: Mon, 31 Mar 2008 20:05:19 +0200
Message-ID: <039901c89359$c8215820$58640860$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: sv
Subject: Re: [Bridge] RSTP in
	http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;
	a=summary problems
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "'Srinivas M.A.'" <srinivas.aji@gmail.com>
Cc: Bridge@lists.linux-foundation.org

> -----Original Message-----
> From: Srinivas M.A. [mailto:srinivas.aji@gmail.com]
> Sent: den 31 mars 2008 19:10
> To: joakim.tjernlund@transmode.se
> Cc: Bridge@lists.linux-foundation.org
> Subject: Re: [Bridge] RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git; a=summary
> problems
> 
> >  Here is a quick hack to make bridge-stp work at all.
> >  The biggest problem is that rstpd cant start if stdio isn't present.
> >  rstpd needs to properly daemonize.
> 
> Your change should help (for Debian?), but it maybe best to start
> rstpd from the network init scripts, rather than from bridge-stp.
> Also, we should not stop the daemon from bridge-stp if there could be
> multiple bridges.

Yes, but I was surprised rstpd just hangs when trying to start it this way.
Could it be the RTNL lock causing this? Maybe rstpd should daemonize earlier
to prevent this from happening?

   Jocke


