Date: Thu, 9 Jul 2009 12:55:00 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090709125500.5f8cf2a0@nehalam>
In-Reply-To: <20090704062320.774818680@openvz.org>
References: <20090704061156.658235360@openvz.org>
	<20090704062320.774818680@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch 1/2] net, bridge: align br_nf_ops assignment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Sat, 04 Jul 2009 10:11:57 +0400
Cyrill Gorcunov <gorcunov@openvz.org> wrote:

> No functional change -- just for easier reading.
> 
> Signed-off-by: Cyrill Gorcunov <gorcunov@openvz.org>
> ---
>  net/bridge/br_netfilter.c |   96 ++++++++++++++++++++++++++--------------------
>  1 file changed, 56 insertions(+), 40 deletions(-)
> 


Acked-by: Stephen Hemminger <shemminger@vyatta.com>

-- 
