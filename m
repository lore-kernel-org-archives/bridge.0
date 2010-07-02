Date: Fri, 2 Jul 2010 09:21:48 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100702092148.5d5a4e57@nehalam>
In-Reply-To: <20100702135641.GQ2149@gundam.enneenne.com>
References: <20100702135641.GQ2149@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] rstpd & 2.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 2 Jul 2010 15:56:41 +0200
Rodolfo Giometti <giometti@enneenne.com> wrote:

> Hello,
> 
> project rstpd at
> http://git.kernel.org/?p=linux/kernel/git/shemminger/rstp.git can work
> if default kernel stp is disabled by calling userspace program
> /sbin/bridge-stp and checking the return code.
> 
> On 2.4.27 such mechanism is not implemented so should I backport some
> kernel code or I can just disable the STP by using the
> BRCTL_SET_BRIDGE_STP_STATE ioctl command? There are any drawbacks in
> doing so?


The 2.4 kernel is missing all the hooks to provide user level STP.
The startup is not the big issue, the real problem is that the
kernel doesn't have hooks to control port state from user space,
and the spanning tree packets may not be visible to user space
application either.

Sigh, 2.4 is at least 5 years old by now.
