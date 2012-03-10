Return-Path: <sfandino@yahoo.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1331377929; bh=lgrIbjMEiair7YDN2LzBv3eJ1frNCco6wnPIc6UW5lE=;
	h=X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
	b=wb5SkFAZfgc0vU3JDNgxCh1Ljd8xMx9gPnldR7ixBTmAYsT6dAyMcoFTX3SwOH6GIPZE3V9gHOA9jWPr2K6GCnLqv8w2bM21TAnOjZ75zuqlPH4+ehClGy3OhpzsTtgL0qcL6Tp4FWGtvlwAdZr+8WqUEHuTfOXnCnTEhCb6SFc=
Message-ID: <4F5B36FD.3030206@yahoo.com>
Date: Sat, 10 Mar 2012 12:11:57 +0100
From: =?ISO-8859-1?Q?Salvador_Fandi=F1o?= <sfandino@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge iface drops everything
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have a machine, where I am running LXC containers on demand. These 
containers don't need to talk to the outside, just between then and to 
the host, so I am attaching them to an isolated bridge (br0) that 
doesn't have any physical interface attached.

My problem is that by default, the bridge MAC is changed when new 
containers are added or old ones removed causing the network to freeze 
until ARP tables timeout (this is a known "feature").

I have tried to fix the bridge MAC address:

   ip link set br0 address 00:11:22:33:44:55

But that doesn't work unless the MAC used correspond to the virtual 
interfaces of one of the containers or if I make br0 in promiscuous 
mode. Otherwise, br0 seems to drop all the traffic arriving there.

If seems that packets are not going up to the TCP/IP stack through the 
bridge interface (br0) but through any of the interfaces attached to the 
bridge that happens to have the same MAC.

Is this the expected behavior?


BTW, I am running SLES11 SP1 and SP2.
