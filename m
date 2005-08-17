Message-ID: <61361.198.74.20.73.1124321266.squirrel@mail.outboxes.com>
Date: Wed, 17 Aug 2005 16:27:46 -0700 (PDT)
From: "North Antara" <north@ntbox.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Wireless bridge - revisited
Reply-To: north@ntbox.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Several weeks ago (July 1st), you may remember me asking about using a
Linksys WET11 (ethernet to wireless bridge) with bridge-utils.

Mark Mathews was kind enough to respond and described a situation he
called "b/mcast echo".  From his reply:
"
Because of the games that have to be played to build WLAN station bridge
devices, some have a problem with what I call 'b/mcast echo'.  Basically,
what happens is this:
   1) the WLAN bridge (call it WB) device picks up a broadcast frame (like
      the arp request from a2:a9) from it's ethernet interface,
   2) WB forwards the the bcast frame to the WLAN AP via a unicast WLAN
      frame (this is normal behavior),
   3) WLAN APs, by default, take 'unicast encapsulated' broadcast frames
      received on the WLAN interface and rebroadcast them on the air _as_
      broadcast frames (this occurs inside the WLAN mac layer so any
      bridging in the AP itself would have no effect on this problem),
   4) The WB picks up the rebroadcasted bcast frame and forwards it to the
      wire, hence the broadcast frame shows up on the wire twice.

In a bridge situation, the bridge would first see the bcast frame on port
2 (the original transmission), then some time later it would see it again
on port 4 (the echo).  When the bridge sees the frame arrive on port 4, it
moves the port assignment for that macaddr thus misdirecting any
subsequent unicast traffic sent to that macaddr.
"

I'm now in the process of redesigning my network and I have a multipart
question.

A=Linux router with bridge-utils and 4 bridged ports (eth1-eth4)
B=Unmanaged switch
C=WET11

1) If I were to move C from A to B (which will be on A), will this same
type of problem occur?

2) If so, what are some recommendations on what I could do to avoid this
problem?

I'd like to keep the WET11 on the same vlan if at all possible.


Any help would be greatly appreciated.

Thanks,
    North.
