From: "Roman Chertov" <rchertov@purdue.edu>
Subject: RE: [Bridge] bridge in 'hub' mode possible?
Date: Fri, 3 Dec 2004 11:48:35 -0500
Message-ID: <017001c4d957$f0f29b70$0100a8c0@raider>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <41B03950.5000106@web.de>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: 'Michael Renzmann' <mrenzmann@web.de>, bridge@osdl.org

> 
> Hi.
> 
> Stephen Hemminger wrote:
> > Have you tried "brctl setageingtime br0 0" to turn off
> > forwarding table?
> 
> I wonder if it would be worth to introduce some kind of "monitor
> interface" for a brigde (as can be found on switches, don't know if
> "monitor port" would be the correct term for it).
> 
> The bridge could work as usual, while this virtual interface sees
every
> packet that traverses the bridge. tcpdump & co could be used on this
> interface when needed. As an addition it should be possible to
> enable/disable this interface using a new brctl command (something
like
> "brctl br0 monitor on|off").
> 
> Comments? If there's interest in such a function I possibly could
spend
> some time on it after christmas.

I have already made one for the 2.4.20 kernel module and the 1.0.4
bridge-utils.  Since I was making this for the Emulab testbed I also had
to change the src/dst MACs that were going to the tap; otherwise, the
underlying switch would drop the mirrored packets as their MAC's were
not registered on the VLAN where the tap sat.  

If people have any interest in this I can share with the code.

Roman


> 
> Bye, Mike
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge

