Message-ID: <078d01c49507$e9751290$8805640a@chriss>
From: "Chris Shaw" <chriss@watertech.com>
References: <3418F3471F1CA4409901547349FFAE2E0226D24B@ftrdmel2.rd.francetelecom.fr>
Subject: Re: [Bridge] Wired iface + Wireless iface configuration in managed
	mode
Date: Tue, 7 Sep 2004 11:24:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Reply-To: Chris Shaw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Wired iface + Wireless iface configuration in managed mode----- Original
Message -----
From: zze-gandhi PERESSE M ext RD-RESA-REN
To: bridge@lists.osdl.org
Sent: Tuesday, September 07, 2004 1:28 AM
Subject: [Bridge] Wired iface + Wireless iface configuration in managed mode


Hi all,


I have to set up a bridge in the following configuration:
1 Wired Interface
1 Wireless Interface in Managed Mode (ie connected to an access point)


The architecture is as follows:


Private Internet ------- Wireless Router/AP ----     air     ----- Linux
Bridge ----wire----- Host A
So let's say I have a host (Host A) connected to the wired interface of that
bridge, I would like to be able to communicate with hosts that are behind
the wireless router (ie the private Internet)
The problem is that when the Linux bridge forwards Host A's Ethernet frames
to the AP, the AP doesn't allow these frames to pass through, because Host A
isn't a regular wireless client who has been authenticated/associated
(802.11).
One solution is to implement an authentication/association proxy in the
Linux Bridge  (I think D-LINK does that in their APs):
- The bridge would do the association/authentication process on behalf of
the wired hosts..
Another solution would be to spoof the mac address of the Wireless Interface
of the Linux Bridge but there is no way to multiplex frames for multiple
wired hosts (is there any ?).
Are there plans for solving_this_"issue" / adding_this_feature ?


Thanks a lot.
Mathieu.
PS: I NEED to do this for an experiment only, I can't use another
architecure.

----------------------------REPLY BEGINS HERE------------------------

This is not a linux bridging issue, what you want is an AP that can operate
in "Bridge Mode", that is, it associates with the MAC address of another AP
(Your linux bridge in Managed Mode) and allows frames to be passed through
the virtual "wire" that is created between the two APs.

There are several NetGear APs that function this way, the WG302 comes to
mind but it's a bit expensive.. Very nice piece of hardware though...

I have a question though, why do you want to use an AP? Why not just set up
another linux bridge with a wireless card and have that act as an AP?  You
can buy Prism2.5/3 based cards for like $20-30 now...

    -Chris

