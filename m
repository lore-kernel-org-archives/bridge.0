Date: Mon, 18 Aug 2003 09:12:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridging with ethertap causing kernel oops
Message-Id: <20030818091235.6189d4d8.shemminger@osdl.org>
In-Reply-To: <20030817095157.GD12512@tummy.com>
References: <20030817095157.GD12512@tummy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Sean Reifschneider <jafo@tummy.com>
Cc: bridge@osdl.org

On Sun, 17 Aug 2003 03:51:57 -0600
Sean Reifschneider <jafo@tummy.com> wrote:

> Greetings.  I've been experimenting with bridging an ethernet device
> with an ethertap device (using the Linux tun/tap driver).  This is
> running with the bridge code in the Linux kernel version 2.4.20 as
> provided by Red Hat (2.4.20-18.9).  I also seem to have seen the problem
> with 2.4.21 from the Red Hat beta kernel.  I'm going to try a generic
> kernel as soon as I can get the remote machine rebooted.

Good, it is hard to get accurate data with vendor patched kernels.

> What I've done is set up the tap device using the OpenVPN software to
> another machine, and then want to bridge eth1 to that tap device, with
> transport for it happening over eth0.
> 
> Things all seem to work fine for some small period of time, but at some
> point it will cause the kernel to Oops (oops output provided below).
> The Oops doesn't seem to be load-related.  I was able to download a
> couple copies of the Linux kernel over it without any problems, then
> when I tried setting up policy routing, it oopsed.
> 
> I'm probably going to just switch to a routed network instead of using
> the bridge, but I wanted to pass this information on in case it helped
> make the bridging more stable.  I have a test setup which I can try
> reproducing this problem on if it helps.  I'd love to dig into the
> kernel code, but I don't have the time right now.
> 
> I've dug through the mailing list arcives and looked for more up-to-date
> bridge code, but haven't found anything obvious for either of those.
> 
> Thanks,
> Sean

Are you running with STP turned on?

Also, could you try with 2.6.0-test3 to see if it is something that
has already been covered by the 2.6 bug fixing?
