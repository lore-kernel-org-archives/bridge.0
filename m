Date: Tue, 13 Jul 2004 13:15:57 -0700
From: bferrell@baywinds.org
Subject: Re: [Bridge] Bridge support unavailable
Message-Id: <1089749757.31365@baywinds.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Bert Hubbs <bhubbs@mbgdocs.com>, bridge@lists.osdl.org

Stephen,

The module will only autoload if /etc/modules.conf is setup for it.  Checking  redhat 7.3, redhat 9.0, WhiteBox EL3, Suse 8.0 and Suse 9.0 systems, none have anything to cause bridge.o to alias to br0.  Those are the only systems I have to look at.  I don't know what other distros like debian or mandrake do for bridge.o.  They might have it in the modules.conf file... Dunno.

So, Bert, you'll need to add something like this to /etc/modules.conf:

alias br0 bridge

The stuff I sent before was in the nature of diagnostics and debugging

I'm still trying to get my beridge.o to build cleanly :(


> On Tue, 13 Jul 2004 11:17:51 -0500
> Stephen Hemminger <shemminger@osdl.org> wrote ..
> On Tue, 13 Jul 2004 11:17:51 -0500
> "Bert Hubbs" <bhubbs@mbgdocs.com> wrote:
> 
> > Yep!
> > First lsmod I got no bridge. Second lsmod after modprobe bridge I got
> > bridge listed. So here comes the $35 question. How do you make the
> > module load at boot?
> > After Googleing modprobe, lsmod, insmod there seems to be know way to
> > use modprobe to load modules at boot. I came across discussion to add
> it
> > to modprobe.conf but others said this would not cause it to load at
> > boot. Another mentioned rc.local but I'm not sure that rc.local will
> > load at the right time. On the other had that may not matter but I'm
> in
> > to cleanliness.
> > 
> > Any suggestions?
> 
> Your working too hard at getting it loaded.  The kernel will automatically
> load the bridge module when the first bridge is created with brctl.  Since
> brctl has to do an ioctl() to create a bridge, the kernel will load the
> module if needed.  You can't build the bridge module seperate from the
> kernel. The kernel needs to know the bridge
> module is coming to have the necessary hooks.
> 
> Just doing:
> 	brctl addbr br0
> should create bridge br0 and load the bridge module.
