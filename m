Date: Wed, 15 Sep 2004 14:01:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Transparently bridge Vlans to eth0
Message-Id: <20040915140144.2c8b4505@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040915134345.77495.qmail@web25105.mail.ukl.yahoo.com>
References: <20040914095620.7cb835ae@dell_ss3.pdx.osdl.net>
	<20040915134345.77495.qmail@web25105.mail.ukl.yahoo.com>
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
To: liam sharp <piccalo_clark@yahoo.co.uk>
Cc: bridge@lists.osdl.org

On Wed, 15 Sep 2004 14:43:45 +0100 (BST)
liam sharp <piccalo_clark@yahoo.co.uk> wrote:

> If filtering with ebtables is whats required, then I
> will do that.
> 
> I don't think I want the bridge to have an IP address.
> What I really would like is for all Vlans to be
> forwarding to eth0, which maintains its IP address.
> I'd like it simply to see all data coming from each
> Vlan, without the vlan tags.
> 
> Imagine a LAN with gateway 10.0.0.1 and no vlans. All
> clients have either static of dynamic IP address on
> the 10.0.0.0 network.
> 
> Now I want to prevent hosts the 10.0.0.0 network
> talking with any other host other than 10.0.0.1. I
> have no control over the clients. 


So what you want is:

	10.0.0.2------------- eth0.2-\ 
				      \
	10.0.0.3------------- eth0.3-- br0 -- eth0 ---------------------- 10.0.0.1
				      /
	10.0.0.X------------- eth0.4-/

A couple of things:
  * it isn't clear if the bridge machine and 10.0.0.1 are separate machines?

  * if you are a using a VLAN switch then eth0 can't be both tagged and untagged.
    I.e. either the switch thinks that eth0 is another VLAN switch and add forwards the
    VLAN tags or it assumes eth0 is assigned to a particular VLAN and filter/strips them.
    Probably what you want is to reserve a VLAN between the bridge and 10.0.0.1 (eth0.1?)

If you want to talk IP on the bridge, then assign a static IP to br0.

	10.0.0.2------------- eth0.2-\ 
				      \  10.0.0.99
	10.0.0.3------------- eth0.3-- br0 -- eth0.1---------------------- 10.0.0.1
				      /
	10.0.0.X------------- eth0.4-/

> What I have done is configure each port in the network
> to be on a unique Vlan. This now prevents any pier to
> pier communication.
> 
> However the gateway, 10.0.0.1 is plugged into a trunk
> port which transports all Vlans to the network
> interface, eth0. To read this data I can configure
> many sub interfaces, one for each vlan.

See ebtables for how to set up the filtering rules.

> The problem is as it stand I belive each must have its
> own IP, which I don't want to have to do. I'd like to
> somehow bridge each Vlan, to eth0 transparently. This
> way I don't have to change my dhcp server of anything
> else, just set up the Vlans and bridge them (I hope).

No IP should be assigned to eth0 or the VLAN interfaces.

> Has anyone ever done this or something similar ?
> 
> Many thanks for reading !
> Piccalo
>
