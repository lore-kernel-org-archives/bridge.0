Date: Tue, 4 Jan 2005 17:50:00 -0800
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050104175000.O2357@build.pdx.osdl.net>
References: <3d53b71204122004254a4d379b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d53b71204122004254a4d379b@mail.gmail.com>;
	from kingkhan@gmail.com on Mon, Dec 20, 2004 at 05:55:22PM +0530
Subject: [Bridge] Re: LSM hooks for bridge module.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Syed Ahemed <kingkhan@gmail.com>
Cc: bridge@osdl.org, linux-security-module@wirex.com

[bridge list Cc:'d]

* Syed Ahemed (kingkhan@gmail.com) wrote:
> Hi 
> The LSM patch  patch-2.5.72-lsm1.gz does not apply security hooks to
> net/bridge/br_stp_bpdu.c
> Has there been an effort to include security hooks at this level.

No, I don't recall LSM code in any form ever touching bridge code.
Would the ebtables code be useful for you?  (And as a side note, 2.5.72
is an ancient kernel, you should really work against something newer if
at all possible).

> I have a requirement that the STP requirement needs to check for DOS
> BPDU's affecting the linux bridge running 2.4.28 or 2.5.72.
> Please correct if am offtopic and sense.

I'm not sure if/how LSM would help you here.  I'm no spanning
tree protocol expert, perhaps the bridge developers could help you
(bridge@osdl.org Cc:'d).  I suspect this may be the wrong list.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
