Message-ID: <4B4674DC.3090602@iders.ca>
Date: Thu, 07 Jan 2010 17:57:16 -0600
From: Andrew <amckay@iders.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] STP on Linux 2.6.30.9
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hey guys,

I'm working with a bridge I set up on Linux 2.6.30.9.  I have two boards 
connected and created a redundant connection between them.  Basic set up is:

brctl addbr br0
brctl addif br0 vlan1
brctl addif br0 vlan2
brctl stp br0 on

Then I bring up the interfaces.  Everything seems to be fine.  Root 
bridge is negotiated properly and leaves both interfaces in forwarding 
mode.  The other bridge leaves one port in forwarding and puts the other 
in blocking mode.  However after several seconds a message is printed on 
my terminal saying that vlan2 lost it's neighbor and goes through the 
listening, learning and then forwarding states.  It then quickly flips 
back to blocking mode.  Is this normal behavior for STP on Linux 
2.6.30.9?  Or do I have something else going on here?

net/bridge/br_stp.c:36 br0: port 2(vlan2) entering blocking state
br0: neighbor 8000.3a:1f:34:08:54:56 lost on port 2(vlan2)
net/bridge/br_stp.c:36 br0: port 2(vlan2) entering listening state
net/bridge/br_stp.c:36 br0: port 2(vlan2) entering learning state
br0: topology change detected, sending tcn bpdu
net/bridge/br_stp.c:36 br0: port 2(vlan2) entering forwarding state
br0: topology change detected, sending tcn bpdu
net/bridge/br_stp.c:36 br0: port 2(vlan2) entering blocking state

If there's any further information you need, let me know.

Andrew McKay
Iders Inc.
