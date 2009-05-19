Date: Tue, 19 May 2009 15:21:53 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090519152153.012d4814@nehalam>
In-Reply-To: <20090511114639.440944109@openvz.org>
References: <20090511114639.440944109@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC 0/5] bridge - introduce via_phys_dev feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, xemul@openvz.org

On Mon, 11 May 2009 15:46:39 +0400
Cyrill Gorcunov <gorcunov@openvz.org> wrote:

> Hi,
> 
> here is RFC for new via_phys_dev bridge feature.
> In short -- it allows to use some bridge port as
> bridge itself with already configured routing table.
> 
> More details with example you may found in patches.
> 
> Please review. Any (including _complains_) comments are
> highly appreciated!
> 
> The series is on top of current -net-next-2.6
> 
> 	| commit ed9b58bc443a1210b5be1ded6421b17e015bf985
> 	| Author Richard Genoud <richard.genoud@gmail.com>
> 	| Date Sat May 9 06:59:16 2009 +0000
> 
> Cyrill
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Do not really like this patch set. It adds more complexity to solve a problem
that looks like it can be solved by other means.
