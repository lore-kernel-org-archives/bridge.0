From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <33981.65.172.181.23.1076454426.squirrel@www.osdl.org>
Date: Tue, 10 Feb 2004 15:07:06 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC] bridge kernel API change
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: davem@redhat.com
Cc: bridge@osdl.org

Here is the proposed revision to the bridge utilities
interface to the kernel.  The driving force is that the
existing interface can't easily be converted to 32/64 bit
compat.  Right now, the bridge-utils (brctl) tries to handle
32bit command on 64 bit kernel, but the code is limited to sparc
and wrong.

Here is what I am thinking.

get version 		 - not needed?
get bridges		 - /sys/class/bridge/*
add bridge		 - SIOCBR_ADD_BRIDGE
del bridge		 - SIOCBR_DEL_BRIDGE
add if			 - SIOCBR_ADD_IF
delete if		 - SIOCBR_DEL_IF
get bridge info		 - /sys/class/bridge/brX/
get port list		 - /sys/class/bridge/brX/ports/*
set bridge forward delay - /sys/class/bridge/brX/forward_delay
set bridge hello time	 - /sys/class/bridge/brX/hello_time
set bridge max age	 - /sys/class/bridge/brX/max_age
set ageing time		 - /sys/class/bridge/brX/ageing_time
set gc interval		 - deprecated does nothing anymore
set get port info	 - /sys/class/bridge/brX/ports/ethX/*
set bridge stp state	 - /sys/class/bridge/brX/stp
set bridge priority	 - /sys/class/bridge/brX/priority
set port priority	 - /sys/class/bridge/brX/ports/ethX/priority
set path cost		 - /sys/class/bridge/brX/ports/ethX/cost
get fdb entries		 - /proc/net/bridge/brX

Other alternatives:
 - Use just ioctl's
 - Use just /proc (ugh) or sysctl's (double ugh)

I expect that for 2.6 the kernel will accept (but warn) the old ioctl
interface.  The new utility will not generate the old ioctl's
it would only work with new interface...



