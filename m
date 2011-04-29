Message-ID: <4DBAE840.2060705@tektronix.com>
Date: Fri, 29 Apr 2011 11:33:04 -0500
From: Joe Harvell <joe.harvell@tektronix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] no wireless interfaces?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

I tried to bridge a wireless interface to a wired Ethernet interface,
and it failed with "Operation not supported."

Looking at the kernel code, it seems like this is intentional.  I
noticed the following in br_add_if:

        /* No bridging devices that dislike that (e.g. wireless) */
        if (dev->priv_flags & IFF_DONT_BRIDGE)
                return -EOPNOTSUPP;

I'm curious to know why this is not supported.

---
Joe

