Message-ID: <20040828122951.51291.qmail@web13912.mail.yahoo.com>
Date: Sat, 28 Aug 2004 05:29:51 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
Subject: Re: [Bridge] Getting dynamic ip address for a bridge
In-Reply-To: <200408281113.18945.bdschuym@pandora.be>
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
To: "'bridge@lists.osdl.org'" <bridge@lists.osdl.org>

For my bridge use, I have actually altered the
ifcfg-br0 script itself.  It is actually sourced
during the up/down, so you can add code.  After all
your variable definitions add something like this:
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
NOTE:  '$0' has changed a bit over revisions, I have
found.  If the up or down do not work, use an echo $0
to see what the script name is.  

-Scott

--- Bart De Schuymer <bdschuym@pandora.be> wrote:

> On Saturday 28 August 2004 01:42, Oliver King-Smith
> wrote:
> > My script looks like this
> >
> > ifconfig wlan0 0.0.0.0
> > ifconfig eth0 0.0.0.0
> > brctl addbr mybridge
> > brctl addif eth0
> > brctl addif wlan0
> > #ifconfig mybridge 192.168.1.136 netmask
> 255.255.255.0 up
> > ifconfig mybridge up
> >
> > Should I be waiting before I run the ifconfig
> mybridge up?
> 
> "pump -i mybridge" (or using some other dhcp tool)
> after you last line should 
> work just fine.



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - Helps protect you from nasty viruses.
http://promotions.yahoo.com/new_mail
