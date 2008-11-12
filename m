Date: Wed, 12 Nov 2008 03:46:20 +0000 (GMT)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
In-Reply-To: <574385790811111227p6437caefyec268fda34631e7@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.0811120344140.23755@callisto.malc.org.uk>
References: <574385790811111227p6437caefyec268fda34631e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] Terrible performance between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alex Malinovich <alexmalinovich@gmail.com>
Cc: bridge@lists.linux-foundation.org

At 12:27 yesterday, Alex Malinovich wrote:

> I recently set up a couple of bridges to use with Xen virtualized
> machines and we're experiencing some terrible performance in certain
> cases.

This sounds like the classic Xen problem with TCP segment offloading -- you 
may need to run "ethtool -K eth0 tso off" on every Xen domain.  I consider 
this to be a long-standing Xen bug.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

