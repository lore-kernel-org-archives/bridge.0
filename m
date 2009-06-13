In-Reply-To: <2e59e6970906122139h676b76f5s64d3b8074065d6c3@mail.gmail.com>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2e59e6970906122139h676b76f5s64d3b8074065d6c3@mail.gmail.com>
Message-ID: <OF904A7027.08DBDBD1-ONC12575D4.0056F6F3-C12575D4.005832FC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 13 Jun 2009 18:03:22 +0200
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
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

"richardvoigt@gmail.com" <richardvoigt@gmail.com> wrote on 13/06/2009 06:39:50:
>
> On Fri, Jun 12, 2009 at 4:26 PM, Joakim
> Tjernlund<Joakim.Tjernlund@transmode.se> wrote:
> > Currently the bridge does not impl. split horizon which will easily
> > cause loops when 2 or more VLANs are added from the same physical interface.
>
> I call shenanigans.  Got multiple VLANs from the same physical

No idea what that means, nothing good I suspect :)

> interface added to a bridge and no loops, almost no trouble of any
> sort.  A second bridge on the same router has loops, uses spanning
> tree to shut one VLAN down selectively (to automatically bypass a
> traffic shaper appliance with a history of failure) and the only
> trouble is that the PDUs sent by spanning tree cause klog warnings
> when they come back to the other VLAN of the same physical interface.

ehh, not sure, but this doesn't sound like you have two Linux bridges
connected or you do but STP has closed one of the VLAN interfaces.

>
> And I don't think split horizon means what you think it does.

hmm, what does it mean then? Googling suggest that split horizon prevents
a pkg to be forwarded back over the same interface.
Perhaps you have a better name?

    Jocke

