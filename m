From: Bart De Schuymer <bdschuym@pandora.be>
Date: Sun, 2 Nov 2003 19:07:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021907.03329.bdschuym@pandora.be>
Subject: [Bridge] [RELEASE] ebtables-brnf-3-vs-2.4.22 and ebtables-2-0-6
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ebtables-user <ebtables-user@lists.sourceforge.net>, bridge <bridge@osdl.org>

Hi,

At http://sourceforge.net/projects/ebtables/ you can find the following new 
releases:

ebtables-brnf-3-vs-2.4.22
Changes:
- let iptables see VLAN tagged IP traffic
- bugfix for queued packets that get mangled in userspace
- ebt_among module (Grzegorz Borowiak)
- ebt_limit module (Tom Marshall) 
The patch compiles but I've done no further tests, but I probably didn't screw 
up.

ebtables-2-0-6 (userspace)
- ebt_among module (Grzegorz Borowiak)
- ebt_limit module (Tom Marshall) 

cheers,
Bart

