Message-ID: <fed120860804010257h3aa9ab3etafa3d5c2e3db30dd@mail.gmail.com>
Date: Tue, 1 Apr 2008 15:27:34 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <1207033045.7589.485.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8571495929364495836@unknownmsgid>
	<7423344835968003573@unknownmsgid>
	<fed120860803301213r6f1e1aadwf26d269a4224b768@mail.gmail.com>
	<1206911933.7589.426.camel@gentoo-jocke.transmode.se>
	<fed120860803310025p33efd12ds6cbba5d0f978caf5@mail.gmail.com>
	<1206949458.7589.447.camel@gentoo-jocke.transmode.se>
	<fed120860803310959g7d70a5e6s6f40c4275d14592a@mail.gmail.com>
	<-2617425004832712825@unknownmsgid>
	<fed120860803311309x68edff7cie8e5290133f9a011@mail.gmail.com>
	<1207033045.7589.485.camel@gentoo-jocke.transmode.se>
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
To: joakim.tjernlund@transmode.se
Cc: Bridge@lists.linux-foundation.org

>
>  Curious, why is RSTP in user space? Lots of protocols are in the kernel,
>  why not RSTP too?

For one thing it is easier from a development standpoint. The kernel
just needs to provide hooks for allowing userspace programs to send
and receive BPDUs and to change port states. The STP logic can then be
moved to userspace and it is easier to develop and debug.

>
>  Are any known issues with the in kernel STP?
>
>  I haven't read 802.1D-2004 but I know RSTP is in there, does RSTP
>  replace the old STP protocol? If not, is there any reason to prefer STP
>  before RSTP in some cases?

In 802.1D-2004, RSTP replaces the old STP. RSTP provides additional
mechanisms to give faster convergence when the network involves only
point-to-point links. It is backward compatible with STP, i.e., it
will interoperate correctly when there are other STP bridges, though
you lose the fast convergence then. So, in general, there is no reason
to prefer STP to RSTP. Currently, the main reason would be that the
STP implementation has been around much longer and that this RSTP
implementation is new.
