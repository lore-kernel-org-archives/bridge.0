Date: Thu, 2 Dec 2004 11:11:08 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Problem with bridge/8139too module under 2.4.27?
Message-Id: <20041202111108.25448eb8@dxpl.pdx.osdl.net>
In-Reply-To: <9EB50F1A91413F4FA63019487FCD251DACA2@WEBBASEDDC.webbasedltd.local>
References: <9EB50F1A91413F4FA63019487FCD251DACA2@WEBBASEDDC.webbasedltd.local>
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
To: Mark Cave-Ayland <m.cave-ayland@webbased.co.uk>
Cc: bridge@lists.osdl.org

On Mon, 15 Nov 2004 10:29:35 -0000
"Mark Cave-Ayland" <m.cave-ayland@webbased.co.uk> wrote:

> Hi there,
> 
> I'm currently experiencing a minor problem using the bridge module under
> kernel 2.4.27 part of the Devil Linux distribution
> (http://www.devil-linux.org). The problem I am having is that when the
> bridge is unloaded during a reboot I receive the following errors in
> /var/log/messages:
> 
> Nov 14 13:22:13 src@Devil kernel: unregister_netdevice: waiting for br0 to
> become free. Usage count = 2
> 
> This message is repeatedly output to the console until I manually go and
> power cycle it. I've traced this through the startup/shutdown scripts, and
> have determine that the problem exists in the following sequence of
> commands:
> 
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> ifconfig eth0 up
> ifconfig eth1 up
> 
> ifconfig eth0 down
> ifconfig eth1 down
> brctl delif eth0
> brctl delif eth1

ifconfig br0 down

Take take the bridge down as well. The code on 2.4 is not as robust
or complete as 2.6 and probably needs that.

> brctl delbr br0   <------ This is where the problem occurs
> 
> The machine running the kernel is a brouter with 4 NICs all running under
> the 8139too driver - eth0 and eth1 form a bridge while eth2 and eth3 are
> connected to different internal networks. I'm guessing that this is either a
> problem with the bridge or 8139too modules, and so any advice would be
> gratefully received :)
> 
> 
> Many thanks,
> 
> Mark.
> 
> ------------------------
> WebBased Ltd
> South West Technology Centre
> Tamar Science Park
> Plymouth
> PL6 8BT 
> 
> T: +44 (0)1752 791021
> F: +44 (0)1752 791023
> W: http://www.webbased.co.uk
>  
> 
> 
> 
> 
