Message-ID: <20050506193333.10987.qmail@web30201.mail.mud.yahoo.com>
Date: Fri, 6 May 2005 12:33:33 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
Subject: Re: [Bridge] How to keep bridge up after reboot
In-Reply-To: <20050506120016.6b3d2673@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

One thing what has worked for me on RH[89] is
modification of a
/etc/sysconfig/network-scripts/ifcfg-br0
In it, you have the normal IP resolving stuff and then
add some script at the end (this file is acutally
sourced).  In example, if br0 was eth0 and eth1 and
your IP was dhcp:

DEVICE=br0
ONBOOT=yes
BOOTPROTO=dhcp
if [ "$0" = "/sbin/ifup" -o "$0" = "./ifup" ] ; then
  ip link set eth0 up
  ip link set eth1 up
  brctl addbr br0
  brctl addif br0 eth0
  brctl addif br0 eth1
fi
if [ "$0" =
"/etc/sysconfig/network-scripts/ifdown-post" ] ; then
  brctl delbr br0
  ip link set eth0 down
  ip link set eth1 down
fi

--- Stephen Hemminger <shemminger@osdl.org> wrote:

> On Thu, 5 May 2005 16:06:59 -0600 
> Scott Ellerbrock <sellerbrock@saferent.com> wrote:
> 
> > I am sorry for the newbie question. I am working
> with SUSE 9.2 and I have
> > followed the instructions at
> >
>
http://tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-4.html
> > 
> > I have gotten my bridge to work flawlessly, but I
> can't figure out how to
> > get the bridge to come up after a reboot. 
> > 
> > Any help or pointers to docs that will get me
> going in the right direction
> > would be greatly appreciated.
> > 
> > Scott
> >  
> It is really depends on the distribution, some of
> the firewall's etc have
> gui's and startup scripts to handle.  You might look
> in the SUSE doc's.
> > _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
