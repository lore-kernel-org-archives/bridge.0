Date: Tue, 27 Jul 2010 11:26:55 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20100727092655.GA30692@gundam.enneenne.com>
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

> The 2.4 kernel is missing all the hooks to provide user level STP.
> The startup is not the big issue, the real problem is that the
> kernel doesn't have hooks to control port state from user space,
> and the spanning tree packets may not be visible to user space
> application either.
> 
> Sigh, 2.4 is at least 5 years old by now.

Hello, I'm going to start backport of rstpd to kernel 2.4 series and
I'd like having some advices from you.

Regarding the bridge controls I can add to the current sysfs interface
the old ioctl interface as the old bridge-utils did. Do you think I
can contribute to the rstpd code in order to support such interface or
you have no interest in doing it?

The problem of controlling the port state from user space can be
resolved by adding the missing netlink commands into the kernel code.

In the end, spanning tree packets may be captured as tcpdump do, is
that right?

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
