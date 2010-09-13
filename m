Date: Mon, 13 Sep 2010 07:54:19 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100913075419.4d70f1c8@nehalam>
In-Reply-To: <AANLkTi=Qi36akPjHb4UJTXhDPW0tCrS7MC4CyAXSDBO4@mail.gmail.com>
References: <AANLkTi=Qi36akPjHb4UJTXhDPW0tCrS7MC4CyAXSDBO4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] help needed regarding configuration for bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: debasis das <fordebasis@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 13 Sep 2010 15:11:21 +0530
debasis das <fordebasis@gmail.com> wrote:

> Hi all,
>         I have a Linux box with 3 interfaces eth0,eth1 and eth2.
>         Could anyone please let me know whether the following configuration
> would be valid :
> 
> *#brctl addbr br1
> #brctl addif br1 eth1
> #ifconfig br1 up
> # brctl show
> bridge name     bridge id               STP enabled     interfaces
> br1             8000.001000000007       no              eth1
> 
> 
> # brctl addbr br0
> # brctl addif br0 eth0
> # ifconfig br0 up
> # vconfig add br0 5
> # brctl addif br1 br0.5

A bridge can not be added to a bridge.

-- 
