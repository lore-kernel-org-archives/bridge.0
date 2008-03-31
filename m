Date: Mon, 31 Mar 2008 10:08:32 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080331100832.61492b78@extreme>
In-Reply-To: <1206983174.7589.477.camel@gentoo-jocke.transmode.se>
References: <019201c891bf$c76a1b60$563e5220$@Tjernlund@transmode.se>
	<20080331090642.55fc2b60@extreme>
	<1206983174.7589.477.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 31 Mar 2008 19:06:14 +0200
Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:

> 
> On Mon, 2008-03-31 at 09:06 -0700, Stephen Hemminger wrote:
> > On Sat, 29 Mar 2008 18:10:24 +0100
> > "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se> wrote:
> > 
> > > > -----Original Message-----
> > > > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
> > > > Sent: den 29 mars 2008 17:22
> > > > To: 'Bridge@lists.linux-foundation.org'
> > > > Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary problems
> > > > 
> > > > Hi List
> > > > 
> > > > I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
> > > > in on my 2.6.23 kernel, but didn't get very far:
> > > > 
> > > > Created a bridge, br0, with brctl and added two interfaces.
> > > > started rstpd without args and ran rstpctl
> > > >   rstpctl showbridge br0
> > > > and all I get is
> > > >   CTL_get_bridge_state: Got return code 0, 1003
> > > >   Failed to get bridge state: Err_Bridge_is_down
> > > > 
> > > > The br0 i/f is UP amd RUNNING and so is the interfaces I added.
> > > > I probably forgot to do something I suppose, but what?
> > > > 
> > > >     Jocke
> > > 
> > > Never mind, user error on my part.
> > > 
> > > I do wonder though if rstpd is production ready or still needs more
> > > testing/fixes?
> > > 
> > >    Jocke
> > 
> > The rstpd stuff isn't widely used, more because of the administration,
> > packaging, startup issues etc. It is kind of a chicken/egg problem, no
> > one uses it so no one reports bugs.The RSTP code library has been
> > around for a long while and doesn't have any known issues.
> 
> I see, what do you think of Srinivas rewrite? I looks
> much cleaner, have you had a chance to test it? 

He did most of the original rstp code, just haven't had chance to merge it.
Dirty secret, I don't use bridging normally, and have to go out of my way to setup
tests so that is part of the reason I don't merge things until they have settled.
