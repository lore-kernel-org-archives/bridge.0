Message-ID: <4579F417.4050007@schaus.ca>
Date: Fri, 08 Dec 2006 18:24:07 -0500
From: Cameron Schaus <cam@schaus.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] BPDU's not passing through bridge when STP is disabled
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I have noticed a change in the linux bridge implementation between 
2.1.15 and 2.1.17.  Specifically, I do not think BPDU's (generated from 
another bridge) are passed across the bridge when STP is disabled.  I 
think this relates to the LLC handling of BPDU's directly invoking 
br_bpdu_rcv.

In 2.6.15, the br_handle_frame function would pass a BPDU to the 
br_handle_frame_finish function which would transmit it across the 
bridge.  But in 2.6.17, the br_bpdu_rcv function is invoked directly by 
the LLC layer, which does nothing if stp is disabled.

Was this change intentional?  The reason I ask is that I can introduce a 
loop into the network by doing the following:

Two machines, both with eth0 and eth1 bridged and STP is enabled:

        ----- A -----
-----+                +------
        ----- B -----


When I disable STP on machine A, it reverts to a standard bridge, with 
both eth0 and eth1 in the forwarding state.  Bridge B has STP enabled, 
and is sending out BPDU's.  Bridge B should disable one of its ports to 
prevent a loop in the network, but it doesn't, because bridge A does not 
pass the BPDU's across, so bridge B cannot detect the loop.  With the 
2.6.15 kernel, this loop was prevented.

Can br_handle_frame_finish be called from br_stp_rcv in the event that 
stp is not enabled, or would doing so cause problems?

Cam

