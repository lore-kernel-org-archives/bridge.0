References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
From: Benny Amorsen <benny+usenet@amorsen.dk>
Date: Sat, 13 Jun 2009 01:58:53 +0200
In-Reply-To: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	(Joakim Tjernlund's message of "Fri\,
	12 Jun 2009 23\:26\:50 +0200")
Message-ID: <m3ab4dovgi.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:

> Currently the bridge does not impl. split horizon which will easily
> cause loops when 2 or more VLANs are added from the same physical interface.

Why would they cause loops? If your topology isn't loop free, run
spanning tree in the VLAN's. Yet another thing most hardware switches
can't do, incidentally.


/Benny

