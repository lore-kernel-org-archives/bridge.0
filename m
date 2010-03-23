Message-ID: <4BA84E6C.5030503@redhat.com>
Date: Tue, 23 Mar 2010 13:15:24 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <4BA823D7.4010106@redhat.com>	<20100322.204939.146100390.davem@davemloft.net>	<4BA847EB.9040808@redhat.com>
	<20100322.215822.123414773.davem@davemloft.net>
In-Reply-To: <20100322.215822.123414773.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC Patch 1/3] netpoll: add generic support for
 bridge and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: fubar@us.ibm.com, nhorman@tuxdriver.com, netdev@vger.kernel.org, mpm@selenic.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmoyer@redhat.com, gospo@redhat.com, bonding-devel@lists.sourceforge.net

David Miller wrote:
> From: Cong Wang <amwang@redhat.com>
> Date: Tue, 23 Mar 2010 12:47:39 +0800
> 
>> Yeah, for bonding case, probably. But for bridge case, I think
>> we still need to check all, right?
> 
> Why?  Who cares?
> 
> If it goes out one port and reaches it's destination
> the objective has been achieved.
> 
> Sending it out N more times achieves nothing.

We have to check which port has the right destination.

Ideally we should check the right destination address to
choose the port, but currently we don't have a generic
way to check this, thus I chose to send it to all ports.
You are right, this needs to be improved.

Thanks!

