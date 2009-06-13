MIME-Version: 1.0
In-Reply-To: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1244842010-24945-1-git-send-email-Joakim.Tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 23:39:50 -0500
Message-ID: <2e59e6970906122139h676b76f5s64d3b8074065d6c3@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

On Fri, Jun 12, 2009 at 4:26 PM, Joakim
Tjernlund<Joakim.Tjernlund@transmode.se> wrote:
> Currently the bridge does not impl. split horizon which will easily
> cause loops when 2 or more VLANs are added from the same physical interface.

I call shenanigans.  Got multiple VLANs from the same physical
interface added to a bridge and no loops, almost no trouble of any
sort.  A second bridge on the same router has loops, uses spanning
tree to shut one VLAN down selectively (to automatically bypass a
traffic shaper appliance with a history of failure) and the only
trouble is that the PDUs sent by spanning tree cause klog warnings
when they come back to the other VLAN of the same physical interface.

And I don't think split horizon means what you think it does.
