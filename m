Date: Tue, 14 Sep 2004 09:56:20 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Transparently bridge Vlans to eth0
Message-Id: <20040914095620.7cb835ae@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040914134858.61482.qmail@web25105.mail.ukl.yahoo.com>
References: <20040914134858.61482.qmail@web25105.mail.ukl.yahoo.com>
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

On Tue, 14 Sep 2004 14:48:58 +0100 (BST)
liam sharp <piccalo_clark@yahoo.co.uk> wrote:

> Hi,
> 
> I'm using Vlans in my network as a way of preventing
> pier to pier communication - I only want nodes in the
> network to talk to the gateway (a linux box).
> 
> I have successfully set up lots of sub interfaces
> using the vconfig too, one for each vlan. What I would
> like to be able to do is remove the ip address from
> each of these subinterfaces eth0.x and bridge them to
> eth0. I have successfully worked through the HOWTO,
> but cannot see how to adapt this to my situation. 
> 
> I want the network to appear to eth0 as if all the
> nodes are on the same network - like if I didn't use
> any Vlans at all.

That isn't going to work.  eth0 is the needed to provide the
tagged interface, the eth0.x are just pseudo interfaces that
have tags.

You can bridge the vlan's but unless you do filtering with ebtables
to restrict what flows why bother? If you do bridge a bunch of vlan's
then the original eth0 interface on the bridge should be left alone.
If you need the bridge to have an IP address assign it to the bridge
pseudo network device (br0).
