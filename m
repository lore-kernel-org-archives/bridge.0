Date: Mon, 31 Mar 2008 09:06:42 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080331090642.55fc2b60@extreme>
In-Reply-To: <019201c891bf$c76a1b60$563e5220$@Tjernlund@transmode.se>
References: <019201c891bf$c76a1b60$563e5220$@Tjernlund@transmode.se>
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
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Cc: Bridge@lists.linux-foundation.org

On Sat, 29 Mar 2008 18:10:24 +0100
"Joakim Tjernlund" <Joakim.Tjernlund@transmode.se> wrote:

> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se]
> > Sent: den 29 mars 2008 17:22
> > To: 'Bridge@lists.linux-foundation.org'
> > Subject: RSTP in http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git;a=summary problems
> > 
> > Hi List
> > 
> > I cloned the above RSTP imp. and cross-compiled it to powerpc and tried
> > in on my 2.6.23 kernel, but didn't get very far:
> > 
> > Created a bridge, br0, with brctl and added two interfaces.
> > started rstpd without args and ran rstpctl
> >   rstpctl showbridge br0
> > and all I get is
> >   CTL_get_bridge_state: Got return code 0, 1003
> >   Failed to get bridge state: Err_Bridge_is_down
> > 
> > The br0 i/f is UP amd RUNNING and so is the interfaces I added.
> > I probably forgot to do something I suppose, but what?
> > 
> >     Jocke
> 
> Never mind, user error on my part.
> 
> I do wonder though if rstpd is production ready or still needs more
> testing/fixes?
> 
>    Jocke

The rstpd stuff isn't widely used, more because of the administration,
packaging, startup issues etc. It is kind of a chicken/egg problem, no
one uses it so no one reports bugs.The RSTP code library has been
around for a long while and doesn't have any known issues.

Since Vyatta is a debian based distribution, I am toying with the idea
of making a debian package for rstp to get more early users.
I recommend anyone making an appliance based distribution or device
consider using rstpd since the kernel STP code is so old.

After the rstpd code is more widely used, the kernel STP code should
be able to be fully disabled.
