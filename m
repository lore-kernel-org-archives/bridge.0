In-Reply-To: <m3ab4dovgi.fsf@ursa.amorsen.dk>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<m3ab4dovgi.fsf@ursa.amorsen.dk>
Message-ID: <OFCE5E72FE.D082AB78-ONC12575D4.005256D7-C12575D4.0052B193@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 17:03:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] [bridge] Add split horizon
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: bridge@lists.linux-foundation.org

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 13/06/2009 01:58:53:
>
> Joakim Tjernlund <Joakim.Tjernlund@transmode.se> writes:
>
> > Currently the bridge does not impl. split horizon which will easily
> > cause loops when 2 or more VLANs are added from the same physical interface.
>
> Why would they cause loops? If your topology isn't loop free, run
> spanning tree in the VLAN's. Yet another thing most hardware switches
> can't do, incidentally.

ehh, connect two Linux bridges that have 2 VLANs in common on the interswitch connection.
What happens?

  Jocke

