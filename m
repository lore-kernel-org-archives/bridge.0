Message-ID: <564DE4477544D411AD2C00508BDF0B6A1E7E3610@USAHM018.amer.corp.eds.com>
From: "Small, Jim" <jim.small@EDS.COM>
Subject: RE: [Bridge] bridging interfaces
Date: Mon, 29 Mar 2004 12:17:24 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: amedina@seplade.michoacan.gob.mx, bridge@osdl.org

You can,

I'm doing it right now:
br0             8000.00d0b725df90       no              eth0
                                                        eth1
                                                        eth4

Of course, I'm assuming you're talking about an x86 based platform.  If
you're not, good luck...

FYI,
   <> Jim

> -----Original Message-----
> Hi:
> 
> Simple Quiestion...!!!
> 
> Can I add more than two interfaces to a bridge (br0) like a
> eth2 or some like that..!!!???
> 
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> brctl addif br0 eth2
> .
> .
> etc.

