Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 22 Sep 2004 16:52:58 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0CFCDA@aiexchange.ai.aiinet.com>
From: "Eble, Dan" <DanE@aiinet.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Bridge address change netlink message
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I want a process to know when the hardware address of br0 changes.  I
looks like br_stp_change_bridge_id() in br_stp_if.c is where the change
occurs.  Is there anyone out there who can cook up a simple patch to
send a netlink message (the same kind of message that is sent when
SIOCSIFHWADDR happens on a device that supports it), or is this a
problem that requires major restructuring to solve?  I am using kernel
2.4.21, but br_stp_change_bridge_id() looks mostly the same in 2.6.

Thank you.
-- 
Dan Eble <dane@aiinet.com>  _____  .
Software Engineer          |  _  |/|
Applied Innovation Inc.    | |_| | |
http://www.aiinet.com/     |__/|_|_|

