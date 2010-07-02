Date: Fri, 2 Jul 2010 21:22:46 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20100702192246.GH3826@enneenne.com>
References: <20100702135641.GQ2149@gundam.enneenne.com>
	<20100702092148.5d5a4e57@nehalam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100702092148.5d5a4e57@nehalam>
Subject: Re: [Bridge] rstpd & 2.4
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

On Fri, Jul 02, 2010 at 09:21:48AM -0700, Stephen Hemminger wrote:
> On Fri, 2 Jul 2010 15:56:41 +0200
> Rodolfo Giometti <giometti@enneenne.com> wrote:
> 
> > Hello,
> > 
> > project rstpd at
> > http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git can work
> > if default kernel stp is disabled by calling userspace program
> > /sbin/bridge-stp and checking the return code.
> > 
> > On 2.4.27 such mechanism is not implemented so should I backport some
> > kernel code or I can just disable the STP by using the
> > BRCTL_SET_BRIDGE_STP_STATE ioctl command? There are any drawbacks in
> > doing so?
> 
> 
> The 2.4 kernel is missing all the hooks to provide user level STP.
> The startup is not the big issue, the real problem is that the
> kernel doesn't have hooks to control port state from user space,

These could be added...

> and the spanning tree packets may not be visible to user space
> application either.

Neither using a packet sniffer?

> Sigh, 2.4 is at least 5 years old by now.

I see but I need to update an old product... what do you suggest to
me? It could be easier to add missing code to kernel 2.4 or just
trying to port rstp in kernel-land? In the latter case, have you some
URLs to suggest to me? :)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
