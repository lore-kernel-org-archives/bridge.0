Content-class: urn:content-classes:message
Subject: RE: [Bridge] Bridge code enhancement (link state detection) and
	bugfix. (patches included).
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 20 Jul 2004 09:02:18 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFC1D@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Mark Ruijter <bridge@siennax.com>, Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Adding an STP state seems like a bad idea.  Aren't br->stp_enabled and
(dev->flags & IFF_UP) sufficient to determine whether check_link()
should reenable a port?

> -----Original Message-----
> From: bridge-bounces@lists.osdl.org 
> [mailto:bridge-bounces@lists.osdl.org] On Behalf Of Mark Ruijter
> Sent: Tuesday, July 20, 2004 7:25 AM
> To: Stephen Hemminger
> Cc: bridge@lists.osdl.org
> Subject: Re: [Bridge] Bridge code enhancement (link state 
> detection) and bugfix. (patches included).
> 
> 
> Stephen Hemminger wrote:
> 
> > 
> > Could you split out the link state monitoring, and look at 
> bonding to see
> > how they are doing it?
> > 
> > I have a fix for vlan code that passes MII and ethtool 
> requests from the virtual
> > to physical device, so the bridge code wouldn't need to the 
> hack about root device.
> > 
> 
> Stephen,
> 
> I've attached two patches that implement link state monitoring as 
> described above.
> 
> De bridge-utils patch also fixes a small bug:
> 
> ./brctl stp TEST
> Segmentation fault
> 
> --
> Mark Ruijter.
> bridge@siennax.com
> 

