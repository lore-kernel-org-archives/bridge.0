Date: Tue, 13 Jul 2004 09:54:41 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge support unavailable
Message-Id: <20040713095441.5496307f@guest-250-122.pdx.osdl.net>
In-Reply-To: <D1BBAADDE65D9646B5F0C6332C038B4E06F143@mbgexc.mbgdocs.com>
References: <D1BBAADDE65D9646B5F0C6332C038B4E06F143@mbgexc.mbgdocs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bert Hubbs <bhubbs@mbgdocs.com>
Cc: bridge@lists.osdl.org

On Tue, 13 Jul 2004 11:17:51 -0500
"Bert Hubbs" <bhubbs@mbgdocs.com> wrote:

> Yep!
> First lsmod I got no bridge. Second lsmod after modprobe bridge I got
> bridge listed. So here comes the $35 question. How do you make the
> module load at boot?
> After Googleing modprobe, lsmod, insmod there seems to be know way to
> use modprobe to load modules at boot. I came across discussion to add it
> to modprobe.conf but others said this would not cause it to load at
> boot. Another mentioned rc.local but I'm not sure that rc.local will
> load at the right time. On the other had that may not matter but I'm in
> to cleanliness.
> 
> Any suggestions?

Your working too hard at getting it loaded.  The kernel will automatically load the bridge module when the first bridge is created with brctl.  Since brctl has to do an ioctl() to create a bridge, the kernel will load the module if needed.  You can't build the bridge module seperate from the kernel. The kernel needs to know the bridge
module is coming to have the necessary hooks.

Just doing:
	brctl addbr br0
should create bridge br0 and load the bridge module.
