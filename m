Date: Mon, 19 Apr 2010 09:00:23 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100419090023.6c6d34a1@nehalam>
In-Reply-To: <i2xe5da85b41004190235t447ea22exa046c63fc3373971@mail.gmail.com>
References: <i2xe5da85b41004190235t447ea22exa046c63fc3373971@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RSTP-Linux Bridge (2.6 Kernel) query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: voxner <voxner.dev@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 19 Apr 2010 15:05:35 +0530
voxner <voxner.dev@gmail.com> wrote:

> Hi all,
> 
> I am fairly new to Bridging, and I have been trying to understand the
> Bridge-RSTP communication. I have an RSTP implementation running in
> user-space and I would like to use the existing Linux bridge data-structures
> (like net_bridge, net_bridge_port used in Linux 2.6) so that I have a
> Linux-Bridge/RSTP setup. For this I need to introduce some sort of
> communication mechanism (maybe IOCTL calls) to alter these data-structures
> by my RSTP.

Did you look at RSTP user space daemon? or is this a new one.
       git clone git.kernel.org:/pub/scm/linux/kernel/git/shemminger/rstp.git

I already have five alternatives for RSTP, and none of them is fully
integrated!  3 user space daemons (1 on rstplib, 1 from EMC, and
another). 2 kernel implementations based on old 2.4 code.

Somewhere down the road, there needs to be one and only one solution
and it has to just work out of the box.  If I had infinite time, or
a major Vyatta customer demanded it, I would just integrate one of
the 2.4 implementations and be done.
