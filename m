Message-ID: <AD59566A9D83864F871AE2E52503064001663D7C@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] [RFC] bridge kernel API change
Date: Thu, 12 Feb 2004 12:37:56 -0500
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
To: bridge@osdl.org

Is the STP state of each port part of "set get port info"?

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org] 
> Sent: Tuesday, February 10, 2004 6:07 PM
> To: davem@redhat.com
> Cc: bridge@osdl.org
> Subject: [Bridge] [RFC] bridge kernel API change
> 
> 
> Here is the proposed revision to the bridge utilities
> interface to the kernel.  The driving force is that the
> existing interface can't easily be converted to 32/64 bit
> compat.  Right now, the bridge-utils (brctl) tries to handle
> 32bit command on 64 bit kernel, but the code is limited to sparc
> and wrong.
> 
> Here is what I am thinking.
> 
> get version 		 - not needed?
> get bridges		 - /sys/class/bridge/*
> add bridge		 - SIOCBR_ADD_BRIDGE
> del bridge		 - SIOCBR_DEL_BRIDGE
> add if			 - SIOCBR_ADD_IF
> delete if		 - SIOCBR_DEL_IF
> get bridge info		 - /sys/class/bridge/brX/
> get port list		 - /sys/class/bridge/brX/ports/*
> set bridge forward delay - /sys/class/bridge/brX/forward_delay
> set bridge hello time	 - /sys/class/bridge/brX/hello_time
> set bridge max age	 - /sys/class/bridge/brX/max_age
> set ageing time		 - /sys/class/bridge/brX/ageing_time
> set gc interval		 - deprecated does nothing anymore
> set get port info	 - /sys/class/bridge/brX/ports/ethX/*
> set bridge stp state	 - /sys/class/bridge/brX/stp
> set bridge priority	 - /sys/class/bridge/brX/priority
> set port priority	 - /sys/class/bridge/brX/ports/ethX/priority
> set path cost		 - /sys/class/bridge/brX/ports/ethX/cost
> get fdb entries		 - /proc/net/bridge/brX
> 
> Other alternatives:
>  - Use just ioctl's
>  - Use just /proc (ugh) or sysctl's (double ugh)
> 
> I expect that for 2.6 the kernel will accept (but warn) the old ioctl
> interface.  The new utility will not generate the old ioctl's
> it would only work with new interface...
> 
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
> 
