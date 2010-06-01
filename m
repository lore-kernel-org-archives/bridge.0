Date: Tue, 1 Jun 2010 09:15:10 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100601091510.38a77a06@nehalam>
In-Reply-To: <B56B1B98C23D084F9E69AFCF8A51D84B0292E01363@inbmail02.lsi.com>
References: <B56B1B98C23D084F9E69AFCF8A51D84B0292E01363@inbmail02.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Multicasting and Bridged networking issue
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Singh, Animesh" <Animesh.Singh@lsi.com>
Cc: "bridge@osdl.org" <bridge@linux-foundation.org>

On Tue, 1 Jun 2010 15:08:19 +0530
"Singh, Animesh" <Animesh.Singh@lsi.com> wrote:

> Hi,
>     Have been experimenting with bridged networking in order to connect VMs located on separate physical machines. Unicast communication works fine but multicast traffic in not being forwarded beyond the bridge. Looking at the code am reaching the conclusion that bridge treats multicast traffic in same way as broadcast, so why the multicast traffic is not flowing beyond the bridge. Also does kernel tunable like mc_forwarding have any significance in this matter? On the later version of linux 2.6.18 and after am finding this tunable as read-only (and set to 0). The kernel being used has CONFIG_IP_MROUTE enabled but its not running mrouted.
> 

Are you using VMware? VMware doesn't really allow for bridging.
