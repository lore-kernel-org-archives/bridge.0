From: Bart De Schuymer <bdschuym@pandora.be>
Date: Fri, 8 Aug 2003 01:14:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308080114.09148.bdschuym@pandora.be>
Subject: [Bridge] [ANNOUNCE] ebtables + bridge-nf patch 3 for 2.4.21
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
To: ebtables-user <ebtables-user@lists.sourceforge.net>, bridge <bridge@osdl.org>

It's available at the usual place.
Change: remove vlan patch from Bassem Armanyous. Kernel oopses were reported 
in kernels that have an unloaded but compiled vlan module.
I currently lack the time to figure out the solution, so for now it's removed.
If you're not getting an oops, there is no need to switch from patch 2 to the 
new patch (3).

cheers,
Bart

