From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
References: <8571495929364495836@unknownmsgid>
	<fed120860803300232v678efc1dr862e5d3ba5fbf16d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Mar 2008 12:43:48 +0200
Message-Id: <1206873828.7589.394.camel@gentoo-jocke.transmode.se>
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

Hi Srinivas

On Sun, 2008-03-30 at 15:02 +0530, Srinivas M.A. wrote:
> Hi Joakim,
> 
>   Would you be interested in testing out a newer implementation that
> we now have? This is
> much closer to the 802.1D-2004 standard and has passed the UNH RSTP
> protocol tests.

Sure am interested, thanks for the offer.

> My updates have not yet made it to Stephen Hemminger's git repo, but I
> am attaching a

Any time frame when this will hit Hemminger's repo?

> a patch set on top of that, as well as a tarball of my git-repo with
> the additional commits.

OK, will use your repo to begin with.

> 
> I don't know how the mailing list handles attachments, let me see anyway.

Got both of them.

> 
> I am interested in seeing this used more, and I will be happy to
> assist with any issues. Please
> let me know how things go.
> 
> This is fairly new code, but it has gone through some testing and use.
> One limitation
> is that there is no mechanism to automatically restart or fall back to
> kernel STP if the RSTP
> daemon crashes. But it hasn't crashed lately in our testing.

:) lets see, the lab here tends to create some really funny loops, often
by mistake.

> 
> Thanks.
> Srinivas.
> 
> P.S.: One note on bridge-stp and general bridge startup.
> 
> We started out with needing an explicit rstpctl command to indicate
> to the daemon that it needs to run RSTP on a bridge, which is why there is the
> "exec /sbin/rstpctl rstp $bridge on ;;" (as you corrected in your patch.)
> 
> But now, the daemon is written to enable RSTP when it finds that the
> kernel is treating the
> bridge as RSTP (/sys/class/net/<bridge_name>/bridge/stp_state is 2),
> so as long as you run
> "brctl stp <bridge_name> on" before briding the bridge interface up,
> you can just have a
> bridge-stp script that returns 0 (success) when you want rstpd to
> handle the bridge, and
> non-zero when you want kernel STP running on the bridge.
> 
> That startup sequence we use is:
> 0. Have a bridge-stp that returns 0 if you want RSTP for the
> particular bridge name.
>     Or returns 0 always if you intend to have only one bridge, and want RSTP.
> 
> 1. Start rstpd
> 2. Configure the bridge (brctl addbr, brctl addif's ...)
> 3. brctl stp <bridge_name> on
> 4. ifconfig <bridge_name> up. (Or ifup <bridge_name>, which should
> apply any IP config.)

OK, will, hopefully, try this this week. Today the girls got a new pet
and they are all over the place :)

 Jocke

> 
> 
> On Sat, Mar 29, 2008 at 10:40 PM, Joakim Tjernlund
> <Joakim.Tjernlund@transmode.se> wrote:
> > > -----Original Message-----
> >  > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
> >  > Sent: den 29 mars 2008 17:22
> >  > To: 'Bridge@lists.linux-foundation.org'
> >  > Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary problems
> >  >
> >  > Hi List
> >  >
> >  > I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
> >  > in on my 2.6.23 kernel, but didn't get very far:
> >  >
> >  > Created a bridge, br0, with brctl and added two interfaces.
> >  > started rstpd without args and ran rstpctl
> >  >   rstpctl showbridge br0
> >  > and all I get is
> >  >   CTL_get_bridge_state: Got return code 0, 1003
> >  >   Failed to get bridge state: Err_Bridge_is_down
> >  >
> >  > The br0 i/f is UP amd RUNNING and so is the interfaces I added.
> >  > I probably forgot to do something I suppose, but what?
> >  >
> >  >     Jocke
> >
> >  Never mind, user error on my part.
> >
> >  I do wonder though if rstpd is production ready or still needs more
> >  testing/fixes?
> >
> >
> >
> >    Jocke

