Subject: Re: [Bridge] Is it possible to put an aliased ethernet card on a
	bridge?
From: Brad Dameron <brad.dameron@clearwire.com>
In-Reply-To: <bcba51a0706131332p4aef4a38sdc9cafd726528cd9@mail.gmail.com>
References: <bcba51a0706131332p4aef4a38sdc9cafd726528cd9@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Jun 2007 13:51:42 -0700
Message-Id: <1181767902.28541.1.camel@linux-2n2q.site>
Mime-Version: 1.0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dimitry Golubovsky <golubovsky@gmail.com>
Cc: bridge@lists.linux-foundation.org



On Wed, 2007-06-13 at 16:32 -0400, Dimitry Golubovsky wrote:
> Hi,
> 
> Suppose we have two aliases of the same ethernet card:
> 
> ifconfig eth0 192.168.0.1
> ifconfig eth0:1 192.168.1.1
> 
> Is it possible to add eth0:1 to a bridge, not adding its "physical parent" eth0?
> 
> Sorry if this was answered before.
> 
> Thanks.
> 


Yes this is allowed. Along with eth0.10:1 which is a VLAN tagged
interface with an alias.

Brad Dameron
Systems Engineer
Clearw're

