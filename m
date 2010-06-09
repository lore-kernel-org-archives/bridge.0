In-Reply-To: <20100609082319.67bfb897@nehalam>
References: <OFAE56C1D1.3B4E5ED6-ONC125773D.005039AB-C125773D.00511E25@transmode.se>
	<20100609082319.67bfb897@nehalam>
Message-ID: <OF69A1E303.47B57A8D-ONC125773D.005A04BC-C125773D.005AA9CC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 9 Jun 2010 18:30:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] Bridge responds on its IP address even when br0 is
	down.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Stephen Hemminger <shemminger@linux-foundation.org> wrote on 2010/06/09 17:23:19:
>
> On Wed, 9 Jun 2010 16:46:01 +0200
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> >
> > System A:
> > eth0 has ip 192.168.1.16
> >
> > Then do in system A
> > brctl addbr br0
> > ifconfig br0 192.168.1.18 down
> >
> >
> > From system B I ping 192.168.1.18
> > and system A responds!
> >
> > Even though interface br0 is down I can still
> > access system A with 192.168.1.18, this feels
> > like a bridge bug?
> >
>
> No that is how Linux works. All addresses are property of the
> system not the interface.
>    http://en.wikipedia.org/wiki/Host_model

I see, I know the about the host model but I was surprised it applied
to interfaces that is down. Does it not make sense to exclude the
IP address when the I/F is down?

        Jocke

