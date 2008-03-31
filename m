Message-ID: <fed120860803311309x68edff7cie8e5290133f9a011@mail.gmail.com>
Date: Tue, 1 Apr 2008 01:39:13 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <-2617425004832712825@unknownmsgid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>
	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
	<1206949458.7589.447.camel@gentoo-jocke.transmode.se>
	<fed120860803310959g7d70a5e6s6f40c4275d14592a@mail.gmail.com>
	<-2617425004832712825@unknownmsgid>
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
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Cc: Bridge@lists.linux-foundation.org

>
>  I don't like the bridge-stp <bridge> start/stop interface. Why
>  would bridge-stp know what bridge to run RTSP on? A more natural
>  way, IMHO, would to extend brctl with a "rstp on" method. Why
>  is there one rstpctl tool and one brctl tool?

I wrote rstpctl to just control the rstp daemon. Should integrate it
with brctl, making it so that brctl checks whether kernel STP or RSTP
is being used and sets either kernel STP config or sends the config to
rstpd as appropriate. I haven't gotten around to that.

I don't like bridge-stp scheme too much either, especially after
realizing the RTNL lock limitation, but it is just enough to get
things working if we don't try to start rstpd from within it (though
the sample does that.) Given the amount of trouble bridge-stp seems to
cause, I should probably work on a different kernel interface for
indicating userspace stp.
